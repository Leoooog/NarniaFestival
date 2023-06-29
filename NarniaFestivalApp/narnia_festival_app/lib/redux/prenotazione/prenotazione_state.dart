import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/models/in.dart';

enum GetPrenotazioniStatus { initial, loading, success, failure }

enum GetPrenotazioneStatus { initial, loading, success, failure }

enum CreatePrenotazioneStatus { initial, loading, success, failure }

enum DeletePrenotazioneStatus { initial, loading, success, failure }

enum UpdatePrenotazioneStatus { initial, loading, success, failure }

class PrenotazioneState extends Equatable {
  final GetPrenotazioniStatus getPrenotazioniStatus;
  final GetPrenotazioneStatus getPrenotazioneStatus;
  final CreatePrenotazioneStatus createPrenotazioneStatus;
  final DeletePrenotazioneStatus deletePrenotazioneStatus;
  final UpdatePrenotazioneStatus updatePrenotazioneStatus;
  final List<Prenotazione> prenotazioni;
  final Prenotazione prenotazione;
  final String error;

  @override
  List<Object?> get props => [
        getPrenotazioniStatus,
        getPrenotazioneStatus,
        createPrenotazioneStatus,
        deletePrenotazioneStatus,
        prenotazioni,
        prenotazione,
        error
      ];

  const PrenotazioneState({
    required this.getPrenotazioniStatus,
    required this.getPrenotazioneStatus,
    required this.createPrenotazioneStatus,
    required this.deletePrenotazioneStatus,
    required this.updatePrenotazioneStatus,
    required this.prenotazioni,
    required this.prenotazione,
    required this.error,
  });

  factory PrenotazioneState.initial() {
    return PrenotazioneState(
        getPrenotazioniStatus: GetPrenotazioniStatus.initial,
        getPrenotazioneStatus: GetPrenotazioneStatus.initial,
        createPrenotazioneStatus: CreatePrenotazioneStatus.initial,
        deletePrenotazioneStatus: DeletePrenotazioneStatus.initial,
        updatePrenotazioneStatus: UpdatePrenotazioneStatus.initial,
        prenotazioni: const [],
        prenotazione: Prenotazione.initial(),
        error: '');
  }

  @override
  String toString() {
    return 'PrenotazioneState{getPrenotazioniStatus: $getPrenotazioniStatus, getPrenotazioneStatus: $getPrenotazioneStatus, createPrenotazioneStatus: $createPrenotazioneStatus, deletePrenotazioneStatus: $deletePrenotazioneStatus, prenotazioni: $prenotazioni, prenotazione: $prenotazione, error: $error}';
  }

  PrenotazioneState copyWith({
    GetPrenotazioniStatus? getPrenotazioniStatus,
    GetPrenotazioneStatus? getPrenotazioneStatus,
    CreatePrenotazioneStatus? createPrenotazioneStatus,
    DeletePrenotazioneStatus? deletePrenotazioneStatus,
    UpdatePrenotazioneStatus? updatePrenotazioneStatus,
    List<Prenotazione>? prenotazioni,
    Prenotazione? prenotazione,
    String? error,
  }) {
    return PrenotazioneState(
      getPrenotazioniStatus:
          getPrenotazioniStatus ?? this.getPrenotazioniStatus,
      getPrenotazioneStatus:
          getPrenotazioneStatus ?? this.getPrenotazioneStatus,
      createPrenotazioneStatus:
          createPrenotazioneStatus ?? this.createPrenotazioneStatus,
      deletePrenotazioneStatus:
          deletePrenotazioneStatus ?? this.deletePrenotazioneStatus,
      updatePrenotazioneStatus:
          updatePrenotazioneStatus ?? this.updatePrenotazioneStatus,
      prenotazioni: prenotazioni ?? this.prenotazioni,
      prenotazione: prenotazione ?? this.prenotazione,
      error: error ?? this.error,
    );
  }
}
