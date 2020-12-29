import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/blocs/signup/signup_states.dart';
import 'package:flutter_bloc_back4app/repositories/user_repos.dart';

class SignupCubit extends Cubit<SignupState> {
  final BaseUserRepository userRepository;

  SignupCubit({this.userRepository})
      : assert(userRepository != null),
        super(SignupInitial());

  Future<void> signupButtonPressed({String username, email, password}) async {
    emit(SignupLoading());
    try {
      final user = await userRepository.signup(
        username: username,
        email: email,
        password: password,
      );

      if (user != null) {
        emit(SignupSuccess());
      } else {
        emit(SignupFailure(error: 'Signup Failed'));
      }
    } catch (error) {
      emit(SignupFailure(error: error.toString()));
    }
  }

  Future<void> fakeSignupSuccess() async {
    emit(SignupSuccess());
  }
}
