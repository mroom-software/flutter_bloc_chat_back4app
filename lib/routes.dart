
import 'package:flutter/material.dart';
import 'package:flutter_bloc_back4app/repositories/user_repos.dart';
import 'package:flutter_bloc_back4app/root.dart';

class Routes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(248, 249, 250, 1),
        primaryColor: Color.fromRGBO(81, 81, 81, 1),
        accentColor: Color.fromRGBO(207, 207, 207, 1),
        buttonColor: Colors.white,
        bottomAppBarColor: Color.fromRGBO(0, 123, 255, 1),
        fontFamily: 'Avenir',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500,),
          body1: TextStyle(fontSize: 15.0, fontStyle: FontStyle.normal,),
          title: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal,),
          subtitle: TextStyle(fontSize: 11.0, fontStyle: FontStyle.normal,),
          display1: TextStyle(fontSize: 13.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(81, 81, 81, 1)),
          button: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, color: Colors.white),
        ),
      ),
      routes: {
        '/': (context) => Root(userRepository: UserRepository()),
      },
    );
  }

}