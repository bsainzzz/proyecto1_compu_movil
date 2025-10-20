import 'dart:convert';
import 'package:app/domain/entities/poll_results_entity.dart';

/// Modelo de resultados de encuesta (Data Layer)
/// Respuesta real API: {"name": string, "results": [{choice, total}]}
class PollResultsModel {
  final String name;
  final List<OptionResultModel> results;

  PollResultsModel({
    required this.name,
    required this.results,
  });

  /// Convierte el modelo a entidad de dominio
  PollResultsEntity toEntity() {
    return PollResultsEntity(
      name: name,
      results: results.map((result) => result.toEntity()).toList(),
    );
  }

  /// Crea un modelo desde JSON
  factory PollResultsModel.fromJson(Map<String, dynamic> json) {
    return PollResultsModel(
      name: json['name'] as String,
      results: (json['results'] as List<dynamic>)
          .map((result) =>
              OptionResultModel.fromJson(result as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convierte el modelo a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }

  /// Crea un modelo desde un string JSON
  factory PollResultsModel.fromRawJson(String str) =>
      PollResultsModel.fromJson(json.decode(str));

  /// Convierte el modelo a un string JSON
  String toRawJson() => json.encode(toJson());
}

/// Modelo de resultado de opción
/// Respuesta real API: {"choice": string, "total": int}
class OptionResultModel {
  final String choice;
  final int total;

  OptionResultModel({
    required this.choice,
    required this.total,
  });

  /// Convierte el modelo a entidad de dominio
  OptionResultEntity toEntity() {
    return OptionResultEntity(
      choice: choice,
      total: total,
    );
  }

  factory OptionResultModel.fromJson(Map<String, dynamic> json) {
    return OptionResultModel(
      choice: json['choice'] as String,
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'choice': choice,
      'total': total,
    };
  }
}
