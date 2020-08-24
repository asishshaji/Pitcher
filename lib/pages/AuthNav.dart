import 'package:Pitcher/blocs/auth/authentication_bloc.dart';
import 'package:Pitcher/pages/HomeScreen.dart';
import 'package:Pitcher/pages/LoginScreen.dart';
import 'package:Pitcher/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigation extends StatefulWidget {
  AuthNavigation({Key key}) : super(key: key);

  @override
  _AuthNavigationState createState() => _AuthNavigationState();
}

class _AuthNavigationState extends State<AuthNavigation> {
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
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationNotAuthenticated) {
              return LoginScreen();
            } else if (state is AuthenticationInitial) {
              return SplashScreen();
            } else if (state is AuthenticationAuthenticated) {
              return HomeScreen(user: state.user);
            } else if (state is AuthenticationLoading) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else if (state is AuthenticationFailure) {
              print(state.toString());
              return Container(
                child: Text(state.message),
              );
            }
            return Text("");
          },
        ),
      ),
    );
  }
}
