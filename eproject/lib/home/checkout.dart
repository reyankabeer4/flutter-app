// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CheckoutPage extends StatelessWidget {
//   final List<QueryDocumentSnapshot> items;

//   const CheckoutPage({super.key, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     final totalPrice = items.fold<double>(
//       0,
//       (sum, doc) => sum + (doc['price'] * doc['quantity']),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Checkout"),
//         backgroundColor: const Color(0xff0d2b3c),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return ListTile(
//                     leading: Image.network(item['imageUrl'], width: 50),
//                     title: Text(item['name']),
//                     subtitle: Text(
//                       "${item['quantity']} x \$${item['price']}",
//                     ),
//                     trailing: Text(
//                       "\$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const Divider(thickness: 1.5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Total:",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "\$${totalPrice.toStringAsFixed(2)}",
//                   style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Order placed successfully! 🎉"),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff0d2b3c),
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: const Text(
//                 "Place Order",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum PaymentMethod { cashOnDelivery, creditCard, easypaisa }

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CheckoutPage({super.key, required this.selectedItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PaymentMethod? _selectedMethod = PaymentMethod.cashOnDelivery;
  bool _isPlacingOrder = false;

  double get totalPrice {
    return widget.selectedItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  Future<void> _placeOrder() async {
    if (_selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    setState(() => _isPlacingOrder = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in first')),
      );
      return;
    }

    final orderData = {
      'userId': user.uid,
      'items': widget.selectedItems,
      'totalAmount': totalPrice,
      'paymentMethod': _selectedMethod.toString().split('.').last,
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('orders').add(orderData);

      // Clear user cart (optional)
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart');
      for (var item in widget.selectedItems) {
        await cartRef.doc(item['id']).delete();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully! 🎉')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: $e')),
      );
    } finally {
      setState(() => _isPlacingOrder = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2b3c),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🧾 Order Summary
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff0d2b3c)),
                  ),
                  const SizedBox(height: 10),
                  ...widget.selectedItems.map((item) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['imageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(item['name']),
                        subtitle: Text(
                            "${item['quantity']} × \$${item['price'].toStringAsFixed(2)}"),
                        trailing: Text(
                          "\$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),

                  // 💳 Payment Method
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff0d2b3c)),
                  ),
                  const SizedBox(height: 10),
                  RadioListTile<PaymentMethod>(
                    title: const Text("Cash on Delivery"),
                    value: PaymentMethod.cashOnDelivery,
                    groupValue: _selectedMethod,
                    onChanged: (value) => setState(() {
                      _selectedMethod = value;
                    }),
                  ),
                  RadioListTile<PaymentMethod>(
                    title: const Text("Credit / Debit Card"),
                    value: PaymentMethod.creditCard,
                    groupValue: _selectedMethod,
                    onChanged: (value) => setState(() {
                      _selectedMethod = value;
                    }),
                  ),
                  RadioListTile<PaymentMethod>(
                    title: const Text("Easypaisa / JazzCash"),
                    value: PaymentMethod.easypaisa,
                    groupValue: _selectedMethod,
                    onChanged: (value) => setState(() {
                      _selectedMethod = value;
                    }),
                  ),
                ],
              ),
            ),

            // 📦 Total + Place Order Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, offset: Offset(0, -2), blurRadius: 6)
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isPlacingOrder ? null : _placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0d2b3c),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isPlacingOrder
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Place Order",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
