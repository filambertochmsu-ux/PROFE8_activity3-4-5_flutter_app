// lib/views/settings_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // modern icon package

import '../providers/theme_provider.dart';
import '../providers/todo_provider.dart';
import 'widgets/profile_card.dart';
import 'user_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final nameController = TextEditingController(text: "Default Name");
  final usernameController = TextEditingController(text: "DefaultUser");
  final contactController = TextEditingController(text: "09123456789");
  final addressController = TextEditingController(text: "Default Address");
  bool deliveryNotif = false;

  void _saveSettings() {
    UserProfile.fullName = nameController.text.trim().isEmpty
        ? UserProfile.fullName
        : nameController.text.trim();
    UserProfile.username = usernameController.text.trim().isEmpty
        ? UserProfile.username
        : usernameController.text.trim();
    UserProfile.contactNumber = contactController.text.trim().isEmpty
        ? UserProfile.contactNumber
        : contactController.text.trim();
    UserProfile.address = addressController.text.trim().isEmpty
        ? UserProfile.address
        : addressController.text.trim();
    UserProfile.deliveryNotif = deliveryNotif;

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Settings updated!")));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    nameController.text = UserProfile.fullName;
    usernameController.text = UserProfile.username;
    contactController.text = UserProfile.contactNumber;
    addressController.text = UserProfile.address;
    deliveryNotif = UserProfile.deliveryNotif;
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileCard(
              name: UserProfile.fullName,
              role: UserProfile.username,
              imagePath: 'assets/images/sample1.jpg',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(labelText: "Contact Number"),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),
            SwitchListTile(
              title: const Text("Enable Delivery Notifications"),
              value: deliveryNotif,
              onChanged: (val) => setState(() => deliveryNotif = val),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeProv.isDark,
              onChanged: (_) => context.read<ThemeProvider>().toggle(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _saveSettings,
              child: const Text("Save"),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "📝 To-Do List",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const TodoListSection(),
            const SizedBox(height: 30),

            // ✅ Requirement #14 — Custom Icon Set (FontAwesome)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "✨ Custom Icon Set Example (FontAwesome)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(FontAwesomeIcons.burger, size: 40, color: Colors.orange),
                SizedBox(width: 20),
                FaIcon(FontAwesomeIcons.coffee, size: 40, color: Colors.brown),
                SizedBox(width: 20),
                FaIcon(FontAwesomeIcons.cartShopping,
                    size: 40, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodoListSection extends StatefulWidget {
  const TodoListSection({Key? key}) : super(key: key);

  @override
  State<TodoListSection> createState() => _TodoListSectionState();
}

class _TodoListSectionState extends State<TodoListSection> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoProvider>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  labelText: "Add a new task",
                  isDense: true,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.deepOrange),
              onPressed: () {
                final t = _taskController.text.trim();
                if (t.isNotEmpty) {
                  context.read<TodoProvider>().addTask(t);
                  _taskController.clear();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: todo.tasks.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final text = todo.tasks[index];
            return ListTile(
              title: Text(text),
              trailing: IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                onPressed: () => context.read<TodoProvider>().removeTask(index),
              ),
            );
          },
        ),
        if (todo.tasks.isNotEmpty)
          TextButton(
            onPressed: () => context.read<TodoProvider>().clearAll(),
            child: const Text("Clear all", style: TextStyle(color: Colors.red)),
          ),

        // --- Dynamic Material Icon Example ---
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "🎨 Dynamic Material Icon Demo",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        const _DynamicIconDemo(),
      ],
    );
  }
}

class _DynamicIconDemo extends StatefulWidget {
  const _DynamicIconDemo({Key? key}) : super(key: key);

  @override
  State<_DynamicIconDemo> createState() => _DynamicIconDemoState();
}

class _DynamicIconDemoState extends State<_DynamicIconDemo> {
  Color iconColor = Colors.blue;
  double iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.favorite,
          color: iconColor,
          size: iconSize,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              iconColor = iconColor == Colors.blue ? Colors.red : Colors.blue;
              iconSize = iconSize == 40 ? 60 : 40;
            });
          },
          child: const Text("Change Color & Size"),
        ),
      ],
    );
  }
}
