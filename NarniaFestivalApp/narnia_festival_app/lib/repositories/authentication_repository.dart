import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/out.dart' as output;
import 'package:narnia_festival_app/repositories/repository.dart';

class AuthenticationRepository extends Repository {
  AuthenticationRepository._();

  static final AuthenticationRepository _instance =
      AuthenticationRepository._();

  static AuthenticationRepository get instance => _instance;

  Future<String> register(output.RegisterUtente utente) async {
    try {
      final http.Response response =
          await post('/api/utenti', utente.toJson(), 201, false);
      return jsonDecode(response.body)[0]['IdUtente'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login(output.LoginUtente utente) async {
    try {
      final http.Response response =
          await post('/api/login', utente.toJson(), 200, false);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future logout() async {
    try {
      await post('/api/logout', {}, 200, true);
    } catch (e) {
      rethrow;
    }
  }
}
