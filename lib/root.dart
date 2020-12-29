import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_states.dart';
import 'package:flutter_bloc_back4app/screens/home.dart';
import 'package:flutter_bloc_back4app/screens/login.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    context.read<AuthCubit>().appStarted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return HomeScreen();
        }

        return LoginScreen();
      },
    );
  }
}
