import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/repositories/api_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiRepository apiRepository;

  AuthenticationBloc({required this.apiRepository})
      : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final token = await apiRepository.getToken();

    if (token != null) {
      yield AuthenticationSuccess(token);
    } else {
      yield AuthenticationFailure("Not authenticated");
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    await apiRepository.saveToken(event.token);
    yield AuthenticationSuccess(event.token);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await apiRepository.deleteToken();
    yield AuthenticationFailure("Not authenticated");
  }
}
