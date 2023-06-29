import 'package:flutter/material.dart';
import 'package:narnia_festival_app/pages/authentication/login_page.dart';
import 'package:narnia_festival_app/pages/authentication/register_page.dart';
import 'package:narnia_festival_app/pages/eventi/eventi_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benvenuto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Benvenuto!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Scopri gli eventi, i corsi e i ristoranti del festival.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Naviga alla pagina di registrazione
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: const Text('Registrati'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Naviga alla pagina di accesso
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: const Text('Accedi'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Scaffold(
                            appBar: AppBar(
                              title: const Text("Eventi"),
                            ),
                            body: const EventiPage())));
              },
              child: const Text('Continua senza accedere'),
            ),
          ],
        ),
      ),
    );
  }
}
