import 'package:email_validator/email_validator.dart';

class ValidationFormUtil {
  static String? validateNotNull(String? value, fieldName) {
    if (value == "") return '* Field $fieldName cannot be empty.';
    return null;
  }

  static String? validateEmail(String email) {
    final isNull = validateNotNull(email, 'email');
    if (isNull == null) {
      return EmailValidator.validate(email)
          ? null
          : '* Your email is failed, please check again.';
    }
    return isNull;
  }

  static String? validatePassword(String password) {
    Pattern number = r'^(?=.*?[0-9]+.*)';
    Pattern alphabet = r'(?=.*?[a-zA-Z]+.*)';
    RegExp regex = RegExp(number as String);
    final isNull = validateNotNull(password, 'password');
    if (isNull == null) {
      if (password.length < 6) {
        return '* Your password must be 8 characters.';
      } else {
        if (!regex.hasMatch(password)) {
          return '* Password must be contain numbers.';
        } else {
          regex = RegExp(alphabet as String);
          if (!regex.hasMatch(password)) {
            return '* Password must be contain alphabet.';
          }
          return null;
        }
      }
    }
    return isNull;
  }
}
