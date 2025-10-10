import 'package:flutter/material.dart';

class TabDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat App Tabs"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Chats"),
              Tab(text: "Status"),
              Tab(text: "Calls"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Chat Messages")),
            Center(child: Text("Status Updates")),
            Center(child: Text("Call Logs")),
          ],
        ),
      ),
    );
  }
}
