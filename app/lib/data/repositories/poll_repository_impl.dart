import 'package:dartz/dartz.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/data/datasources/remote_data_source.dart';
import 'package:app/data/models/vote_request_model.dart';
import 'package:app/domain/entities/poll_entity.dart';
import 'package:app/domain/entities/poll_results_entity.dart';
import 'package:app/domain/entities/vote_entity.dart';
import 'package:app/domain/failures/failures.dart';
import 'package:app/domain/repositories/poll_repository.dart';

/// Implementación del repositorio de encuestas (Data Layer)
/// Convierte excepciones en Failures y modelos en entidades
class PollRepositoryImpl implements PollRepository {
  final RemoteDataSource remoteDataSource;

  PollRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PollEntity>>> getPolls() async {
    try {
      final polls = await remoteDataSource.getPolls();
      final entities = polls.map((poll) => poll.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, PollEntity>> getPollByToken(String token) async {
    try {
      final poll = await remoteDataSource.getPollByToken(token);
      return Right(poll.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, VoteEntity>> voteOnPoll({
    required String pollToken,
    required int selection,
  }) async {
    try {
      final request = VoteRequestModel(
        pollToken: pollToken,
        selection: selection,
      );

      final voteResponse = await remoteDataSource.voteOnPoll(request);
      return Right(voteResponse.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, PollResultsEntity>> getPollResults(
      String pollToken) async {
    try {
      final results = await remoteDataSource.getPollResults(pollToken);
      return Right(results.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure('Error inesperado: $e'));
    }
  }
}
