import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // ✅ Import Google Fonts
// ✅ Import your LoginPage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Top Bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey, // 👈 Border color
                          width: 1, // 👈 Thickness
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu,
                          size: 20,
                          color: Color(0xff0d2b3c),
                        ),

                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.search, size: 20),
                      const SizedBox(width: 20),
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          "assets/images/channels4_profile.jpg",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🔹 Recommended Section
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
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Color(0xff0d2b3c)),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Sliding Cards
            SizedBox(
              height: 220,
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                children: [
                  // Card 1
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/book2.jpg",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black54, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "The Alchemist",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "\$10",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Card 2
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/book4.jpg",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black54, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Book 2",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Card 3
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/book4.jpg",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black54, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Book 2",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Best Seller Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Best Seller", style: GoogleFonts.poppins(fontSize: 20)),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Color(0xff0d2b3c)),
                    ),
                  ),
                ],
              ),
            ),

            // Best Seller Cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.8,
              padding: EdgeInsets.all(20),
              children: [
                _buildBestSellerCard(
                  "Atomic Habits",
                  "\$15",
                  "assets/images/book1.jpg",
                ),
                _buildBestSellerCard(
                  "Rich Dad Poor Dad",
                  "\$12",
                  "assets/images/book2.jpg",
                ),
                _buildBestSellerCard(
                  "Deep Work",
                  "\$18",
                  "assets/images/book3.jpg",
                ),
                _buildBestSellerCard(
                  "Clean Code",
                  "\$25",
                  "assets/images/book4.jpg",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBestSellerCard(String title, String price, String imagePath) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    elevation: 4,
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(padding: EdgeInsets.all(20)),
        // Book Image
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),

        // Details Section
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                      color: Color(0xff0d2b3c),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Color(0xff0d2b3c),
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: const Icon(Icons.add, color: Colors.white, size: 20),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
