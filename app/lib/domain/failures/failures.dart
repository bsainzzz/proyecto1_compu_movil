/// Failures representan errores en la capa de dominio
/// Son el resultado de convertir excepciones en objetos que la UI puede manejar

import 'package:equatable/equatable.dart';

/// Failure base abstracto
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Fallo de servidor (5xx)
class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}

/// Fallo de cliente/validación (4xx)
class ClientFailure extends Failure {
  const ClientFailure(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}

/// Fallo de red (sin conexión, timeout)
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

/// Fallo de autenticación
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}

/// Fallo de caché
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

/// Fallo inesperado
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message) : super(message);
}
