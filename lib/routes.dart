import 'package:flutter/material.dart';
import 'package:flutter_bloc_back4app/screen_router.dart';

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenRouter = ScreenRouter();

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
          headline5: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
          ),
          bodyText2: TextStyle(
            fontSize: 15.0,
            fontStyle: FontStyle.normal,
          ),
          headline6: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.normal,
          ),
          subtitle2: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.normal,
          ),
          headline4: TextStyle(fontSize: 13.0, fontStyle: FontStyle.normal, color: Color.fromRGBO(81, 81, 81, 1)),
          button: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, color: Colors.white),
        ),
      ),
      onGenerateRoute: screenRouter.generateRoute,
      onUnknownRoute: screenRouter.unknownRoute,
      initialRoute: '/',
    );
  }
}
