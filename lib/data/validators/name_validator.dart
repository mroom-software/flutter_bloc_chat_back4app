class NameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Name cannot be empty' : null;
  }
}