import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_event.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_event.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.repository, required this.authenticationBloc})
      : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLogin);
  }

  void _onLogin(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final token = await repository.login(
        event.email,
        event.password,
      );
      authenticationBloc.add(LoggedIn(token: token));
      emit(LoginSuccess());
    } catch (error) {
      if (error.toString().contains('1017')) {
        emit(LoginNotVerified(email: event.email));
        return;
      }
      emit(LoginFailure(error: error.toString()));
    }
  }
}
