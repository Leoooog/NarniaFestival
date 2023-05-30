import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/booking.dart';
import 'package:narnia_festival_app/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository {
  final SharedPreferences sharedPreferences;
  static const String apiUrl =
      "https://your-api-url.com"; // Inserisci l'URL corretto dell'API

  ApiRepository({required this.sharedPreferences});

  Future<String?> getToken() async {
    return sharedPreferences.getString('token');
  }

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  Future<void> deleteToken() async {
    await sharedPreferences.remove('token');
  }

  Future<List<Event>> getEvents() async {
    final response = await http.get(Uri.parse('$apiUrl/api/eventi'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final events = jsonData
          .map((eventData) => Event(
                id: eventData['id'],
                name: eventData['name'],
                description: eventData['description'],
                date: DateTime.parse(eventData['date']),
                availableSeats: eventData['available_seats'],
                isBooked: eventData['is_booked'],
              ))
          .toList();
      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<Booking> bookEvent(String eventId, int seats) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final headers = {'Authorization': 'Bearer $token'};
    final body = jsonEncode({
      'eventId': eventId,
      'seats': seats,
    });

    final response = await http.post(
      Uri.parse('$apiUrl/api/prenotazioni'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final booking = Booking(
        id: jsonData['id'],
        eventId: jsonData['eventId'],
        userId: jsonData['userId'],
        seats: jsonData['seats'],
      );
      return booking;
    } else {
      throw Exception('Failed to book event');
    }
  }
}
