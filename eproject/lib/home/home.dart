import 'package:eproject/auth/login.dart';
import 'package:eproject/home/home_page.dart';
import 'package:eproject/home/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    // Center(child: Text("Home Page")),
    Center(child: Text("Wishlist")),
    Center(child: Text("Cart")),
    Center(child: Text("Notifications")),
    const ProfilePage(), // <-- Profile screen
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    // String userName = user?.displayName ?? user?.email ?? "Guest";

    return Scaffold(
      body: _pages[_selectedIndex],

      // Best Seller Section
      // Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text("Best Seller", style: GoogleFonts.poppins(fontSize: 20)),
      //       GestureDetector(
      //         onTap: () {},
      //         child: const Text(
      //           "See all",
      //           style: TextStyle(color: Color(0xff0d2b3c)),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      //       // Best Seller Cards
      //       GridView.count(
      //         crossAxisCount: 2,
      //         shrinkWrap: true,
      //         physics: const NeverScrollableScrollPhysics(),
      //         childAspectRatio: 0.8,
      //         padding: EdgeInsets.all(20),
      //         children: [
      //           _buildBestSellerCard(
      //             "Atomic Habits",
      //             "\$15",
      //             "assets/images/book1.jpg",
      //           ),
      //           _buildBestSellerCard(
      //             "Rich Dad Poor Dad",
      //             "\$12",
      //             "assets/images/book2.jpg",
      //           ),
      //           _buildBestSellerCard(
      //             "Deep Work",
      //             "\$18",
      //             "assets/images/book3.jpg",
      //           ),
      //           _buildBestSellerCard(
      //             "Clean Code",
      //             "\$25",
      //             "assets/images/book4.jpg",
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff0d2b3c),
        onTap: _onItemTapped,
      ),
    );
  }

  // 🔹 Reusable Best Seller Card
  //   Widget _buildBestSellerCard(String title, String price) {
  //     return Card(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       margin: const EdgeInsets.all(10),
  //       elevation: 3,
  //       child: Padding(
  //         padding: const EdgeInsets.all(12),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: Colors.blue.shade100,
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: const Center(child: Icon(Icons.book, size: 50)),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               title,
  //               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //             const SizedBox(height: 5),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   price,
  //                   style: const TextStyle(
  //                     color: Colors.blue,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const Icon(Icons.add_circle, color: Colors.blue),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
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
