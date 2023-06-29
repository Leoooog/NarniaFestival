library;

class RegisterUtente {
  final String nome;
  final String cognome;
  final String username;
  final String passwordHash;
  final String email;

  const RegisterUtente({
    required this.nome,
    required this.cognome,
    required this.username,
    required this.passwordHash,
    required this.email,
  });

  @override
  String toString() {
    return 'RegisterUtente{nome: $nome, cognome: $cognome, username: $username, passwordHash: $passwordHash, email: $email}';
  }

  Map<String, dynamic> toJson() {
    return {
      'Nome': nome,
      'Cognome': cognome,
      'Username': username,
      'PasswordHash': passwordHash,
      'Email': email,
    };
  }
}

class LoginUtente {
  final String username;
  final String password;

  const LoginUtente({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Password': password,
    };
  }

  @override
  String toString() {
    return 'LoginUtente{username: $username, password: $password}';
  }
}

class UpdateUtente {
  final String nome;
  final String cognome;
  final String username;

  const UpdateUtente({
    required this.nome,
    required this.cognome,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'Nome': nome,
      'Cognome': cognome,
      'Username': username,
    };
  }

  @override
  String toString() {
    return 'UpdateUtente{nome: $nome, cognome: $cognome, username: $username}';
  }
}

class Prenotazione {
  final String eventoId;
  final int posti;

  const Prenotazione({
    required this.eventoId,
    required this.posti,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventoId': eventoId,
      'posti': posti,
    };
  }

  @override
  String toString() {
    return 'Prenotazione{eventoId: $eventoId, posti: $posti}';
  }
}
