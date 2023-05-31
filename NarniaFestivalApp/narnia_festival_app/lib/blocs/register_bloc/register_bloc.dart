import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/register_bloc/register_event.dart';
import 'package:narnia_festival_app/blocs/register_bloc/register_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Repository repository;

  RegisterBloc({required this.repository}) : super(RegisterInitial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  void _onRegisterUser(RegisterUser event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      repository.registerUser(event.name, event.surname, event.username,
          event.email, event.password);
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterError(error.toString()));
    }
  }
}
