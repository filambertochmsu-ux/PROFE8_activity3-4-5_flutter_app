import 'package:flutter/material.dart';

class ReceiptPage extends StatelessWidget {
  final String fullName;
  final String address;
  final String contact;
  final Map<String, int> items;
  final int total;

  ReceiptPage({
    required this.fullName,
    required this.address,
    required this.contact,
    required this.items,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Receipt")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("QuickBite Receipt",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(),
            Text("Customer: $fullName"),
            Text("Address: $address"),
            Text("Contact: $contact"),
            Divider(),
            Text("Items Ordered:"),
            ...items.entries
                .where((e) => e.value > 0)
                .map((e) => Text("${e.key} x${e.value}")),
            Divider(),
            Text("Total: ₱$total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Spacer(),
            Center(child: Text("Thank you for ordering!")),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Reset quantities when leaving the receipt
                  items.updateAll((key, value) => 0);

                  // Go back to order page
                  Navigator.pushReplacementNamed(context, '/order');
                },
                child: Text("Back to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
