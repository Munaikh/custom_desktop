import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            child: Text('Hello World', style: TextStyle(color: Colors.white, fontSize: 100, fontWeight: FontWeight.w900),),
          ),
        ),
      ),
    );
  }
}