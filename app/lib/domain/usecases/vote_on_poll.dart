import 'package:dartz/dartz.dart';
import 'package:app/domain/entities/vote_entity.dart';
import 'package:app/domain/failures/failures.dart';
import 'package:app/domain/repositories/poll_repository.dart';

/// Parámetros para el caso de uso VoteOnPoll
class VoteOnPollParams {
  final String pollToken;
  final int selection;

  VoteOnPollParams({
    required this.pollToken,
    required this.selection,
  });
}

/// Caso de uso: Votar en una encuesta
/// Encapsula la lógica de negocio para registrar un voto
class VoteOnPoll {
  final PollRepository repository;

  VoteOnPoll(this.repository);

  /// Ejecuta el caso de uso
  /// [params] - Parámetros del voto (pollToken, selection)
  Future<Either<Failure, VoteEntity>> call(VoteOnPollParams params) async {
    // Validaciones de negocio
    if (params.pollToken.isEmpty) {
      return const Left(
          ClientFailure('El token de la encuesta no puede estar vacío'));
    }

    if (params.selection <= 0) {
      return const Left(ClientFailure('Debes seleccionar una opción válida'));
    }

    return await repository.voteOnPoll(
      pollToken: params.pollToken,
      selection: params.selection,
    );
  }
}
