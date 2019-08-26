import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignupState extends Equatable{
  SignupState([List props = const[]]) : super([props]);
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