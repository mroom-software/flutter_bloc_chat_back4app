import 'package:flutter_bloc_back4app/helpers/utils.dart';

class EmailFieldValidator {
  static String validate(String value) {
    if (!Utils.isValidEmail(value) || value.isEmpty) {
      return 'Email is invalid';
    }
    return null;
  }
}