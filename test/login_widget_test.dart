import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/login/login_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/login/login_events.dart';
import 'package:flutter_bloc_back4app/mocks/repos/user_repos.dart';
import 'package:flutter_bloc_back4app/screens/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {

  Widget makeWidgetTestable({Widget child, LoginBloc loginBloc}) {
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        builder: (context) {
          return loginBloc;
        },
        child: child,
      ),
    );
  }

  testWidgets('Login Screen', (WidgetTester tester) async {
    MockUserRepository mockUserRepository = MockUserRepository(); 
    LoginBloc _loginBloc = LoginBloc(authBloc: AuthBloc(userRepository: mockUserRepository), userRepository: mockUserRepository);

    LoginScreen screen = LoginScreen();
    await tester.pumpWidget(makeWidgetTestable(child: screen, loginBloc: _loginBloc));

    _loginBloc.dispatch(LoginButtonPressed(
      username: 'trongdth',
      email: 'trongdth@gmail.com',
      password: '123456'
    ));

    await tester.pump();
    final loginKey = Key('BtnLogin');
    expect(find.byKey(loginKey), findsOneWidget);

  });
}
