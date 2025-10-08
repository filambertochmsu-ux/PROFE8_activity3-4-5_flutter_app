import 'package:flutter/material.dart';
import 'checkout_page.dart';
import 'user_profile.dart';
import 'login_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final notesController = TextEditingController();

  bool addUtensils = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final Map<String, int> menu = {
    "Burger": 80,
    "Fries": 50,
    "Milk Tea": 100,
    "Pizza": 150,
  };

  final Map<String, int> quantities = {
    "Burger": 0,
    "Fries": 0,
    "Milk Tea": 0,
    "Pizza": 0,
  };

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  // Order History List
  List<Map<String, dynamic>> orderHistory = [];

  int _calculateTotal() {
    int total = 0;
    menu.forEach((item, price) {
      total += price * (quantities[item] ?? 0);
    });
    return total;
  }

  void _goToCheckout() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(
            fullName: UserProfile.fullName,
            address: UserProfile.address,
            contact: UserProfile.contactNumber,
            utensils: addUtensils,
            notes: notesController.text,
            items: Map<String, int>.from(quantities),
            total: _calculateTotal(),
            date: selectedDate,
            time: selectedTime,
          ),
        ),
      );

      // Show confirmation message separately
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order added to history!")),
      );

      // Save to local order history
      setState(() {
        orderHistory.add({
          "name": UserProfile.fullName,
          "address": UserProfile.address,
          "contact": UserProfile.contactNumber,
          "items": Map<String, int>.from(quantities),
          "total": _calculateTotal(),
          "date": selectedDate,
          "time": selectedTime,
          "notes": notesController.text,
          "utensils": addUtensils,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickBite - Place Your Order"),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Delivery Info",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Name: ${UserProfile.fullName}"),
              Text("Address: ${UserProfile.address}"),
              Text("Contact: ${UserProfile.contactNumber}"),
              SizedBox(height: 20),
              Text("Menu",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...menu.keys.map((item) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$item - ₱${menu[item]}"),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (quantities[item]! > 0) {
                                  setState(() =>
                                      quantities[item] = quantities[item]! - 1);
                                }
                              },
                              icon: Icon(Icons.remove)),
                          Text("${quantities[item]}"),
                          IconButton(
                              onPressed: () {
                                setState(() =>
                                    quantities[item] = quantities[item]! + 1);
                              },
                              icon: Icon(Icons.add)),
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: _pickDate, child: Text("Pick Date")),
                  SizedBox(width: 10),
                  Text(selectedDate == null
                      ? "No date"
                      : "${selectedDate!.toLocal()}".split(' ')[0]),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: _pickTime, child: Text("Pick Time")),
                  SizedBox(width: 10),
                  Text(selectedTime == null
                      ? "No time"
                      : selectedTime!.format(context)),
                ],
              ),
              TextField(
                controller: notesController,
                decoration: InputDecoration(labelText: "Special Notes"),
              ),
              CheckboxListTile(
                title: Text("Add utensils"),
                value: addUtensils,
                onChanged: (val) => setState(() => addUtensils = val!),
              ),
              SizedBox(height: 20),
              Text("Total: ₱${_calculateTotal()}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(onPressed: _goToCheckout, child: Text("Checkout")),
              SizedBox(height: 20),
              Text("All orders are paid Cash on Delivery.",
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey)),

              SizedBox(height: 30),
              Divider(),
              Text("Order History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              // Display local list
              ...orderHistory.map((order) {
                String itemList = "";
                (order["items"] as Map<String, int>).forEach((item, qty) {
                  if (qty > 0) {
                    itemList += "$item x$qty\n";
                  }
                });

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text("Total: ₱${order['total']}"),
                    subtitle: Text(
                      "Name: ${order['name']}\n"
                      "Contact: ${order['contact']}\n"
                      "Address: ${order['address']}\n"
                      "Items:\n$itemList"
                      "Date: ${order['date']?.toString().split(' ')[0] ?? 'N/A'}\n"
                      "Time: ${order['time']?.format(context) ?? 'N/A'}\n"
                      "Notes: ${order['notes']}\n"
                      "Utensils: ${order['utensils'] ? 'Yes' : 'No'}",
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
