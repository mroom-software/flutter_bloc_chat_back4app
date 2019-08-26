class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password cannot be empty' : null;
  }
}