// import 'package:flutter/material.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff0d2b3c),
//         // elevation: 0,
//         title: const Text(
//           "Cart",
//           textAlign: TextAlign.start,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Example cart items (you can replace this with data from Firebase or backend)
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Blue Denim Jacket",
      "price": 45.0,
      "quantity": 1,
      "image":
          "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500",
    },
    {
      "name": "White Sneakers",
      "price": 60.0,
      "quantity": 2,
      "image":
          "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500",
    },
    {
      "name": "Black Hoodie",
      "price": 35.0,
      "quantity": 1,
      "image":
          "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500",
    },
  ];

  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item["price"] * item["quantity"]),
    );
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]["quantity"]++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("CartPage is building...");
    // print("Items in cart: ${cartItems.length}");
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2b3c),
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty 🛒",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item["image"],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item["name"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            "\$${item["price"].toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => decreaseQuantity(index),
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                  ),
                                  Text(
                                    "${item["quantity"]}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: () => increaseQuantity(index),
                                    icon: const Icon(Icons.add_circle_outline),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => removeItem(index),
                                child: const Text(
                                  "Remove",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 5,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
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
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Proceeding to checkout..."),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0d2b3c),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
