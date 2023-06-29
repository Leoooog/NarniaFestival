import 'package:equatable/equatable.dart';

enum VerifyEmailStatus { initial, loading, success, failure }

enum NewCodeStatus { initial, loading, success, failure }

class VerifyEmailState extends Equatable {
  final VerifyEmailStatus verifyEmailStatus;
  final NewCodeStatus newCodeStatus;
  final String error;

  const VerifyEmailState({
    required this.verifyEmailStatus,
    required this.newCodeStatus,
    required this.error,
  });

  factory VerifyEmailState.initial() {
    return const VerifyEmailState(
        verifyEmailStatus: VerifyEmailStatus.initial,
        newCodeStatus: NewCodeStatus.initial,
        error: '');
  }

  @override
  List<Object?> get props => [verifyEmailStatus, newCodeStatus, error];

  @override
  String toString() {
    return 'VerifyEmailState{verifyEmailStatus: $verifyEmailStatus, newCodeStatus: $newCodeStatus, error: $error}';
  }

  VerifyEmailState copyWith({
    VerifyEmailStatus? verifyEmailStatus,
    NewCodeStatus? newCodeStatus,
    String? error,
  }) {
    return VerifyEmailState(
      verifyEmailStatus: verifyEmailStatus ?? this.verifyEmailStatus,
      newCodeStatus: newCodeStatus ?? this.newCodeStatus,
      error: error ?? this.error,
    );
  }
}
