import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/models/in.dart';

enum UpdateUtenteStatus { initial, loading, success, failure }

enum GetUtenteStatus { initial, loading, success, failure }

class UtenteState extends Equatable {
  final UpdateUtenteStatus updateUtentiStatus;
  final GetUtenteStatus getUtenteStatus;
  final Utente utente;
  final String error;

  const UtenteState({
    required this.updateUtentiStatus,
    required this.getUtenteStatus,
    required this.utente,
    required this.error,
  });

  factory UtenteState.initial() {
    return UtenteState(
        updateUtentiStatus: UpdateUtenteStatus.initial,
        getUtenteStatus: GetUtenteStatus.initial,
        utente: Utente.initial(),
        error: '');
  }

  UtenteState copyWith({
    UpdateUtenteStatus? updateUtentiStatus,
    GetUtenteStatus? getUtenteStatus,
    Utente? utente,
    String? error,
  }) {
    return UtenteState(
      updateUtentiStatus: updateUtentiStatus ?? this.updateUtentiStatus,
      getUtenteStatus: getUtenteStatus ?? this.getUtenteStatus,
      utente: utente ?? this.utente,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [updateUtentiStatus, getUtenteStatus, utente, error];

  @override
  String toString() {
    return 'UtenteState{utentiStatus: $updateUtentiStatus, utenteStatus: $getUtenteStatus, utente: $utente, error: $error}';
  }
}
