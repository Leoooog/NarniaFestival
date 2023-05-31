import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_bloc.dart';
import 'package:narnia_festival_app/main.dart';
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
    return MyScaffold(
        body: BlocProvider(
      create: (context) {
        return VerificationBloc(repository: widget.repository);
      },
      child: VerifyCodeForm(
        repository: widget.repository,
      ),
    ));
  }
}
