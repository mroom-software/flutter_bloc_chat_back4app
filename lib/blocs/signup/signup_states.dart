import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SignupState extends Equatable {
  final List<Object> props;
  const SignupState([this.props = const []]);
}

class SignupInitial extends SignupState {
  @override
  String toString() => 'SignupInitial';
}

class SignupLoading extends SignupState {
  @override
  String toString() => 'SignupLoading';
}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'SignupFailure { error: $error }';
}

class SignupSuccess extends SignupState {
  @override
  String toString() => 'SignupSuccess';
}
