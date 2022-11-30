import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passmate/model/custom_exceptions.dart';
import 'package:passmate/model/old_user.dart';
import 'package:passmate/shared/error_screen.dart';

class OldAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  OldAuthRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<OldUserData> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _firebaseAuth.signInWithCredential(credential);
      User? user = _firebaseAuth.currentUser;
      return user == null ? OldUserData.empty : OldUserData.fromUser(user);
    } on Exception catch (_) {
      throw SignInWithGoogleFailure();
    }
  }

  Future<OldUserData> logInWithCredentials(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user == null ? OldUserData.empty : OldUserData.fromUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        default:
          throw SomethingWentWrongException();
      }
    } catch (_) {
      throw SomethingWentWrongException();
    }
  }

  Future<OldUserData> signUpUsingCredentials(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user == null ? OldUserData.empty : OldUserData.fromUser(user);
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        default:
          throw SomethingWentWrongException();
      }
    } catch (_) {
      throw SomethingWentWrongException();
    }
  }

  Future<void> deleteUser() async {
    try {
      User user = getUser()!;
      await user.delete();
    } on Exception catch (_) {
      throw const SomethingWentWrong();
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

  OldUserData getUserData() {
    User? user = _firebaseAuth.currentUser;
    return user == null ? OldUserData.empty : OldUserData.fromUser(user);
  }

  User? getUser() {
    User? user = _firebaseAuth.currentUser;
    return user;
  }

  Stream<OldUserData> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      return user == null ? OldUserData.empty : OldUserData.fromUser(user);
    });
  }
}
