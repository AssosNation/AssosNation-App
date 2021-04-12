abstract class AuthenticationInterface {
  void signOff();
  Future createUserWithEmailAndPwd(mail, pwd);
  Future signIn(mail, pwd);
}