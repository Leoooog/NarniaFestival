import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/pages/authentication/login_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/verify_email/verify_email_action.dart';
import 'package:narnia_festival_app/redux/verify_email/verify_email_state.dart';
import 'package:redux/redux.dart';

class EmailVerificationPage extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifica codice"),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.verifyEmailStatus == VerifyEmailStatus.success) {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => LoginPage()),
                (route) {
              return route.isFirst;
            });
          } else if (curr.verifyEmailStatus == VerifyEmailStatus.failure) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      icon: const Icon(Icons.error),
                      content: Text(curr.error),
                      title: const Text("Error!"),
                    ));
          }
        },
        builder: (context, vm) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Inserisci il codice di verifica',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _codeController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Codice di verifica',
                  ),
                  maxLength: 6,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => vm.newCode(),
                  child: const Text('Invia nuovo codice'),
                ),
                const SizedBox(height: 16.0),
                if (vm.newCodeStatus == NewCodeStatus.loading)
                  const CircularProgressIndicator(),
                if (vm.newCodeStatus == NewCodeStatus.failure)
                  Text(
                    vm.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                if (vm.newCodeStatus == NewCodeStatus.success)
                  const Text(
                    'Nuovo codice inviato',
                    style: TextStyle(color: Colors.green),
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final code = _codeController.text;
                    if (code.length == 6) {
                      vm.sendCode(int.parse(_codeController.text));
                    }
                  },
                  child: const Text('Conferma'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final Function() newCode;
  final Function(int) sendCode;
  final VerifyEmailStatus verifyEmailStatus;
  final NewCodeStatus newCodeStatus;
  final String error;

  const _ViewModel({
    required this.newCode,
    required this.sendCode,
    required this.verifyEmailStatus,
    required this.newCodeStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        newCode: () => store.dispatch(NewCodeAction()),
        sendCode: (code) => store.dispatch(VerifyEmailAction(code: code)),
        verifyEmailStatus: store.state.verifyEmailState.verifyEmailStatus,
        newCodeStatus: store.state.verifyEmailState.newCodeStatus,
        error: store.state.verifyEmailState.error);
  }

  @override
  List<Object?> get props => [verifyEmailStatus, newCodeStatus, error];

  @override
  String toString() {
    return '_ViewModel{newCode: $newCode, sendCode: $sendCode, verifyEmailStatus: $verifyEmailStatus, newCodeStatus: $newCodeStatus, error: $error}';
  }
}
