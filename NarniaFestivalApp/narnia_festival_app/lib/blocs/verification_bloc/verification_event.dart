import 'package:equatable/equatable.dart';

abstract class VerificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewCode extends VerificationEvent {
  @override
  List<Object?> get props => [];
}

class VerifyCode extends VerificationEvent {
  final String code;

  VerifyCode(this.code);

  @override
  List<Object?> get props => [code];
}
