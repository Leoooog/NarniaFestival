import 'package:flutter/material.dart';

class BookingDialog extends StatelessWidget {
  final String eventId;

  const BookingDialog({required this.eventId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _seatsController = TextEditingController();

    return AlertDialog(
      title: const Text('Book Event'),
      content: TextField(
        controller: _seatsController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Number of Seats'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final seats = int.tryParse(_seatsController.text) ?? 0;
            if (seats > 0) {
              Navigator.of(context).pop(seats);
            }
          },
          child: const Text('Book'),
        ),
      ],
    );
  }
}
