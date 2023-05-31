import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_bloc.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_event.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class EventsScreen extends StatefulWidget {
  final Repository repository;

  const EventsScreen({Key? key, required this.repository}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState(repository);
}

class _EventsScreenState extends State<EventsScreen> {
  final Repository repository;

  _EventsScreenState(this.repository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventi'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColor, // Colore di sfondo dell'header
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Benvenuto!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
                onTap: () {
                  Navigator.of(context).popAndPushNamed(
                    "/login",
                  );
                },
                leading: const Icon(Icons.login_outlined),
                title: const Text("Login")),
            ListTile(
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/register");
                },
                leading: const Icon(Icons.app_registration_outlined),
                title: const Text("Registrati")),
            ListTile(
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/events");
                },
                leading: const Icon(Icons.event),
                title: const Text("Eventi")),
          ],
        ),
      ),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EventsLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.3),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.events.length,
                    itemBuilder: (context, index) {
                      var event = state.events[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                event.subtitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    event.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else if (state is EventsError) {
            return Center(
              child: Text(
                  'Errore durante il caricamento degli eventi: ${state.message}'),
            );
          }
          return Container(); // Stato iniziale
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Dispatch dell'evento per caricare gli eventi
          BlocProvider.of<EventsBloc>(context).add(FetchEvents());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
