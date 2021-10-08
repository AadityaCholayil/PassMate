class AuthEmail {
  String email = '';

  AuthEmail(this.email);

  bool get isValid {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}

class AuthPassword {
  String password = '';

  AuthPassword(this.password);

  void updatePassword(String newVal){
    password=newVal;
  }

  PasswordStrength get passwordStrength {
    return PasswordStrength.fromPassword(password);
  }
}

class PasswordStrength{

  List<String> list = [
    'Minimum 8 characters',
    'Atleast one uppercase character',
    'Atleast one lowercase character',
    'Atleast one number',
    'Atleast one special character (!@#\$&*~)'
  ];
  int strength = 0;

  PasswordStrength();

  PasswordStrength.fromPassword(String password){
    bool containsUpper = RegExp(r'(?=.*[A-Z])').hasMatch(password);
    bool containsLower = RegExp(r'(?=.*[a-z])').hasMatch(password);
    bool containsNumber = RegExp(r'(?=.*[0-9])').hasMatch(password);
    bool containsSpecialChar = RegExp(r'(?=.*[!@#\$&*~])').hasMatch(password);
    bool isLong = password.length>=8;
    bool isVeryLong = password.length>=11;
    if (containsUpper) {
      strength++;
      list.remove('Atleast one uppercase character');
    }
    if (containsLower) {
      strength++;
      list.remove('Atleast one lowercase character');
    }
    if (containsNumber) {
      strength++;
      list.remove('Atleast one number');
    }
    if (containsSpecialChar) {
      strength++;
      list.remove('Atleast one special character (!@#\$&*~)');
    }
    if (isLong) {
      strength++;
      list.remove('Minimum 8 characters');
    }
    if (isVeryLong) {
      strength++;
    }
  }
}

