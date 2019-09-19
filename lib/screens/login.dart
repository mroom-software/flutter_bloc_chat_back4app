
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/login/login_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/login/login_events.dart';
import 'package:flutter_bloc_back4app/blocs/login/login_states.dart';
import 'package:flutter_bloc_back4app/blocs/signup/signup_bloc.dart';
import 'package:flutter_bloc_back4app/data/validators/email_validator.dart';
import 'package:flutter_bloc_back4app/data/validators/name_validator.dart';
import 'package:flutter_bloc_back4app/data/validators/password_validator.dart';
import 'package:flutter_bloc_back4app/screens/signup.dart';
import 'package:flutter_bloc_back4app/widgets/button_icon_widget.dart';
import 'package:flutter_bloc_back4app/widgets/button_widget.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // email + password fields
  bool _isShowPwd;
  String _email, _password, _username;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;

  @override
  void initState() {
    _isShowPwd = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _scaffoldstate.currentState.showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldstate,
            appBar: null,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.headline,
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
                        key: Key('BtnLogin'),
                        onPressed: () => _handleLogin(),
                        title: 'LOGIN',
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: Text(
                          '_____Or_____',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      ButtonIconWidget(
                        onPressed: _loadSignupScreen,
                        title: 'SIGNUP',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ), 
              ),  
            ),
          );
        },
      ),
    );
    
  }

  bool _validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _handleLogin() {
    if(_validateAndSave()) {
      _loginBloc.dispatch(LoginButtonPressed(
        username: _username,
        email: _email,
        password: _password,
      ));
    }
  }

  void _loadSignupScreen() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SignupBloc>(
          builder: (context) {
            return SignupBloc(
              authBloc: BlocProvider.of<AuthBloc>(context),
              userRepository: _loginBloc.userRepository,
            );
          },
          child: SignUpScreen(),
        );
      })
    );
  }

}