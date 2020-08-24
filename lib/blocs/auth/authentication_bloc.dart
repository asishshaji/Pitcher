import 'dart:async';

import 'package:Pitcher/data/firebase_auth_repo.dart';
import 'package:Pitcher/data/model/user.dart';
import 'package:Pitcher/data/user_firestore_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo firebaseAuthRepo;

  AuthenticationBloc(this.firebaseAuthRepo) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoginPressed) {
      yield* _mapLoginPressedToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationInitial(); // to display splash screen
    try {
      bool isSignedIn = await firebaseAuthRepo.isAuthenticated();
      if (isSignedIn) {
        final user = await firebaseAuthRepo.getUser();
        yield AuthenticationAuthenticated(user: user);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
        message: e.toString(),
      );
    }
  }

  Stream<AuthenticationState> _mapLoginPressedToState(
      UserLoginPressed event) async* {
    yield AuthenticationLoading();
    try {
      PitcherUser user = await firebaseAuthRepo.signInUsingGoogle();
      print(user.toMap());

      bool userAdded = await DatabaseServices().addUser(user);
      if (userAdded) yield AuthenticationAuthenticated(user: user);
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    await firebaseAuthRepo.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
