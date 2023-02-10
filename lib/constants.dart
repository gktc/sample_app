import 'package:flutter/material.dart';

var green = Colors.green[50];
var buttonStyle =
    ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.pressed)) {
    return Color.fromARGB(255, 165, 239, 168);
  } else {
    return Color.fromARGB(255, 105, 196, 110);
  }
}));

// ignore: prefer_const_constructors
const textStyle = TextStyle(
  color: Color.fromARGB(255, 50, 50, 50),
  fontSize: 24,
);

const succesSnackBar = SnackBar(
  content: Text('Saved Successfullly'),
  duration: Duration(seconds: 3),
);

class CustomTextWidget extends StatelessWidget {
  final String text;
  const CustomTextWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
