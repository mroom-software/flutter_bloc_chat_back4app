import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  SignupEvent([List props = const []]) : super(props);
}

class SignupButtonPressed extends SignupEvent {
  final String username;
  final String email;
  final String password;

  SignupButtonPressed({
    this.username,
    this.email, 
    this.password,
  }) : super([username, email, password]);

  @override
  String toString() => 'SignupButtonPressed { username: $username, email: $email, password: $password }';

}