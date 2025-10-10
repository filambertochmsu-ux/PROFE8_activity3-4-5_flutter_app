import 'package:flutter/material.dart';
import 'receipt_page.dart';

class CheckoutPage extends StatelessWidget {
  final String fullName;
  final String address;
  final String contact;
  final bool utensils;
  final String notes;
  final Map<String, int> items;
  final int total;
  final DateTime? date;
  final TimeOfDay? time;

  CheckoutPage({
    required this.fullName,
    required this.address,
    required this.contact,
    required this.utensils,
    required this.notes,
    required this.items,
    required this.total,
    this.date,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm Your Order")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer: $fullName"),
            Text("Address: $address"),
            Text("Contact: $contact"),
            Text(
                "Delivery Date: ${date?.toString().split(' ')[0] ?? "Not set"}"),
            Text("Delivery Time: ${time?.format(context) ?? "Not set"}"),
            Divider(),
            Text("Items:"),
            ...items.entries
                .where((e) => e.value > 0)
                .map((e) => Text("${e.key} x${e.value}")),
            Divider(),
            Text("Special Notes: $notes"),
            Text("Add Utensils: ${utensils ? "Yes" : "No"}"),
            Divider(),
            Text("Total: ₱$total",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Back"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReceiptPage(
                          fullName: fullName,
                          address: address,
                          contact: contact,
                          items: Map<String, int>.from(items),
                          total: total,
                        ),
                      ),
                    );
                  },
                  child: Text("Confirm Order"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
