import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/models/in.dart';

enum EventiStatus { initial, loading, success, failure }

enum EventoStatus { initial, loading, success, failure }

class EventoState extends Equatable {
  final EventiStatus eventiStatus;
  final EventoStatus eventoStatus;
  final List<Evento> eventi;
  final Evento evento;
  final String error;

  const EventoState({
    required this.eventiStatus,
    required this.eventoStatus,
    required this.eventi,
    required this.evento,
    required this.error,
  });

  factory EventoState.initial() {
    return EventoState(
        eventiStatus: EventiStatus.initial,
        eventoStatus: EventoStatus.initial,
        eventi: const [],
        evento: Evento.initial(),
        error: '');
  }

  EventoState copyWith({
    EventiStatus? eventiStatus,
    EventoStatus? eventoStatus,
    List<Evento>? eventi,
    Evento? evento,
    String? error,
  }) {
    return EventoState(
      eventiStatus: eventiStatus ?? this.eventiStatus,
      eventoStatus: eventoStatus ?? this.eventoStatus,
      eventi: eventi ?? this.eventi,
      evento: evento ?? this.evento,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [eventiStatus, eventoStatus, eventi, evento, error];

  @override
  String toString() {
    return 'EventoState{eventiStatus: $eventiStatus, eventoStatus: $eventoStatus, eventi: $eventi, evento: $evento, error: $error}';
  }
}
