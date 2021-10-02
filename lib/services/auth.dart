import 'package:chit_chat/custom/user.dart';
import 'package:chit_chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  //this is used to get a custom user data...
  CustomUser _userFromFirebaseUser(User? user) {
    return CustomUser(uid: user!.uid);
  }

  //stream data changes in authentication...
  Stream<CustomUser?>? get UserStream {
    try {
      return _auth.authStateChanges().map(_userFromFirebaseUser);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //anonymous sign-in
  Future SignInAnon() async {
    try {
      UserCredential? AnonResult = await _auth.signInAnonymously();
      User? AnonUser = AnonResult.user;
      return _userFromFirebaseUser(AnonUser);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //sign in with email and password...
  Future signwithemailandpassword(String email, String password) async {
    try {
      UserCredential? EmailpasswordResult = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      User? EmailPassUser = EmailpasswordResult.user;
      return _userFromFirebaseUser(EmailPassUser);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //register with email and password...
  Future registerwithemailandpassword(
      String email, String password, String username) async {
    try {
      UserCredential? EmailpasswordResult = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? EmailPassUser = EmailpasswordResult.user;

      await DatabaseService(uid: _userFromFirebaseUser(EmailPassUser).uid)
          .uploaduserinfo(username, email);
      return _userFromFirebaseUser(EmailPassUser);
    } catch (error) {
      print(error.toString() + ' Register with email and password');
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //reset password...
  Future resetpass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
