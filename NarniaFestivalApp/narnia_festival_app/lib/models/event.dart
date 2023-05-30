class Event {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final int availableSeats;
  final bool isBooked;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.availableSeats,
    required this.isBooked,
  });
}
