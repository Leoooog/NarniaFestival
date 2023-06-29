class CustomError {
  final int codice;
  final String messaggio;

  const CustomError({
    required this.codice,
    required this.messaggio,
  });

  @override
  String toString() {
    return '#$codice\n$messaggio';
  }
}

class NotVerifiedError extends CustomError {
  final String idUtente;

  const NotVerifiedError({
    required this.idUtente,
    required super.codice,
    required super.messaggio,
  });

  @override
  String toString() {
    return '#$codice\n$messaggio\nIdUtente:$idUtente';
  }
}
