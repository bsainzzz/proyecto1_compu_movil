/// Excepciones personalizadas para la capa de datos
/// Estas excepciones son lanzadas por los datasources y capturadas por los repositorios

/// Excepción base para errores de la aplicación
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  const AppException(this.message, {this.statusCode, this.error});

  @override
  String toString() => message;
}

/// Excepción de servidor (5xx)
class ServerException extends AppException {
  const ServerException(
    String message, {
    int? statusCode,
    dynamic error,
  }) : super(message, statusCode: statusCode, error: error);
}

/// Excepción de cliente/validación (4xx)
class ClientException extends AppException {
  const ClientException(
    String message, {
    int? statusCode,
    dynamic error,
  }) : super(message, statusCode: statusCode, error: error);
}

/// Excepción de red (sin conexión, timeout)
class NetworkException extends AppException {
  const NetworkException(
    String message, {
    dynamic error,
  }) : super(message, error: error);
}

/// Excepción de autenticación (401, 403)
class AuthenticationException extends AppException {
  const AuthenticationException(
    String message, {
    int? statusCode,
    dynamic error,
  }) : super(message, statusCode: statusCode, error: error);
}

/// Excepción de caché/almacenamiento local
class CacheException extends AppException {
  const CacheException(
    String message, {
    dynamic error,
  }) : super(message, error: error);
}

/// Excepción de formato/serialización
class FormatException extends AppException {
  const FormatException(
    String message, {
    dynamic error,
  }) : super(message, error: error);
}
