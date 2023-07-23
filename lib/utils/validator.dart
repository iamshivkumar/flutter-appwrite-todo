import 'package:email_validator/email_validator.dart';

import 'package:todo/utils/extensions.dart';

class Validators {
  static String? required(String? v) {
    if (v?.crim == null) {
      return "Required";
    } else {
      return null;
    }
  }

  static String? email(String? v) {
    return required(v) ??
        (EmailValidator.validate(v ?? "") ? null : "Enter valid email");
  }
}
