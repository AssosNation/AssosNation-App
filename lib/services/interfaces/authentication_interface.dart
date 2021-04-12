abstract class AuthenticationInterface {
  void signOff();
  Future signUpUserWithEmailAndPwd(mail, pwd);
  Future signIn(mail, pwd);
}
