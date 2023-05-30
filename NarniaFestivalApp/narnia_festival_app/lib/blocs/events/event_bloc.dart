import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/repositories/api_repository.dart';

import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final ApiRepository apiRepository;

  EventBloc({required this.apiRepository}) : super(EventInitial());

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is LoadEvents) {
      yield* _mapLoadEventsToState();
    } else if (event is BookEvent) {
      yield* _mapBookEventToState(event);
    }
  }

  Stream<EventState> _mapLoadEventsToState() async* {
    yield EventLoading();
    try {
      final events = await apiRepository.getEvents();
      yield EventLoadSuccess(events);
    } catch (error) {
      yield EventLoadFailure(error.toString());
    }
  }

  Stream<EventState> _mapBookEventToState(BookEvent event) async* {
    yield EventLoading();
    try {
      final booking = await apiRepository.bookEvent(event.eventId, event.seats);
      yield EventBookingSuccess(booking);
    } catch (error) {
      yield EventBookingFailure(error.toString());
    }
  }
}
