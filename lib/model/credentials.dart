class Credentials{

  final String email;
  final String password;

  Credentials({required this.email, required this.password});

  bool get passwordIsValid {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  bool get emailIsValid {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}

class PasswordStrength{

  bool containsUpper = false;
  bool containsLower = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool validLength = false;

  PasswordStrength({
    this.containsUpper = false,
    this.containsLower = false,
    this.containsNumber = false,
    this.containsSpecialChar = false,
    this.validLength = false,
  });

}