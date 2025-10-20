import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:app/data/api/endpoints.dart';

/// Cliente HTTP configurado con Dio
/// Incluye configuración de timeouts, interceptores y manejo de errores
class ApiClient {
  late final Dio _dio;
  final Logger _logger = Logger();

  ApiClient({String? authToken}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout:
            const Duration(milliseconds: ApiEndpoints.connectionTimeout),
        receiveTimeout:
            const Duration(milliseconds: ApiEndpoints.receiveTimeout),
        sendTimeout: const Duration(milliseconds: ApiEndpoints.sendTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
        validateStatus: (status) {
          // Acepta todos los códigos de estado para manejarlos manualmente
          return status != null && status < 500;
        },
      ),
    );

    _setupInterceptors();
  }

  /// Configura los interceptores de Dio
  void _setupInterceptors() {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (object) => _logger.d(object),
      ),
    );

    // Interceptor personalizado para reintentos
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          _logger.e(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
          );
          return handler.next(error);
        },
      ),
    );
  }

  /// Actualiza el token de autenticación
  void updateAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Elimina el token de autenticación
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Obtiene la instancia de Dio (para casos especiales)
  Dio get dio => _dio;
}
