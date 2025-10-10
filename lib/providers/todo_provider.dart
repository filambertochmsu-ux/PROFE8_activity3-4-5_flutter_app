// lib/providers/todo_provider.dart
import 'package:flutter/foundation.dart';

class TodoProvider extends ChangeNotifier {
  final List<String> _tasks = [];

  List<String> get tasks => List.unmodifiable(_tasks);

  void addTask(String task) {
    if (task.trim().isEmpty) return;
    _tasks.add(task.trim());
    notifyListeners();
  }

  void removeTask(int index) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks.removeAt(index);
    notifyListeners();
  }

  void clearAll() {
    _tasks.clear();
    notifyListeners();
  }
}
