import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_bloc.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_state.dart';
import 'package:narnia_festival_app/main.dart';
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
    return MyScaffold(
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
    );
  }
}
