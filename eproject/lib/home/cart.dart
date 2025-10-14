// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return const Scaffold(
//         body: Center(child: Text("Please log in to view your cart.")),
//       );
//     }

//     final cartRef = FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .collection('cart');

//     return Scaffold(
//       backgroundColor: const Color(0xfff6f6f6),
//       appBar: AppBar(
//         backgroundColor: const Color(0xff0d2b3c),
//         title: const Text(
//           "My Cart",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: cartRef.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("Your cart is empty 🛒"));
//           }

//           final cartItems = snapshot.data!.docs;
//           final totalPrice = cartItems.fold<double>(
//             0,
//             (sum, doc) => sum + (doc['price'] * doc['quantity']),
//           );

//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(10),
//                   itemCount: cartItems.length,
//                   itemBuilder: (context, index) {
//                     final item = cartItems[index];
//                     final docId = item.id;

//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(10),
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(
//                             item['imageUrl'],
//                             width: 60,
//                             height: 60,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         title: Text(
//                           item['name'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         subtitle: Text(
//                           "\$${item['price']}",
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                         trailing: Column(
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.remove_circle_outline),
//                                   onPressed: () {
//                                     if (item['quantity'] > 1) {
//                                       cartRef.doc(docId).update({
//                                         'quantity': FieldValue.increment(-1),
//                                       });
//                                     } else {
//                                       cartRef.doc(docId).delete();
//                                     }
//                                   },
//                                 ),
//                                 Text("${item['quantity']}"),
//                                 IconButton(
//                                   icon: const Icon(Icons.add_circle_outline),
//                                   onPressed: () {
//                                     cartRef.doc(docId).update({
//                                       'quantity': FieldValue.increment(1),
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: () => cartRef.doc(docId).delete(),
//                               child: const Text(
//                                 "Remove",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(0, -2),
//                       blurRadius: 6,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Total:",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "\$${totalPrice.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Proceeding to checkout..."),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xff0d2b3c),
//                         minimumSize: const Size(double.infinity, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: const Text(
//                         "Checkout",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'checkout.dart'; // <-- create this page

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final user = FirebaseAuth.instance.currentUser;
  final Map<String, bool> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to view your cart.")),
      );
    }

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart');

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2b3c),
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Your cart is empty 🛒",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          final cartItems = snapshot.data!.docs;

          // Calculate total for selected items
          final totalPrice = cartItems.fold<double>(
            0,
            (sum, doc) =>
                sum +
                ((selectedItems[doc.id] == true
                        ? (doc['price'] * doc['quantity'])
                        : 0)
                    as double),
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final docId = item.id;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Checkbox(
                              value: selectedItems[docId] ?? false,
                              activeColor: const Color(0xff0d2b3c),
                              onChanged: (value) {
                                setState(() {
                                  selectedItems[docId] = value!;
                                });
                              },
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item['imageUrl'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "\$${item['price']}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          size: 22,
                                        ),
                                        onPressed: () {
                                          if (item['quantity'] > 1) {
                                            cartRef.doc(docId).update({
                                              'quantity': FieldValue.increment(
                                                -1,
                                              ),
                                            });
                                          } else {
                                            cartRef.doc(docId).delete();
                                          }
                                        },
                                      ),
                                      Text(
                                        "${item['quantity']}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          size: 22,
                                        ),
                                        onPressed: () {
                                          cartRef.doc(docId).update({
                                            'quantity': FieldValue.increment(1),
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => cartRef.doc(docId).delete(),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -2),
                      blurRadius: 6,
                    ),
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed:
                          selectedItems.values.any((isSelected) => isSelected)
                          ? () {
                              // Get selected item data
                              // Get selected item data
                              final selectedDocs = cartItems
                                  .where(
                                    (item) => selectedItems[item.id] == true,
                                  )
                                  .map(
                                    (item) => {
                                      'id': item.id,
                                      'name': item['name'],
                                      'price': item['price'],
                                      'quantity': item['quantity'],
                                      'imageUrl': item['imageUrl'],
                                    },
                                  )
                                  .toList();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckoutPage(selectedItems: selectedDocs),
                                ),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text(
                        "Proceed to Checkout",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0d2b3c),
                        disabledBackgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
