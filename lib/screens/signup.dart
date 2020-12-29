import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_states.dart';
import 'package:flutter_bloc_back4app/blocs/signup/signup_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/signup/signup_states.dart';
import 'package:flutter_bloc_back4app/data/validators/email_validator.dart';
import 'package:flutter_bloc_back4app/data/validators/name_validator.dart';
import 'package:flutter_bloc_back4app/data/validators/password_validator.dart';
import 'package:flutter_bloc_back4app/screen_router.dart';
import 'package:flutter_bloc_back4app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

const String MIN_DATETIME = '1970-01-01';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isShowPwd = false;
  String _email, _password, _username;
  SignupCubit _signupCubit;

  @override
  void initState() {
    _signupCubit = BlocProvider.of<SignupCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              context.read<AuthCubit>().appStarted();
            }
          },
        ),
        BlocListener<AuthCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              Navigator.pushNamedAndRemoveUntil(context, ScreenRouter.ROOT, (route) => false);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: null,
        body: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextFormField(
                        key: Key('Username'),
                        validator: NameFieldValidator.validate,
                        onSaved: (value) => _username = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextFormField(
                        key: Key('Email'),
                        validator: EmailFieldValidator.validate,
                        onSaved: (value) => _email = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              key: Key('Password'),
                              validator: PasswordFieldValidator.validate,
                              onSaved: (value) => _password = value,
                              obscureText: (_isShowPwd) ? false : true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your Password',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              border: Border.all(color: Color(0xFFF5F5F5)),
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isShowPwd = !_isShowPwd;
                                  });
                                },
                                child: Text(
                                  'SHOW',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF003BFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonWidget(
                    onPressed: _handleSignup,
                    title: 'SIGN UP',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _handleSignup() async {
    if (_validateAndSave()) {
      _signupCubit.signupButtonPressed(
        username: _username,
        email: _email,
        password: _password,
      );
    }
  }
}
