import 'package:equatable/equatable.dart';

/// Entidad de encuesta (Domain Layer)
/// Representa la lógica de negocio independiente de la implementación
class PollEntity extends Equatable {
  final String token;
  final String name;
  final bool active;
  final bool owner;
  final List<PollOptionEntity> options;

  const PollEntity({
    required this.token,
    required this.name,
    required this.active,
    required this.owner,
    required this.options,
  });

  /// Verifica si la encuesta está activa
  bool get isActive => active;

  /// Verifica si el usuario es dueño de la encuesta
  bool get isOwner => owner;

  @override
  List<Object?> get props => [token, name, active, owner, options];
}

/// Entidad de opción de encuesta
class PollOptionEntity extends Equatable {
  final int selection;
  final String choice;

  const PollOptionEntity({
    required this.selection,
    required this.choice,
  });

  @override
  List<Object?> get props => [selection, choice];
}
