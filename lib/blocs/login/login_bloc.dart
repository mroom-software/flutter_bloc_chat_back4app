import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/blocs/login/login_states.dart';
import 'package:flutter_bloc_back4app/repositories/user_repos.dart';

class LoginCubit extends Cubit<LoginState> {
  final BaseUserRepository userRepository;

  LoginCubit({this.userRepository})
      : assert(userRepository != null),
        super(LoginInitial());

  Future<void> loginButtonPressed({String username, String email, String password}) async {
    emit(LoginLoading());
    try {
      final user = await userRepository.authenticate(
        username: username,
        email: email,
        password: password,
      );

      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Login Failed'));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
