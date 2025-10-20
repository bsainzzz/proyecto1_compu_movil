import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/data/api/client.dart';
import 'package:app/presentation/providers/poll_providers.dart';

/// Clase para configurar la inyección de dependencias
/// Centraliza la inicialización de servicios y dependencias
class DependencyInjection {
  DependencyInjection._();

  /// Inicializa todas las dependencias necesarias
  static Future<void> init() async {
    // Aquí puedes agregar inicializaciones adicionales si es necesario
    // Por ejemplo: Firebase, SharedPreferences, etc.
  }

  /// Actualiza el token de autenticación en el cliente API
  static void updateAuthToken(WidgetRef ref, String token) {
    final client = ref.read(apiClientProvider);
    client.updateAuthToken(token);
  }

  /// Elimina el token de autenticación
  static void clearAuthToken(WidgetRef ref) {
    final client = ref.read(apiClientProvider);
    client.clearAuthToken();
  }
}
