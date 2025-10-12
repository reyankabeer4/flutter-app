import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailsScreen({super.key, required this.product});

  Future<void> addToCart(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to add to cart.")),
      );
      return;
    }

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(product['id']);

    final cartDoc = await cartRef.get();

    if (cartDoc.exists) {
      // Increment quantity
      await cartRef.update({
        'quantity': FieldValue.increment(1),
      });
    } else {
      // Add new item
      await cartRef.set({
        'name': product['name'],
        'price': product['price'],
        'imageUrl': product['imageUrl'],
        'quantity': 1,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to cart 🛒")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        backgroundColor: const Color(0xff0d2b3c),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: product['imageUrl'].isNotEmpty
                    ? Image.network(product['imageUrl'], height: 250)
                    : Image.asset("assets/images/book1.jpg", height: 250),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${product['price']}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              product['description'] ?? "No description available.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => addToCart(context),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text("Add to Cart"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0d2b3c),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
