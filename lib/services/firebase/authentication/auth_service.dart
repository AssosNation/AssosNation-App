import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/interfaces/authentication_interface.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends AuthenticationInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AnUser _userFromFirebaseUser(User _user) {
    return AnUser(_user.uid, _user.email!);
  }

  Stream<AnUser?> get user {
    return _auth
        .authStateChanges()
        .map((_user) => _user != null ? _userFromFirebaseUser(_user) : null);
  }

  @override
  Future signUpUserWithEmailAndPwd(mail, pwd) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: mail, password: pwd);

      await FireStoreService().addUserToDB(userCredential.user);
      print("createdUser good");
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
  Future signUpUserWithAllInfos(mail, pwd, firstName, lastName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: mail, password: pwd);
      if (userCredential.user != null) {
        final newUser = AnUser.withData(userCredential.user!.uid,
            userCredential.user!.email!, firstName, lastName);

        await FireStoreService().addUserToDB(newUser);
      }
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
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: mail, password: pwd);
      print("User connected $userCredential");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    } on FirebaseException catch (e) {
      print("A problem occured when signing in");
      print(e);
    }
  }

  @override
  void signOff() {
    _auth.signOut();
  }

  @override
  Future applyAsAssociation(
      String name,
      String description,
      String president,
      String mail,
      String phone,
      String address,
      String postalCode,
      String city,
      String pwd) {
    print(
        "$name, $description, $president, $mail, $phone, $address, $postalCode, $city");
    return Future.delayed(Duration(seconds: 1));
  }
}
