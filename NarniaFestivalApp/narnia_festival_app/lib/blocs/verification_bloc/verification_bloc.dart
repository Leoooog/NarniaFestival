import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_event.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final Repository repository;

  VerificationBloc({required this.repository}) : super(VerificationInitial()) {
    on<VerifyCode>(_onVerifyCode);
  }

  void _onVerifyCode(VerifyCode event, Emitter<VerificationState> emit) async {
    emit(VerificationLoading());
    try {
      final result = await repository.verifyCode(event.code);
      if (result) {
        emit(VerificationSuccess());
      } else {
        emit(VerificationError("Codice sbagliato o scaduto"));
      }
    } catch (error) {
      emit(VerificationError(error.toString()));
    }
  }
}
