import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passmate/model/user.dart';

class SignUpFailure implements Exception {}

class SignInWithEmailAndPasswordFailure implements Exception {}

class SignUpWithEmailAndPasswordFailure implements Exception {}

class SignInWithGoogleFailure implements Exception {}

class SignOutFailure implements Exception {}

class AuthenticationRepository{

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository({FirebaseAuth? firebaseAuth , GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<UserData> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      await _firebaseAuth.signInWithCredential(credential);
      User? user = _firebaseAuth.currentUser;
      return user==null?UserData.empty:UserData.fromUser(user);
    } on Exception catch (_) {
      throw SignInWithGoogleFailure();
    }
  }

  Future<UserData> logInWithCredentials(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user==null?UserData.empty:UserData.fromUser(user);
    } on Exception catch (_) {
      throw SignInWithEmailAndPasswordFailure();
    }
  }

  Future<UserData> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user==null?UserData.empty:UserData.fromUser(user);
    } on Exception catch (_) {
      throw SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } on Exception catch (_) {
      throw SignOutFailure();
    }
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  UserData getUserData() {
    User? user = _firebaseAuth.currentUser;
    return user==null?UserData.empty:UserData.fromUser(user);
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

}