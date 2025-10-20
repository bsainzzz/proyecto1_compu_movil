import 'dart:convert';
import 'package:app/domain/entities/poll_entity.dart';

/// Modelo de datos de encuesta (Data Layer)
/// Mapea directamente con la respuesta REAL de la API
/// Respuesta real: {"token", "name", "active", "owner", "options"}
class PollModel {
  final String token;
  final String name;
  final bool active;
  final bool owner;
  final List<PollOptionModel> options;

  PollModel({
    required this.token,
    required this.name,
    required this.active,
    required this.owner,
    required this.options,
  });

  /// Convierte el modelo a entidad de dominio
  PollEntity toEntity() {
    return PollEntity(
      token: token,
      name: name,
      active: active,
      owner: owner,
      options: options.map((option) => option.toEntity()).toList(),
    );
  }

  /// Crea un modelo desde JSON
  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      token: json['token'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
      owner: json['owner'] as bool,
      options: (json['options'] as List<dynamic>?)
              ?.map((option) =>
                  PollOptionModel.fromJson(option as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Convierte el modelo a JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
      'active': active,
      'owner': owner,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }

  /// Crea un modelo desde un string JSON
  factory PollModel.fromRawJson(String str) =>
      PollModel.fromJson(json.decode(str));

  /// Convierte el modelo a un string JSON
  String toRawJson() => json.encode(toJson());
}

/// Modelo de opción de encuesta
/// Respuesta real: {"selection": int, "choice": string}
class PollOptionModel {
  final int selection;
  final String choice;

  PollOptionModel({
    required this.selection,
    required this.choice,
  });

  /// Convierte el modelo a entidad de dominio
  PollOptionEntity toEntity() {
    return PollOptionEntity(
      selection: selection,
      choice: choice,
    );
  }

  factory PollOptionModel.fromJson(Map<String, dynamic> json) {
    return PollOptionModel(
      selection: json['selection'] as int,
      choice: json['choice'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selection': selection,
      'choice': choice,
    };
  }
}
