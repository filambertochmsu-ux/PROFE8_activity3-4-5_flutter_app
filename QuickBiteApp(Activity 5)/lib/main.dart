import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/todo_provider.dart';

// Import your pages
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/order_page.dart';
import 'views/settings_page.dart';
import 'views/home_page.dart';
import 'views/about_page.dart';
import 'views/contact_page.dart';
import 'views/tab_demo_page.dart';
import 'views/media_gallery_page.dart';
import 'views/media_player_page.dart';
import 'views/cart_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: QuickBiteApp(),
    ),
  );
}

class QuickBiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'QuickBite',
      debugShowCheckedModeBanner: false,
      themeMode: theme.mode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        fontFamily: 'RobotoCustom',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (c) => LoginPage(),
        '/register': (c) => RegisterPage(),
        '/order': (c) => OrderPage(),
        '/settings': (c) => SettingsPage(),
        '/home': (c) => HomePage(),
        '/about': (c) => AboutPage(),
        '/contact': (c) => ContactPage(),
        '/tabdemo': (c) => TabDemoPage(),
        '/gallery': (c) => MediaGalleryPage(),
        '/media': (c) => MediaPlayerPage(),
        '/cart': (c) => CartPage(),
      },
    );
  }
}
