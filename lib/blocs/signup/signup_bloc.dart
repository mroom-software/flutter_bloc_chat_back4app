import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_events.dart';
import 'package:flutter_bloc_back4app/blocs/signup/signup_events.dart';
import 'package:flutter_bloc_back4app/blocs/signup/signup_states.dart';
import 'package:flutter_bloc_back4app/repositories/user_repos.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final BaseUserRepository userRepository;
  final AuthBloc authBloc;

  SignupBloc({this.userRepository, this.authBloc}) : assert(userRepository != null), assert(authBloc != null);

  @override
  SignupState get initialState => SignupInitial();

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupButtonPressed) {
      yield SignupLoading();
      try {
        final user = await userRepository.signup(
          username: event.username,
          email: event.email,
          password: event.password,
        );

        if (user != null) {
          yield SignupSuccess();
          authBloc.dispatch(LoggedIn(user: user));
          
        } else {
          yield SignupFailure(error: 'Signup Failed');
        }
        
      } catch (error) {
        yield SignupFailure(error: error.toString());
      } finally {
        yield SignupSuccess();
      }
    }
  }
  
}