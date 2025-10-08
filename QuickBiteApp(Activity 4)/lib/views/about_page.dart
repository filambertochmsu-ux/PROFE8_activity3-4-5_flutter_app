import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About QuickBite")),
      body: Center(
        child: Text("QuickBite is a food ordering app built with Flutter."),
      ),
    );
  }
}
