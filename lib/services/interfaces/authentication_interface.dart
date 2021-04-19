abstract class AuthenticationInterface {
  void signOff();
  Future signUpUserWithEmailAndPwd(mail, pwd);
  Future signUpUserWithAllInfos(mail, pwd, firstName, lastName);
  Future signIn(mail, pwd);
}
