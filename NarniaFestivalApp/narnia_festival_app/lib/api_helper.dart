import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl =
      'http://localhost:8000/api'; // Inserisci l'URL base dell'API qui

  Future<dynamic> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print(url);
    final response = await http.get(url);
    final responseData = jsonDecode(response.body);

    return responseData;
  }

  Future<dynamic> postRequest(String endpoint, dynamic data) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<dynamic> putRequest(String endpoint, dynamic data) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.put(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.delete(url);
    final responseData = jsonDecode(response.body);
    return responseData;
  }
}
