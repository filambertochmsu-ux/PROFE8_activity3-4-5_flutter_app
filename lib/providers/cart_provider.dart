import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _items = {};

  Map<String, int> get items => Map.unmodifiable(_items);
  int get totalItems => _items.values.fold(0, (a, b) => a + b);

  void add(String name, {int qty = 1}) {
    _items[name] = (_items[name] ?? 0) + qty;
    notifyListeners();
  }

  void update(String name, int qty) {
    if (qty <= 0) {
      _items.remove(name);
    } else {
      _items[name] = qty;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
