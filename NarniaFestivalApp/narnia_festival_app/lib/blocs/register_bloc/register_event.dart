import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUser extends RegisterEvent {
  final String name;
  final String surname;
  final String username;
  final String email;
  final String password;

  RegisterUser({
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, surname, username, email, password];
}
