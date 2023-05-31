import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_bloc.dart';
import 'package:narnia_festival_app/repositories/repository.dart';
import 'package:narnia_festival_app/screens/verify_code_screen/verify_code_form.dart';

class VerifyCodeScreen extends StatefulWidget {
  final Repository repository;

  const VerifyCodeScreen({Key? key, required this.repository})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late TextEditingController _codeController;
  late VerificationBloc _verificationBloc;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    _verificationBloc = VerificationBloc(repository: widget.repository);
  }

  @override
  void dispose() {
    _codeController.dispose();
    _verificationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifica codice"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
                Navigator.of(context).popAndPushNamed("/login");
              },
              leading: const Icon(Icons.login_outlined),
              title: const Text("Login"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).popAndPushNamed("/register");
              },
              leading: const Icon(Icons.app_registration_outlined),
              title: const Text("Registrati"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).popAndPushNamed("/events");
              },
              leading: const Icon(Icons.event),
              title: const Text("Eventi"),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) {
          return VerificationBloc(repository: widget.repository);
        },
        child: VerifyCodeForm(
          repository: widget.repository,
        ),
      ),
    );
  }
}
