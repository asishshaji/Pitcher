import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'model/user.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepo({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  Future<PitcherUser> getUser() async {
    User firebaseUser = _firebaseAuth.currentUser;
    return PitcherUser(
      userid: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber ?? "0",
      username: firebaseUser.displayName,
      imageUrl: firebaseUser.photoURL,
      timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  Future<String> getUserID() async {
    User firebaseUser = _firebaseAuth.currentUser;
    return firebaseUser.email;
  }

  Future<PitcherUser> signInUsingGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);

    return getUser();
  }

  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
