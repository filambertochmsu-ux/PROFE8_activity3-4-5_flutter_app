import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final nameController = TextEditingController(text: "Default Name");
  final usernameController = TextEditingController(text: "DefaultUser");
  final contactController =
      TextEditingController(text: "Default Contact Number");
  final addressController = TextEditingController(text: "Default Address");
  bool deliveryNotif = false;

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Settings updated successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: "Contact Number"),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: "Address"),
            ),
            SwitchListTile(
              title: Text("Enable Delivery Notifications"),
              value: deliveryNotif,
              onChanged: (val) => setState(() => deliveryNotif = val),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveSettings, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
