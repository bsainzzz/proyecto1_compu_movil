import 'package:dartz/dartz.dart';
import 'package:app/domain/entities/poll_results_entity.dart';
import 'package:app/domain/failures/failures.dart';
import 'package:app/domain/repositories/poll_repository.dart';

/// Caso de uso: Obtener resultados de una encuesta
class GetPollResults {
  final PollRepository repository;

  GetPollResults(this.repository);

  /// Ejecuta el caso de uso
  /// [pollToken] - Token de la encuesta
  Future<Either<Failure, PollResultsEntity>> call(String pollToken) async {
    if (pollToken.isEmpty) {
      return const Left(ClientFailure('El token de la encuesta no puede estar vacío'));
    }
    return await repository.getPollResults(pollToken);
  }
}
