abstract class AuthenticationInterface {
  void signOff();
  Future signUpUserWithEmailAndPwd(mail, pwd);
  Future signUpUserWithAllInfos(mail, pwd, firstName, lastName);
  Future applyAsAssociation(
      String name,
      String description,
      String president,
      String mail,
      String phone,
      String address,
      String postalCode,
      String city,
      String pwd);
  Future signIn(mail, pwd);
}
