import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: First(),
    );
  }
}

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  late String text;

  @override
  void initState() {
    super.initState();
    text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              DisplaySimulator(
                text: text,
                border: true,
                debug: true,
              ),
              SizedBox(height: 48),
              _getTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Container _getTextField() {
    BorderSide borderSide = BorderSide(color: Colors.blue, width: 4);
    InputDecoration inputDecoration = InputDecoration(
      border: UnderlineInputBorder(borderSide: borderSide),
      disabledBorder: UnderlineInputBorder(borderSide: borderSide),
      enabledBorder: UnderlineInputBorder(borderSide: borderSide),
      focusedBorder: UnderlineInputBorder(borderSide: borderSide),
    );

    return Container(
        width: 200,
        child: TextField(
          maxLines: null,
          enableSuggestions: false,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.yellow, fontSize: 32, fontFamily: "Monospace"),
          decoration: inputDecoration,
          onChanged: (val) {
            setState(() {
              text = val;
            });
          },
          //controller: _controller,
        ));
  }
}
