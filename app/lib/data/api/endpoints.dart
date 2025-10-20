/// Endpoints de la API de votación
/// Documentación: https://api.sebastian.cl/vote/swagger-ui/index.html
class ApiEndpoints {
  ApiEndpoints._();

  // Base URL
  static const String baseUrl = 'https://api.sebastian.cl/vote';

  // API Version
  static const String apiVersion = 'v1';

  // Encuestas
  static const String polls = '/$apiVersion/polls/';
  static String pollByToken(String token) => '/$apiVersion/polls/$token';

  // Votaciones
  static const String vote = '/$apiVersion/vote/election';
  static String pollResults(String pollToken) =>
      '/$apiVersion/vote/$pollToken/results';

  // Timeouts (en milisegundos)
  static const int connectionTimeout = 30000; // 30 segundos
  static const int receiveTimeout = 30000; // 30 segundos
  static const int sendTimeout = 30000; // 30 segundos
}
