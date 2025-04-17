import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

/// Loads environment variables from a `.env` file.
///
/// ## usage
///
/// Once you call (dotenv.load), the env variables can be accessed as a map
/// using the env getter of dotenv (dotenv.env).
/// You may wish to prefix the import.
///
///     import 'package:flutter_dotenv/flutter_dotenv.dart';
///
///     void main() async {
///       await dotenv.load();
///       var x = dotenv.env['foo'];
///       // ...
///     }
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = const ['host', 'port'];
///     bool get hasEnv => dotenv.isEveryDefined(_requiredEnvVars);
///

EnvHelper envHelper = EnvHelper();

class EnvHelper {
  bool _isInitialized = false;
  final Map<String, String> _envMap = {};

  /// A copy of variables loaded at runtime from a file + any entries from mergeWith when loaded.
  Map<String, String> get env {
    if (!_isInitialized) {
      throw NotInitializedError();
    }
    return _envMap;
  }

  bool get isInitialized => _isInitialized;

  /// Clear [env]
  void clean() => _envMap.clear();

  String? get(String name, {String? fallback}) {
    final value = maybeGet(name, fallback: fallback);
    if (value == null) {
      return null;
    }
    return value;
  }

  bool forInternalTesting() {
    if (get("Internal_Testing") != null) {
      return get("Internal_Testing") == "false"
          ? false
          : get("Internal_Testing") == "true"
              ? true
              : false;
    } else {
      return false;
    }
  }

  bool forProd() {
    if (get("Is_Prod") != null) {
      return get("Is_Prod") == "false"
          ? false
          : get("Is_Prod") == "true"
              ? true
              : false;
    } else {
      return false;
    }
  }

  String? maybeGet(String name, {String? fallback}) => env[name] ?? fallback;

  /// Loads environment variables from the env file into a map
  /// Merge with any entries defined in [mergeWith]
  Future<void> load(
      {String fileName = '.env',
      Parser parser = const Parser(),
      Map<String, String> mergeWith = const {},
      bool isOptional = false}) async {
    clean();
    List<String> linesFromFile;
    try {
      linesFromFile = await _getEntriesFromFile(fileName);
    } on FileNotFoundError {
      if (isOptional) {
        linesFromFile = [];
      } else {
        rethrow;
      }
    }

    final linesFromMergeWith = mergeWith.entries
        .map((entry) => "${entry.key}=${entry.value}")
        .toList();
    final allLines = linesFromMergeWith..addAll(linesFromFile);
    final envEntries = parser.parse(allLines);
    _envMap.addAll(envEntries);
    _isInitialized = true;
  }

  void testLoad(
      {String fileInput = '',
      Parser parser = const Parser(),
      Map<String, String> mergeWith = const {}}) {
    clean();
    final linesFromFile = fileInput.split('\n');
    final linesFromMergeWith = mergeWith.entries
        .map((entry) => "${entry.key}=${entry.value}")
        .toList();
    final allLines = linesFromMergeWith..addAll(linesFromFile);
    final envEntries = parser.parse(allLines);
    _envMap.addAll(envEntries);
    _isInitialized = true;
  }

  /// True if all supplied variables have nonempty value; false otherwise.
  /// Differs from [containsKey](dart:core) by excluding null values.
  /// Note [load] should be called first.
  bool isEveryDefined(Iterable<String> vars) =>
      vars.every((k) => _envMap[k]?.isNotEmpty ?? false);

  Future<List<String>> _getEntriesFromFile(String filename) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      var envString = await rootBundle.loadString(filename);
      if (envString.isEmpty) {
        throw EmptyEnvFileError();
      }
      return envString.split('\n');
    } on FlutterError {
      throw FileNotFoundError();
    }
  }
}

class NotInitializedError extends Error {}

class FileNotFoundError extends Error {}

class EmptyEnvFileError extends Error {}

/// Creates key-value pairs from strings formatted as environment
/// variable definitions.
class Parser {
  static const _singleQuot = "'";
  static final _leadingExport = RegExp(r'''^ *export ?''');
  static final _comment = RegExp(r'''#[^'"]*$''');
  static final _commentWithQuotes = RegExp(r'''#.*$''');
  static final _surroundQuotes = RegExp(r'''^(["'])(.*?[^\\])\1''');
  static final _bashVar = RegExp(r'''(\\)?(\$)(?:{)?([a-zA-Z_][\w]*)+(?:})?''');

  /// [Parser] methods are pure functions.
  const Parser();

  /// Creates a [Map](dart:core).
  /// Duplicate keys are silently discarded.
  Map<String, String> parse(Iterable<String> lines) {
    var out = <String, String>{};
    for (var line in lines) {
      var kv = parseOne(line, env: out);
      if (kv.isEmpty) continue;
      out.putIfAbsent(kv.keys.single, () => kv.values.single);
    }
    return out;
  }

  /// Parses a single line into a key-value pair.
  Map<String, String> parseOne(String line,
      {Map<String, String> env = const {}}) {
    var stripped = strip(line);
    if (!_isValid(stripped)) return {};

    var idx = stripped.indexOf('=');
    var lhs = stripped.substring(0, idx);
    var k = swallow(lhs);
    if (k.isEmpty) return {};

    var rhs = stripped.substring(idx + 1, stripped.length).trim();
    var quotChar = surroundingQuote(rhs);
    var v = unquote(rhs);
    if (quotChar == _singleQuot) {
      v = v.replaceAll("\\'", "'");
      return {k: v};
    }
    if (quotChar == '"') {
      v = v.replaceAll('\\"', '"').replaceAll('\\n', '\n');
    }
    final interpolatedValue = interpolate(v, env).replaceAll("\\\$", "\$");
    return {k: interpolatedValue};
  }

  /// Substitutes $bash_vars in [val] with values from [env].
  String interpolate(String val, Map<String, String?> env) =>
      val.replaceAllMapped(_bashVar, (m) {
        if ((m.group(1) ?? "") == "\\") {
          return m.input.substring(m.start, m.end);
        } else {
          var k = m.group(3)!;
          if (!_has(env, k)) return '';
          return env[k]!;
        }
      });

  /// If [val] is wrapped in single or double quotes, returns the quote character.
  /// Otherwise, returns the empty string.

  String surroundingQuote(String val) {
    if (!_surroundQuotes.hasMatch(val)) return '';
    return _surroundQuotes.firstMatch(val)!.group(1)!;
  }

  /// Removes quotes (single or double) surrounding a value.
  String unquote(String val) {
    if (!_surroundQuotes.hasMatch(val)) {
      return strip(val, includeQuotes: true).trim();
    }
    return _surroundQuotes.firstMatch(val)!.group(2)!;
  }

  /// Strips comments (trailing or whole-line).
  String strip(String line, {bool includeQuotes = false}) =>
      line.replaceAll(includeQuotes ? _commentWithQuotes : _comment, '').trim();

  /// Omits 'export' keyword.
  String swallow(String line) => line.replaceAll(_leadingExport, '').trim();

  bool _isValid(String s) => s.isNotEmpty && s.contains('=');

  /// [ null ] is a valid value in a Dart map, but the env var representation is empty string, not the string 'null'
  bool _has(Map<String, String?> map, String key) =>
      map.containsKey(key) && map[key] != null;
}
