import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_app/utils/constants/text_constants.dart';
import 'package:chat_app/utils/constants/url_constants.dart';
import 'package:chat_app/utils/errors/exceptions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'connection.dart';

class NetworkRequest {
  final Dio _dio = Dio()
    ..options = BaseOptions(
      validateStatus: (statusCode) => (statusCode ?? 500) != null,
    )
    ..interceptors.addAll(
      [
        PrettyDioLogger(
          request: !kReleaseMode,
          requestBody: !kReleaseMode,
          requestHeader: !kReleaseMode,
          error: !kReleaseMode,
          responseBody: !kReleaseMode,
          responseHeader: !kReleaseMode,
        ),
        // if needed interceptor
      ],
    );
  final NetworkInfo networkInfo;

  NetworkRequest({required this.networkInfo});

  Future<T> sendRequest<T>({
    required String method,
    required String url,
    dynamic body,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    /// Get User token from shared preferences to pass in every API call. remove line 21 once we have real token
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("user_token", "eyjjjjjasajshajshajshajshjashjahsjahs");
    // String? token = prefs.getString("user_token");
    // _dio.options.headers["authorization"] = "Bearer $token";
    print("$baseUrl$url");
    print(headers);
    headers ??= {};

    try {
      late Response response;
      print(body);
      switch (method) {
        case get:
          response = await _dio.get("$baseUrl$url",
              options:
                  Options(headers: headers, responseType: ResponseType.plain));
          break;
        case "FORMPOST":
          headers["accept"] = "application/json";
          var data = body;
          response = await _dio.post("$baseUrl$url",
              data: data,
              options:
                  Options(headers: headers, responseType: ResponseType.plain));
          break;
        case post:
          headers["accept"] = "application/json";
          var data = jsonEncode(body);
          print('Enc data --> $data');
          response = await _dio.post("$baseUrl$url",
              data: data,
              options:
                  Options(headers: headers, responseType: ResponseType.plain));
          break;
        case put:
          response = await _dio.put("$baseUrl$url",
              data: jsonEncode(body),
              options:
                  Options(headers: headers, responseType: ResponseType.plain));
          break;
        case patch:
          response = await _dio.patch("$baseUrl$url",
              data: jsonEncode(body),
              options:
                  Options(headers: headers, responseType: ResponseType.plain));
          break;
        case delete:
          response = await _dio.delete("$baseUrl$url",
              options:
                  Options(headers: headers, responseType: ResponseType.plain));
          break;
        default:
          throw Exception("$unsupporredHttpMethod $method");
      }
      // encryption
      //     ? (url!="/users/check-auth")?print(
      //         "Response::::${await CryptographyHelper.decryptMessage(response.data)}"):""
      //     : "";
      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        // print("response:${response.data}");\
        if (fromJson != null) {
          return fromJson(jsonDecode(await response.data));
        } else {
          return '$statusCode${response.statusCode}' as T;
        }
      } else if (response.statusCode == 401) {
        throw UnauthorizedException("$unauthorized: ${response.statusCode}");
      } else if (response.statusCode == 400) {
        throw UnauthorizedException("$unauthorized: ${response.statusCode}");
      } else if (response.statusCode == 403) {
        throw ForbiddenException("$forbidden: ${response.statusCode}");
      } else if (response.statusCode == 404) {
        throw NotFoundException("$notFound: ${response.statusCode}");
      } else if (response.statusCode == 422) {
        throw NotProperBody("$notFound: ${response.statusCode}");
      } else if (response.statusCode! >= 500) {
        throw ServerErrorException("$serverError: ${response.statusCode}");
      } else {
        //  print("::::::${jsonDecode( response.headers.toString())}");
        throw DioException(
          requestOptions: response.requestOptions,
          response: Response(
            requestOptions: response.requestOptions,
            data: response.headers.map.containsKey("x-content-encryption")
                ? jsonDecode(response.data)
                : jsonDecode(response.data),
          ),
          error: "$http ${response.statusCode}",
        );
      }
    } on DioException catch (error) {
      throw _handleError(error);
    } catch (error) {
      rethrow;
    }
  }

  Exception _handleError(DioException error) {
    return error;
  }
}
