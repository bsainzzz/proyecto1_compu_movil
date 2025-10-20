import 'dart:convert';
import 'package:app/domain/entities/vote_entity.dart';

/// Modelo de respuesta de voto (Data Layer)
/// Respuesta real API: {"ok": boolean, "message": string, "created": datetime}
class VoteResponseModel {
  final bool ok;
  final String message;
  final DateTime created;

  VoteResponseModel({
    required this.ok,
    required this.message,
    required this.created,
  });

  /// Convierte el modelo a entidad de dominio
  VoteEntity toEntity() {
    return VoteEntity(
      ok: ok,
      message: message,
      created: created,
    );
  }

  /// Crea un modelo desde JSON
  factory VoteResponseModel.fromJson(Map<String, dynamic> json) {
    return VoteResponseModel(
      ok: json['ok'] as bool,
      message: json['message'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }

  /// Convierte el modelo a JSON
  Map<String, dynamic> toJson() {
    return {
      'ok': ok,
      'message': message,
      'created': created.toIso8601String(),
    };
  }

  /// Crea un modelo desde un string JSON
  factory VoteResponseModel.fromRawJson(String str) =>
      VoteResponseModel.fromJson(json.decode(str));

  /// Convierte el modelo a un string JSON
  String toRawJson() => json.encode(toJson());
}
