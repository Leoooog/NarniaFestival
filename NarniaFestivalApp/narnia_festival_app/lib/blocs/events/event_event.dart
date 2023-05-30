import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}

class BookEvent extends EventEvent {
  final String eventId;
  final int seats;

  const BookEvent(this.eventId, this.seats);

  @override
  List<Object> get props => [eventId, seats];
}
