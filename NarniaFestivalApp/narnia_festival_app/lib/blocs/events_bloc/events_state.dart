import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/models/event.dart';

abstract class EventsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;

  EventsLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class EventsError extends EventsState {
  final String message;

  EventsError(this.message);

  @override
  List<Object?> get props => [message];
}
