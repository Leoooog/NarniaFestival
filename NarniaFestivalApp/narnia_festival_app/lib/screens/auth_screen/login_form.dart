import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_bloc.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_event.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class LoginForm extends StatefulWidget {
  final Repository repository;

  const LoginForm({Key? key, required this.repository}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(repository);
}

class _LoginFormState extends State<LoginForm> {
  final Repository authRepository;

  _LoginFormState(this.authRepository);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login failed.${state.error}"),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LoginNotVerified) {
          Navigator.of(context).pushReplacementNamed("/verifica_codice");
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushReplacementNamed("/events");
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width / 2.9,
              left: MediaQuery.of(context).size.width / 2.9,
              top: MediaQuery.of(context).size.height / 8,
            ),
            child: Form(
              child: Column(
                children: [
                  Container(
                    height: 200.0,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 50,
                      top: MediaQuery.of(context).size.height / 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Narnia Festival",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 40.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 200,
                        ),
                        const Text(
                          "Effettua il login per poter prenotare gli eventi",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _usernameController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black26,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      labelText: "E-Mail o Username",
                      hintStyle: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    autocorrect: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black26,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      labelText: "Password",
                      hintStyle: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    autocorrect: false,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: const Text(
                        "Password dimenticata?",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12.0,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(Icons.handyman_outlined),
                              title: const Text('Lavori in corso'),
                              content: const Text(
                                'Questa funzione non è ancora supportata',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50,
                      bottom: MediaQuery.of(context).size.height / 60,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                          child: state is LoginLoading
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                90,
                                            child:
                                                const CupertinoActivityIndicator(),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: onLoginButtonPressed,
                                  child: const Text(
                                    "Log in",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Non hai un account?",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 150,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Registrati",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
