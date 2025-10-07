import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("QuickBite Home"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.local_offer), text: "Offers"),
              Tab(icon: Icon(Icons.update), text: "Updates"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Today's Deals!")),
            Center(child: Text("App Updates and News")),
          ],
        ),
      ),
    );
  }
}
