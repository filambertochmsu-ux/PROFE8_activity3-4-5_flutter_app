import 'package:flutter/material.dart';
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/order_page.dart';
import 'views/settings_page.dart';

void main() {
  runApp(QuickBiteApp());
}

class QuickBiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QuickBite Food Ordering",
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/order': (context) => OrderPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
