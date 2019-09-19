
import 'package:flutter_bloc_back4app/helpers/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test email valid returns true', () {
    /* 
      input: trongdth@gmail.com
      expected: true
    */
    var email = 'trongdth@gmail.com';
    var actual = Utils.isValidEmail(email);
    var expected = true;
    expect(actual, expected);
  });

}