import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ValidationFormUtil {
  static String? validateNotNull(
    BuildContext context,
    String? value,
    fieldName,
  ) {
    if (value == "") {
      return AppLocalizations.of(context)!.validateNotNull(fieldName);
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String email) {
    final isNull = validateNotNull(context, email, 'email');
    if (isNull == null) {
      return EmailValidator.validate(email)
          ? null
          : AppLocalizations.of(context)!.validateEmail;
    }
    return isNull;
  }

  static String? validatePassword(BuildContext context, String password) {
    Pattern number = r'^(?=.*?[0-9]+.*)';
    Pattern alphabet = r'(?=.*?[a-zA-Z]+.*)';
    RegExp regex = RegExp(number as String);
    final isNull = validateNotNull(
      context,
      password,
      AppLocalizations.of(context)!.password,
    );
    if (isNull == null) {
      if (password.length < 6) {
        return AppLocalizations.of(context)!.validatePasswordLength;
      } else {
        if (!regex.hasMatch(password)) {
          return AppLocalizations.of(context)!.validatePasswordContainNumber;
        } else {
          regex = RegExp(alphabet as String);
          if (!regex.hasMatch(password)) {
            return AppLocalizations.of(context)!
                .validatePasswordContainAlphabet;
          }
          return null;
        }
      }
    }
    return isNull;
  }
}
