// lib/views/about_page.dart
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About QuickBite")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              'https://picsum.photos/600/250', // sample internet image
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            const Text(
              "QuickBite is a food ordering app built with Flutter. ",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
