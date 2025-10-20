import 'package:equatable/equatable.dart';

/// Entidad de voto (Domain Layer)
class VoteEntity extends Equatable {
  final bool ok;
  final String message;
  final DateTime created;

  const VoteEntity({
    required this.ok,
    required this.message,
    required this.created,
  });

  /// Verifica si el voto fue exitoso
  bool get isSuccessful => ok;

  @override
  List<Object?> get props => [ok, message, created];
}
