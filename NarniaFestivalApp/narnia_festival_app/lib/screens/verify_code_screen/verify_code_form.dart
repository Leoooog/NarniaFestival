import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_bloc.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_event.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class VerifyCodeForm extends StatefulWidget {
  final Repository repository;

  const VerifyCodeForm({Key? key, required this.repository}) : super(key: key);

  @override
  State<VerifyCodeForm> createState() => _VerifyCodeFormState(repository);
}

class _VerifyCodeFormState extends State<VerifyCodeForm> {
  final Repository authRepository;
  final TextEditingController _codeController = new TextEditingController();

  _VerifyCodeFormState(this.authRepository);

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationBloc, VerificationState>(
      listener: (context, state) {
        if (state is VerificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is VerificationSuccess) {
          Navigator.of(context).pushReplacementNamed("/login");
        }
      },
      child: BlocBuilder<VerificationBloc, VerificationState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: "Codice",
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Invia l'evento di verifica del codice al bloc
                    BlocProvider.of<VerificationBloc>(context).add(
                      VerifyCode(_codeController.text),
                    );
                  },
                  child: const Text("Verifica"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
