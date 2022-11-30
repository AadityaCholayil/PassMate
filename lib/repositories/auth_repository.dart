import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passmate/model/user/user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<User?> logInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await _firebaseAuth.signInWithCredential(credential);
    auth.User? user = _firebaseAuth.currentUser;
    return user == null ? null : User.fromUser(user);
  }

  Future<User?> logInWithCredentials(String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    auth.User? user = userCredential.user;
    return user == null ? null : User.fromUser(user);
  }

  Future<User?> signUpUsingCredentials(String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    auth.User? user = userCredential.user;
    return user == null ? null : User.fromUser(user);
  }

  Future<void> deleteUser() async {
    auth.User user = currentFirebaseUser!;
    await user.delete();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  bool get isSignedIn => _firebaseAuth.currentUser != null;

  User? get currentUser {
    auth.User? user = _firebaseAuth.currentUser;
    return user == null ? null : User.fromUser(user);
  }

  auth.User? get currentFirebaseUser {
    auth.User? user = _firebaseAuth.currentUser;
    return user;
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      return user == null ? null : User.fromUser(user);
    });
  }
}
