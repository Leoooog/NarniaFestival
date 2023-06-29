import 'package:narnia_festival_app/redux/evento/evento_action.dart';
import 'package:redux/redux.dart';

import 'evento_state.dart';

EventoState getEventiReducer(EventoState state, GetEventiAction action) {
  return state.copyWith(eventiStatus: EventiStatus.loading);
}

EventoState getEventiSucceededReducer(
    EventoState state, GetEventiSucceededAction action) {
  return state.copyWith(
      eventiStatus: EventiStatus.success, eventi: action.eventi);
}

EventoState getEventiFailedReducer(
    EventoState state, GetEventiFailedAction action) {
  return state.copyWith(
      eventiStatus: EventiStatus.failure, error: action.error);
}

EventoState getEventoReducer(EventoState state, GetEventoAction action) {
  return state.copyWith(eventoStatus: EventoStatus.loading);
}

EventoState getEventoSucceededReducer(
    EventoState state, GetEventoSucceededAction action) {
  return state.copyWith(
      eventoStatus: EventoStatus.success, evento: action.evento);
}

EventoState getEventoFailedReducer(
    EventoState state, GetEventoFailedAction action) {
  return state.copyWith(
      eventoStatus: EventoStatus.failure, error: action.error);
}

Reducer<EventoState> eventoReducer = combineReducers([
  TypedReducer<EventoState, GetEventiAction>(getEventiReducer),
  TypedReducer<EventoState, GetEventiSucceededAction>(
      getEventiSucceededReducer),
  TypedReducer<EventoState, GetEventiFailedAction>(getEventiFailedReducer),
  TypedReducer<EventoState, GetEventoAction>(getEventoReducer),
  TypedReducer<EventoState, GetEventoSucceededAction>(
      getEventoSucceededReducer),
  TypedReducer<EventoState, GetEventoFailedAction>(getEventoFailedReducer),
]);
