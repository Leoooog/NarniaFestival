import 'package:flutter/material.dart';

import 'api_helper.dart'; // Sostituisci con il nome del tuo pacchetto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventListScreen(),
    );
  }
}

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    fetchEventData();
  }

  Future<void> fetchEventData() async {
    try {
      final apiHelper = ApiHelper();
      final responseData = await apiHelper.getRequest('eventi');
      final List<dynamic> eventList = responseData;
      setState(() {
        events = eventList;
      });
    } catch (e) {
      print('Errore durante il recupero dei dati degli eventi: $e');
      // Gestisci l'errore in base alle tue esigenze
    }
  }

  void showEventDetails(dynamic event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event['Titolo']),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sottotitolo: ${event['Sottotitolo']}'),
                Text('Descrizione: ${event['Descrizione']}'),
                Text('Durata: ${event['Durata']}'),
                Text('Data: ${event['Data']}'),
                Text('Luogo: ${event['Luogo']}'),
                Text('Prezzo: ${event['Prezzo']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Chiudi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elenco Eventi'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            child: ListTile(
              title: Text(event['Titolo']),
              subtitle: Text(event['Sottotitolo']),
              onTap: () {
                showEventDetails(event);
              },
            ),
          );
        },
      ),
    );
  }
}
