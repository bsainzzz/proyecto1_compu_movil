import 'package:dartz/dartz.dart';
import 'package:app/domain/entities/poll_entity.dart';
import 'package:app/domain/failures/failures.dart';
import 'package:app/domain/repositories/poll_repository.dart';

/// Caso de uso: Obtener una encuesta por token
class GetPollByToken {
  final PollRepository repository;

  GetPollByToken(this.repository);

  /// Ejecuta el caso de uso
  /// [token] - Token de la encuesta a obtener
  Future<Either<Failure, PollEntity>> call(String token) async {
    if (token.isEmpty) {
      return const Left(ClientFailure('El token no puede estar vacío'));
    }
    return await repository.getPollByToken(token);
  }
}
