import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/interfaces/authentication_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends AuthenticationInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AnUser?> _userFromFirebaseUser(User _user) async {
    final _userInfos = await FireStoreService().getUserInfosFromDB(_user.uid);
    return AnUser.withData(
        _user.uid, _user.email!, _userInfos.firstName, _userInfos.lastName);
  }

  Stream<AnUser?> get user {
    return _auth.authStateChanges().map((_user) {
      if (_user != null) {
        final toto = _userFromFirebaseUser(_user).then((value) => value);
        print(toto);
      } else
        return null;
    });
  }

  @override
  Future signUpUserWithEmailAndPwd(mail, pwd) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: mail, password: pwd);

      await FireStoreService().addUserToDB(userCredential.user);
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
      String mail,
      String phone,
      String address,
      String postalCode,
      String city,
      String president,
      String pwd) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: mail, password: pwd);
      if (userCredential.user != null) {
        final _defImageUrl =
            await StorageService().getDefaultAssocaitonBannerUrl();
        final newAssociation = Association.application(
            userCredential.user!.uid,
            name,
            description,
            mail,
            address,
            city,
            postalCode,
            phone,
            _defImageUrl, // image URL
            president,
            true, // NEED TO CHANGE THAT TO FALSE AFTERWARD
            "",
            [],
            []); // type, posts, actions
        await FireStoreService().addAssociationToDb(newAssociation);
        signOff();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Future.error("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Future.error("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }
}
