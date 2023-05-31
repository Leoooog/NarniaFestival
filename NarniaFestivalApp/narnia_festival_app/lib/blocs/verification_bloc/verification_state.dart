import 'package:equatable/equatable.dart';

abstract class VerificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {}

class VerificationError extends VerificationState {
  final String message;

  VerificationError(this.message);

  @override
  List<Object?> get props => [message];
}
