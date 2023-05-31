

class Event {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String duration;
  final String date;
  final String location;
  final double latitude;
  final double longitude;
  final String type;
  final double price;
  final bool withBooking;
  final int capacity;
  final int seatsOccupied;

  Event({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.duration,
    required this.date,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.price,
    required this.withBooking,
    required this.capacity,
    required this.seatsOccupied,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['IdEvento'],
      title: json['Titolo'],
      subtitle: json['Sottotitolo'],
      description: json['Descrizione'],
      duration: json['Durata'],
      date: json['Data'],
      location: json['Luogo'],
      latitude: double.parse(json['Latitudine']),
      longitude: double.parse(json['Longitudine']),
      type: json['Tipo'],
      price: double.parse(json['Prezzo']),
      withBooking: json['ConPrenotazione'] == '1',
      capacity: int.parse(json['Capienza'] ?? 'null'),
      seatsOccupied: int.parse(json['PostiOccupati'] ?? 'null'),
    );
  }
}
