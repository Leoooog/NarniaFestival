import 'package:equatable/equatable.dart';

abstract class EventsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchEvents extends EventsEvent {}
