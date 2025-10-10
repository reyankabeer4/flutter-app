import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample orders (you can fetch these from Firebase or API later)
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD-1001',
        'customer': 'Reyan Kabeer',
        'total': 2500,
        'status': 'Delivered',
        'date': '2025-10-10',
      },
      {
        'id': 'ORD-1002',
        'customer': 'Ali Ahmad',
        'total': 1800,
        'status': 'Pending',
        'date': '2025-10-09',
      },
      {
        'id': 'ORD-1003',
        'customer': 'Hamza Khan',
        'total': 3200,
        'status': 'Shipped',
        'date': '2025-10-08',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff0d2b3c),
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.receipt_long,
                color: const Color(0xff0d2b3c),
              ),
              title: Text(
                order['id'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Customer: ${order['customer']}"),
                  Text("Date: ${order['date']}"),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rs ${order['total']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    order['status'],
                    style: TextStyle(
                      color: order['status'] == 'Delivered'
                          ? Colors.green
                          : order['status'] == 'Pending'
                          ? Colors.orange
                          : Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
