import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/data/api/client.dart';
import 'package:app/data/datasources/remote_data_source.dart';
import 'package:app/data/repositories/poll_repository_impl.dart';
import 'package:app/domain/repositories/poll_repository.dart';
import 'package:app/domain/usecases/get_poll_by_token.dart';
import 'package:app/domain/usecases/get_poll_results.dart';
import 'package:app/domain/usecases/get_polls.dart';
import 'package:app/domain/usecases/vote_on_poll.dart';

/// Provider del cliente HTTP
/// Se puede actualizar el token mediante ref.read(apiClientProvider.notifier).updateToken(token)
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

/// Provider del Remote Data Source
final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  final client = ref.watch(apiClientProvider);
  return RemoteDataSourceImpl(client: client);
});

/// Provider del repositorio de encuestas
final pollRepositoryProvider = Provider<PollRepository>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return PollRepositoryImpl(remoteDataSource: remoteDataSource);
});

/// Provider del caso de uso: Obtener encuestas
final getPollsUseCaseProvider = Provider<GetPolls>((ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return GetPolls(repository);
});

/// Provider del caso de uso: Obtener encuesta por token
final getPollByTokenUseCaseProvider = Provider<GetPollByToken>((ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return GetPollByToken(repository);
});

/// Provider del caso de uso: Votar en encuesta
final voteOnPollUseCaseProvider = Provider<VoteOnPoll>((ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return VoteOnPoll(repository);
});

/// Provider del caso de uso: Obtener resultados
final getPollResultsUseCaseProvider = Provider<GetPollResults>((ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return GetPollResults(repository);
});
