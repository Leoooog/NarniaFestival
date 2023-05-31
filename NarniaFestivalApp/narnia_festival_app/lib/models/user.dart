class User {
  final String id;
  final String name;
  final String surname;
  final String username;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['IdUtente'],
      name: json['Nome'],
      surname: json['Cognome'],
      username: json['Username'],
      email: json['Email'],
    );
  }
}
