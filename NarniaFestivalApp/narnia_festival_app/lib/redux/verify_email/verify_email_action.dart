class VerifyEmailAction {
  final int code;

  const VerifyEmailAction({
    required this.code,
  });

  @override
  String toString() {
    return 'VerifyEmailAction{code: $code}';
  }
}

class VerifyEmailSucceededAction {
  @override
  String toString() {
    return 'VerifyEmailSucceededAction{}';
  }
}

class VerifyEmailFailedAction {
  final String error;

  @override
  String toString() {
    return 'VerifyEmailFailedAction{error: $error}';
  }

  const VerifyEmailFailedAction({
    required this.error,
  });
}

class NewCodeAction {
  @override
  String toString() {
    return 'NewCodeAction{}';
  }
}

class NewCodeSucceededAction {
  @override
  String toString() {
    return 'NewCodeSucceededAction{}';
  }
}

class NewCodeFailedAction {
  final String error;

  const NewCodeFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'NewCodeFailedAction{error: $error}';
  }
}
