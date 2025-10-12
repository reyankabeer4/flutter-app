import 'package:eproject/home/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsRef = FirebaseFirestore.instance.collection('products');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Store", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff0d2b3c),
        actions: const [
          Icon(Icons.search, size: 25, color: Colors.white),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/channels4_profile.jpg"),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No products available."));
          }

          final products = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'name': data['name'] ?? 'Unnamed',
              'price': data['price'] ?? 0,
              'description': data['description'] ?? '',
              'imageUrl': data['imageUrl'] ?? '',
            };
          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                // Recommended Section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommended",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "See all",
                        style: TextStyle(color: Color(0xff0d2b3c)),
                      ),
                    ],
                  ),
                ),

                // 🔹 Sliding Cards (first 3)
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: products.length < 3 ? products.length : 3,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ),

                // Best Seller Section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Best Seller",
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                      const Text(
                        "See all",
                        style: TextStyle(color: Color(0xff0d2b3c)),
                      ),
                    ],
                  ),
                ),

                // 🔹 Best Seller Grid
                GridView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildBestSellerCard(context, product);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🔹 Sliding product card
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            product['imageUrl'].isNotEmpty
                ? Image.network(product['imageUrl'], fit: BoxFit.cover)
                : Image.asset("assets/images/book1.jpg", fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${product['price']}",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Best Seller Grid Card
  Widget _buildBestSellerCard(
      BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(5)),
                child: product['imageUrl'].isNotEmpty
                    ? Image.network(
                        product['imageUrl'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.asset("assets/images/book1.jpg", fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${product['price']}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff0d2b3c),
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
