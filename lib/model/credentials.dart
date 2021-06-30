class Email {
  String email = '';

  Email(this.email);

  bool get isValid {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}

class Password {
  String password = '';

  Password(this.password);

  PasswordStrength get passwordStrength {
    return PasswordStrength.fromCredentials(password);
  }

}

class PasswordStrength{

  bool containsUpper = false;
  bool containsLower = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool isLong = false;
  bool isVeryLong = false;

  PasswordStrength(){
    this.containsUpper = false;
    this.containsLower = false;
    this.containsNumber = false;
    this.containsSpecialChar = false;
    this.isLong = false;
  }

  PasswordStrength.fromCredentials(String password){
    this.containsUpper = RegExp(r'(?=.*[A-Z])').hasMatch(password);
    this.containsLower = RegExp(r'(?=.*[a-z])').hasMatch(password);
    this.containsNumber = RegExp(r'(?=.*[0-9])').hasMatch(password);
    this.containsSpecialChar = RegExp(r'(?=.*[!@#\$&*~])').hasMatch(password);
    this.isLong = password.length>=8;
    this.isVeryLong = password.length>=14;
  }

  int get strength {
    int strength = 0;
    if (containsUpper) {
      strength++;
    }
    if (containsLower) {
      strength++;
    }
    if (containsNumber) {
      strength++;
    }
    if (containsSpecialChar) {
      strength++;
    }
    if (isLong) {
      strength++;
    }
    if (isVeryLong) {
      strength++;
    }
    return strength;
  }

}

