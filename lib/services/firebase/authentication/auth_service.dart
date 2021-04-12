import 'package:assosnation_app/services/interfaces/authentication_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends AuthenticationInterface{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future createUserWithEmailAndPwd(mail, pwd) async{
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: mail, password: pwd);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future signIn(mail, pwd) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: pwd
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void signOff() {
    // TODO: implement signOff
  }
}