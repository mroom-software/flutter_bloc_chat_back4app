import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginState extends Equatable {
  final List<Object> props;
  const LoginState([this.props = const []]);
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginSuccess extends LoginState {
  @override
  String toString() => 'LoginSuccess';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}
