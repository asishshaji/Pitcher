import 'package:Pitcher/blocs/auth/authentication_bloc.dart';
import 'package:Pitcher/data/firebase_auth_repo.dart';
import 'package:Pitcher/pages/AuthNav.dart';
import 'package:Pitcher/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthRepo firebaseAuthRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(firebaseAuthRepo))
      ],
      child: MaterialApp(
        title: 'Pitcher',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthNavigation(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
