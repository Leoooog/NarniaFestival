import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/models/in.dart';

enum RistorantiStatus { initial, loading, success, failure }

enum RistoranteStatus { initial, loading, success, failure }

class RistoranteState extends Equatable {
  final RistorantiStatus ristorantiStatus;
  final RistoranteStatus ristoranteStatus;
  final List<Ristorante> ristoranti;
  final Ristorante ristorante;
  final String error;

  const RistoranteState({
    required this.ristorantiStatus,
    required this.ristoranteStatus,
    required this.ristoranti,
    required this.ristorante,
    required this.error,
  });

  factory RistoranteState.initial() {
    return RistoranteState(
        ristorantiStatus: RistorantiStatus.initial,
        ristoranteStatus: RistoranteStatus.initial,
        ristoranti: const [],
        ristorante: Ristorante.initial(),
        error: '');
  }

  RistoranteState copyWith({
    RistorantiStatus? ristorantiStatus,
    RistoranteStatus? ristoranteStatus,
    List<Ristorante>? ristoranti,
    Ristorante? ristorante,
    String? error,
  }) {
    return RistoranteState(
      ristorantiStatus: ristorantiStatus ?? this.ristorantiStatus,
      ristoranteStatus: ristoranteStatus ?? this.ristoranteStatus,
      ristoranti: ristoranti ?? this.ristoranti,
      ristorante: ristorante ?? this.ristorante,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [ristorantiStatus, ristoranteStatus, ristoranti, ristorante, error];

  @override
  String toString() {
    return 'RistoranteState{ristorantiStatus: $ristorantiStatus, ristoranteStatus: $ristoranteStatus, ristoranti: $ristoranti, ristorante: $ristorante, error: $error}';
  }
}
