import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository repository;

  AuthenticationBloc({required this.repository})
      : super(AuthenticationUnauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    final hasToken = await repository.hasToken();
    emit(hasToken
        ? AuthenticationAuthenticated()
        : AuthenticationUnauthenticated());
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    await repository.saveToken(event.token);
    emit(AuthenticationAuthenticated());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    await repository.deleteToken();
    await repository.deleteUserId();
    emit(AuthenticationUnauthenticated());
  }
}
