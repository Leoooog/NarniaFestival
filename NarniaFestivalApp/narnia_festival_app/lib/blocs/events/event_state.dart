import 'package:equatable/equatable.dart';
import 'package:narnia_festival_app/models/booking.dart';
import 'package:narnia_festival_app/models/event.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoadSuccess extends EventState {
  final List<Event> events;

  const EventLoadSuccess(this.events);

  @override
  List<Object> get props => [events];
}

class EventLoadFailure extends EventState {
  final String error;

  const EventLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}

class EventBookingSuccess extends EventState {
  final Booking booking;

  const EventBookingSuccess(this.booking);

  @override
  List<Object> get props => [booking];
}

class EventBookingFailure extends EventState {
  final String error;

  const EventBookingFailure(this.error);

  @override
  List<Object> get props => [error];
}
