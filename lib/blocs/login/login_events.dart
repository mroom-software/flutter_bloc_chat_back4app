
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String email;
  final String password;

  LoginButtonPressed({this.username, this.email, this.password}) : super([username, email, password]);

  @override
  String toString() => 'LoginButtonPressed { username: $username, email: $email, password: $password }';

}