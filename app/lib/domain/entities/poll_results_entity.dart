import 'package:equatable/equatable.dart';

/// Entidad de resultados de encuesta (Domain Layer)
class PollResultsEntity extends Equatable {
  final String name;
  final List<OptionResultEntity> results;

  const PollResultsEntity({
    required this.name,
    required this.results,
  });

  /// Calcula el total de votos
  int get totalVotes => results.fold(0, (sum, result) => sum + result.total);

  @override
  List<Object?> get props => [name, results];
}

/// Entidad de resultado de opción
class OptionResultEntity extends Equatable {
  final String choice;
  final int total;

  const OptionResultEntity({
    required this.choice,
    required this.total,
  });

  /// Calcula el porcentaje de votos (requiere total global)
  double calculatePercentage(int globalTotal) {
    if (globalTotal == 0) return 0.0;
    return (total / globalTotal) * 100;
  }

  @override
  List<Object?> get props => [choice, total];
}
