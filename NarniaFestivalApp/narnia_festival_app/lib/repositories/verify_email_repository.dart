import 'package:narnia_festival_app/repositories/repository.dart';

class VerifyEmailRepository extends Repository {
  VerifyEmailRepository._();

  static final VerifyEmailRepository _instance = VerifyEmailRepository._();

  static VerifyEmailRepository get instance => _instance;

  Future verifyEmail(int code) async {
    try {
      await post(
          '/api/utenti/{id}/verifica_codice', {"Codice": code}, 200, false);
    } catch (e) {
      rethrow;
    }
  }

  Future sendNewCode() async {
    try {
      await post('/api/utenti/{id}/new_code', {}, 200, false);
    } catch (e) {
      rethrow;
    }
  }
}
