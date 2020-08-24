import 'package:Pitcher/blocs/auth/authentication_bloc.dart';
import 'package:Pitcher/components/GoogleButtonCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _authenticationBloc.add(AppLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleButtonCustom(
          function: () {
            _authenticationBloc.add(UserLoginPressed());
          },
        ),
      ),
    );
  }
}
