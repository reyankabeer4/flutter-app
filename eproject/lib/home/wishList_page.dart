import 'package:flutter/material.dart';
// import 'product_detail_page.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  final List<Map<String, dynamic>> wishlist = const [
    {
      "image": "assets/images/book7.jpg",
      "title": "Floral Lace Elegance",
      "subtitle": "Bloom with elegance.",
      "price": 16.00,
      "rating": 5.0,
    },
    {
      "image": "assets/images/book5.jpg",
      "title": "Sleek Satin Glamour",
      "subtitle": "Satin, sleek, glamorous.",
      "price": 12.00,
      "rating": 4.5,
    },
    {
      "image": "assets/images/book3.jpg",
      "title": "Timeless Glam Look",
      "subtitle": "Radiate timeless glam.",
      "price": 10.00,
      "rating": 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2b3c),
        // elevation: 0,
        title: const Text(
          "WishList",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,

            color: Colors.white,
          ),
        ),
        // centerTitle: true,
        // bottom: TabBar(
        // controller: _tabController,
        // indicatorColor: Colors.white,
        // labelColor: Colors.white,
        // unselectedLabelColor: Colors.white70,
        // tabs: const [
        // Tab(text: "Today"),
        // Tab(text: "This Week"),
        // Tab(text: "Earlier"),
        // ],
        // ),
      ),

      // appBar: AppBar(
      //   title: const Text("Wishlist", style: TextStyle(color: Colors.black)),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(color: Colors.black),
      // ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final item = wishlist[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              // context,
              // MaterialPageRoute(
              // builder: (_) => ProductDetailPage(product: item)
              // ),
              // );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(16),
                    ),
                    child: Image.network(
                      item["image"],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["subtitle"],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < item["rating"].round()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${item["price"].toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.orange),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.orange,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: 1,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Wishlist',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      //   ],
      // ),
    );
  }
}
