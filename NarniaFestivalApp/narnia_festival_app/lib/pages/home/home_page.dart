import 'package:flutter/material.dart';
import 'package:narnia_festival_app/pages/home/iscritto_home_page.dart';
import 'package:narnia_festival_app/pages/home/ospite_home_page.dart';
import 'package:narnia_festival_app/repositories/utente_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UtenteRepository.instance.getMe(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.ruolo == 2) {
              return IscrittoHomePage();
            } else {
              return OspiteHomePage();
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error!.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}