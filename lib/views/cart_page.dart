import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart (${cart.totalItems})')),
      body: cart.items.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : ListView(
              children: cart.items.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  subtitle: Text('Quantity: ${entry.value}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => context
                            .read<CartProvider>()
                            .update(entry.key, entry.value - 1),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => context
                            .read<CartProvider>()
                            .update(entry.key, entry.value + 1),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CartProvider>().clear(),
        child: Icon(Icons.delete),
        tooltip: 'Clear Cart',
      ),
    );
  }
}
