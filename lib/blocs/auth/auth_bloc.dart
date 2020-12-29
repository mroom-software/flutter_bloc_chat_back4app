import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_states.dart';
import 'package:flutter_bloc_back4app/repositories/user_repos.dart';
import 'package:meta/meta.dart';

class AuthCubit extends Cubit<AuthenticationState> {
  final BaseUserRepository userRepository;

  AuthCubit({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthenticationUninitialized());

  Future<void> appStarted() async {
    var user = await userRepository.currentUser();
    if (user != null) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }
}
