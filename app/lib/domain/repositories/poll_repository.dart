import 'package:dartz/dartz.dart';
import 'package:app/domain/entities/poll_entity.dart';
import 'package:app/domain/entities/poll_results_entity.dart';
import 'package:app/domain/entities/vote_entity.dart';
import 'package:app/domain/failures/failures.dart';

/// Interfaz del repositorio de encuestas (Domain Layer)
/// Define los contratos que debe cumplir la implementación en la capa de datos
abstract class PollRepository {
  /// Obtiene la lista de todas las encuestas
  /// Retorna Either<Failure, List<PollEntity>>
  Future<Either<Failure, List<PollEntity>>> getPolls();

  /// Obtiene una encuesta específica por su token
  /// Retorna Either<Failure, PollEntity>
  Future<Either<Failure, PollEntity>> getPollByToken(String token);

  /// Registra un voto en una encuesta
  /// [pollToken] - Token de la encuesta
  /// [selection] - Número de la opción seleccionada
  /// Retorna Either<Failure, VoteEntity>
  Future<Either<Failure, VoteEntity>> voteOnPoll({
    required String pollToken,
    required int selection,
  });

  /// Obtiene los resultados de una encuesta
  /// [pollToken] - Token de la encuesta
  /// Retorna Either<Failure, PollResultsEntity>
  Future<Either<Failure, PollResultsEntity>> getPollResults(String pollToken);
}
