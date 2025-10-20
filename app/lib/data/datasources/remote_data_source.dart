import 'package:dio/dio.dart';
import 'package:app/core/errors/error_handler.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/data/api/client.dart';
import 'package:app/data/api/endpoints.dart';
import 'package:app/data/models/poll_model.dart';
import 'package:app/data/models/poll_results_model.dart';
import 'package:app/data/models/vote_request_model.dart';
import 'package:app/data/models/vote_response_model.dart';

/// Interfaz del Remote Data Source
abstract class RemoteDataSource {
  Future<List<PollModel>> getPolls();
  Future<PollModel> getPollByToken(String token);
  Future<VoteResponseModel> voteOnPoll(VoteRequestModel request);
  Future<PollResultsModel> getPollResults(String pollToken);
}

/// Implementación del Remote Data Source
/// Maneja toda la comunicación con la API externa
class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiClient client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<PollModel>> getPolls() async {
    try {
      final response = await client.get<dynamic>(
        ApiEndpoints.polls,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          throw const ServerException('Respuesta vacía del servidor');
        }

        // Si la respuesta es directamente una lista
        if (data is List) {
          return data
              .map((poll) => PollModel.fromJson(poll as Map<String, dynamic>))
              .toList();
        }

        // Si la respuesta es un objeto Map
        if (data is Map<String, dynamic>) {
          // Si tiene una clave 'polls' con una lista
          if (data.containsKey('polls')) {
            final pollsList = data['polls'] as List<dynamic>;
            return pollsList
                .map((poll) => PollModel.fromJson(poll as Map<String, dynamic>))
                .toList();
          }
        }

        throw const FormatException('Formato de respuesta inválido');
      } else {
        throw ServerException(
          'Error al obtener encuestas',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<PollModel> getPollByToken(String token) async {
    try {
      final response = await client.get<Map<String, dynamic>>(
        ApiEndpoints.pollByToken(token),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          throw const ServerException('Respuesta vacía del servidor');
        }

        return PollModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw const ClientException(
          'Encuesta no encontrada',
          statusCode: 404,
        );
      } else {
        throw ServerException(
          'Error al obtener encuesta',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<VoteResponseModel> voteOnPoll(VoteRequestModel request) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        ApiEndpoints.vote,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data == null) {
          throw const ServerException('Respuesta vacía del servidor');
        }

        return VoteResponseModel.fromJson(data);
      } else if (response.statusCode == 400) {
        throw const ClientException(
          'Datos de voto inválidos',
          statusCode: 400,
        );
      } else if (response.statusCode == 409) {
        throw const ClientException(
          'Ya has votado en esta encuesta',
          statusCode: 409,
        );
      } else {
        throw ServerException(
          'Error al registrar voto',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<PollResultsModel> getPollResults(String pollToken) async {
    try {
      final response = await client.get<Map<String, dynamic>>(
        ApiEndpoints.pollResults(pollToken),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          throw const ServerException('Respuesta vacía del servidor');
        }

        return PollResultsModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw const ClientException(
          'Resultados no encontrados',
          statusCode: 404,
        );
      } else {
        throw ServerException(
          'Error al obtener resultados',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException('Error inesperado: $e');
    }
  }
}
