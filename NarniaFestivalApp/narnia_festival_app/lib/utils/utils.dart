import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateHash(String password) {
  final bytes = utf8.encode(password);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

String getTipoBuonoString(int tipo) {
  switch (tipo) {
    case 1:
      return "Basic";
    case 2:
      return "Premium";
    case 3:
      return "Executive";
  }
  return "";
}

int getValoreBuonoPasto(int tipo) {
  switch (tipo) {
    case 1:
      return 7;
    case 2:
      return 10;
    case 3:
      return 15;
  }
  return 0;
}

String getDescrizioneBuonoPasto(int tipo) {
  switch (tipo) {
    case 1:
      return "1 primo o secondo, acqua a volontà, 1 caffè";
    case 2:
      return "1 primo o secondo, acqua a volontà, 1 caffè, 1 dolce";
    case 3:
      return "1 primo, 1 secondo, acqua a volontà, 1 caffè, 1 dolce";
  }
  return "";
}

bool validatePassword(String password) {
  if (password.length < 8) {
    return false;
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }
  return true;
}

bool validateEmail(String email) {
  final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

  return emailRegex.hasMatch(email);
}
