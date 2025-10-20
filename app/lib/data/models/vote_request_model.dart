import 'dart:convert';

/// Modelo de solicitud de voto (Data Layer)
/// Respuesta real API: {"pollToken": string, "selection": int}
/// NO usa "userEmail" - se obtiene del JWT
class VoteRequestModel {
  final String pollToken;
  final int selection;

  VoteRequestModel({
    required this.pollToken,
    required this.selection,
  });

  /// Convierte el modelo a JSON
  Map<String, dynamic> toJson() {
    return {
      'pollToken': pollToken,
      'selection': selection,
    };
  }

  /// Convierte el modelo a un string JSON
  String toRawJson() => json.encode(toJson());

  /// Crea un modelo desde JSON
  factory VoteRequestModel.fromJson(Map<String, dynamic> json) {
    return VoteRequestModel(
      pollToken: json['pollToken'] as String,
      selection: json['selection'] as int,
    );
  }
}
