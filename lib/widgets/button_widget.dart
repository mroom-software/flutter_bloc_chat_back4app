import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {

  final Function onPressed;
  final String title;

  const ButtonWidget({
    Key key, 
    @required this.onPressed, 
    @required this.title}) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.0, 1.0],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xFF645AFF),
            Color(0xFFA573FF),
          ],
        ),
      ),
      child: FlatButton(
        onPressed: () {
          if(widget.onPressed != null) {
            widget.onPressed();
          }
        },
        child: Center(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}