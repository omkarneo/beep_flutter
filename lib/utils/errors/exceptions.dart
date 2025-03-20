class CustomException implements Exception {
  final String msg;

  CustomException(this.msg);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(this.message);
  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
  @override
  String toString() => message;
}

class NotProperBody implements Exception {
  final String message;
  NotProperBody(this.message);
  @override
  String toString() => message;
}

class ServerErrorException implements Exception {
  final String message;
  ServerErrorException(this.message);
  @override
  String toString() => message;
}

class UnknownErrorException implements Exception {
  final String message;
  UnknownErrorException(this.message);
  @override
  String toString() => message;
}
