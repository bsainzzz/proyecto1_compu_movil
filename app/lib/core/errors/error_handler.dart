import 'package:dio/dio.dart';
import 'package:app/core/errors/exceptions.dart';

/// Clase para manejar errores de Dio y convertirlos en excepciones personalizadas
class ErrorHandler {
  /// Convierte un DioException en una excepción personalizada
  static AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'Tiempo de espera agotado. Por favor, intenta nuevamente.',
          error: error,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          'Sin conexión a internet. Verifica tu conexión.',
          error: error,
        );

      case DioExceptionType.badResponse:
        return _handleStatusCode(error);

      case DioExceptionType.cancel:
        return const NetworkException('La solicitud fue cancelada.');

      case DioExceptionType.unknown:
        return NetworkException(
          'Error de conexión. Verifica tu conexión a internet.',
          error: error,
        );

      default:
        return NetworkException(
          'Error inesperado: ${error.message}',
          error: error,
        );
    }
  }

  /// Maneja los códigos de estado HTTP
  static AppException _handleStatusCode(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // Intentar extraer mensaje del servidor
    String message = 'Error en la solicitud';
    if (data is Map<String, dynamic>) {
      message = data['message'] ?? data['error'] ?? message;
    }

    switch (statusCode) {
      case 400:
        return ClientException(
          'Solicitud inválida: $message',
          statusCode: statusCode,
          error: error,
        );

      case 401:
        return AuthenticationException(
          'No autorizado. Por favor, inicia sesión nuevamente.',
          statusCode: statusCode,
          error: error,
        );

      case 403:
        return AuthenticationException(
          'Acceso denegado. No tienes permisos para esta acción.',
          statusCode: statusCode,
          error: error,
        );

      case 404:
        return ClientException(
          'Recurso no encontrado.',
          statusCode: statusCode,
          error: error,
        );

      case 409:
        return ClientException(
          'Conflicto: $message',
          statusCode: statusCode,
          error: error,
        );

      case 422:
        return ClientException(
          'Datos inválidos: $message',
          statusCode: statusCode,
          error: error,
        );

      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
        return ServerException(
          'Error del servidor. Intenta más tarde.',
          statusCode: statusCode,
          error: error,
        );

      default:
        if (statusCode != null && statusCode >= 400 && statusCode < 500) {
          return ClientException(
            message,
            statusCode: statusCode,
            error: error,
          );
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException(
            'Error del servidor.',
            statusCode: statusCode,
            error: error,
          );
        }
        return ServerException(
          'Error desconocido del servidor.',
          statusCode: statusCode,
          error: error,
        );
    }
  }

  /// Obtiene un mensaje amigable para el usuario basado en la excepción
  static String getUserMessage(AppException exception) {
    if (exception is NetworkException) {
      return exception.message;
    } else if (exception is AuthenticationException) {
      return exception.message;
    } else if (exception is ClientException) {
      return exception.message;
    } else if (exception is ServerException) {
      return 'Error del servidor. Por favor, intenta más tarde.';
    } else {
      return 'Ha ocurrido un error inesperado.';
    }
  }
}
