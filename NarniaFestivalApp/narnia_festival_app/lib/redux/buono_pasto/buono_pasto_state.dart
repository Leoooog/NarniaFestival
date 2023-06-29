import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/models/in.dart';

enum BuoniPastoStatus { initial, loading, success, failure }

enum BuonoPastoStatus { initial, loading, success, failure }

class BuonoPastoState extends Equatable {
  final BuoniPastoStatus buoniPastoStatus;
  final BuonoPastoStatus buonoPastoStatus;
  final List<BuonoPasto> buoniPasto;
  final BuonoPasto buonoPasto;
  final String error;

  const BuonoPastoState({
    required this.buoniPastoStatus,
    required this.buonoPastoStatus,
    required this.buoniPasto,
    required this.buonoPasto,
    required this.error,
  });

  factory BuonoPastoState.initial() {
    return BuonoPastoState(
        buoniPastoStatus: BuoniPastoStatus.initial,
        buonoPastoStatus: BuonoPastoStatus.initial,
        buoniPasto: const [],
        buonoPasto: BuonoPasto.initial(),
        error: '');
  }

  BuonoPastoState copyWith({
    BuoniPastoStatus? buoniPastoStatus,
    BuonoPastoStatus? buonoPastoStatus,
    List<BuonoPasto>? buoniPasto,
    BuonoPasto? buonoPasto,
    String? error,
  }) {
    return BuonoPastoState(
      buoniPastoStatus: buoniPastoStatus ?? this.buoniPastoStatus,
      buonoPastoStatus: buonoPastoStatus ?? this.buonoPastoStatus,
      buoniPasto: buoniPasto ?? this.buoniPasto,
      buonoPasto: buonoPasto ?? this.buonoPasto,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [buoniPastoStatus, buonoPastoStatus, buoniPasto, buonoPasto, error];

  @override
  String toString() {
    return 'BuonoPastoState{buoniPastoStatus: $buoniPastoStatus, buonoPastoStatus: $buonoPastoStatus, buoniPasto: $buoniPasto, buonoPasto: $buonoPasto, error: $error}';
  }
}
