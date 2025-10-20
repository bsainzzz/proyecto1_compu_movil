import 'package:dartz/dartz.dart';
import 'package:app/domain/entities/poll_entity.dart';
import 'package:app/domain/failures/failures.dart';
import 'package:app/domain/repositories/poll_repository.dart';

/// Caso de uso: Obtener lista de encuestas
/// Encapsula la lógica de negocio para obtener todas las encuestas
class GetPolls {
  final PollRepository repository;

  GetPolls(this.repository);

  /// Ejecuta el caso de uso
  Future<Either<Failure, List<PollEntity>>> call() async {
    return await repository.getPolls();
  }
}
