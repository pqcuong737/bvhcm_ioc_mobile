class Register {
  String email;
  String password;
  Register({this.email, this.password});

  Map toJson() => {"email": email, "password": password};
}
