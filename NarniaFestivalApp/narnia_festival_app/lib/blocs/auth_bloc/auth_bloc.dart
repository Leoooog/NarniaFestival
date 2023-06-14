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
    if (hasToken) {
      try {
        var user = await repository.getMe();
        emit(AuthenticationAuthenticated(user));
      } catch (error) {
        emit(AuthenticationError(error.toString()));
      }
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    print(event.token);
    await repository.saveToken(event.token);
    try {
      var user = await repository.getMe();
      emit(AuthenticationAuthenticated(user));
    } catch (error) {
      emit(AuthenticationError(error.toString()));
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    await repository.logout();
    await repository.deleteToken();
    await repository.deleteUserId();
    emit(AuthenticationUnauthenticated());
  }

  Future<bool> isAuthenticated() async {
    return await repository.verifyToken();
  }
}
