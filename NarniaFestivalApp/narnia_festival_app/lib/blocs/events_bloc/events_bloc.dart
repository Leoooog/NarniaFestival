import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_event.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final Repository repository;

  EventsBloc({required this.repository}) : super(EventsLoading()) {
    on<FetchEvents>(_onFetchEvents);
  }

  void _onFetchEvents(FetchEvents event, Emitter<EventsState> emit) async {
    emit(EventsLoading());
    try {
      final events = await repository.getEvents();
      emit(EventsLoaded(events));
    } catch (error) {
      emit(EventsError(error.toString()));
    }
  }
}
