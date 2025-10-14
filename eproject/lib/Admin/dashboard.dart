import 'package:eproject/Admin/adminProductScreen.dart';
import 'package:eproject/Admin/order_list.dart';
import 'package:eproject/Admin/users_details.dart';
import 'package:eproject/auth/login.dart';
import 'package:eproject/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () async {
      //       await FirebaseAuth.instance.signOut();

      //       // if (!mounted) return;

      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const LoginPage()),
      //         (Route<dynamic> route) => false,
      //       );
      //     },
      //     icon: Icon(Icons.logout),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   title: const Text(
      //     "Admin Dashboard",
      //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();

            // if (!mounted) return;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false,
            );
          },
          icon: Icon(Icons.logout),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff0d2b3c),
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            Row(
              children: [
                Padding(padding: const EdgeInsets.all(0.0)),
                Text("Hello Reyan !", style: TextStyle(fontSize: 25)),
              ],
            ),
            // Overview Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserListPage()),
                    );
                  },
                  child: _buildStatCard("Users", "120", LucideIcons.user),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderList()),
                    );
                  },
                  child: _buildStatCard(
                    "Orders",
                    "89",
                    LucideIcons.shoppingBag,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Revenue", "\$1,240", LucideIcons.dollarSign),
                _buildStatCard("Reports", "5", LucideIcons.barChart),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminProductScreen(),
                      ),
                    );
                  },
                  child: _buildStatCard("Product", "120", LucideIcons.user),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Recent Activities
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Activities",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  _ActivityTile(
                    icon: LucideIcons.userPlus,
                    title: "New User Registered",
                    subtitle: "James William joined today",
                  ),
                  _ActivityTile(
                    icon: LucideIcons.shoppingCart,
                    title: "New Order Received",
                    subtitle: "Order #2345 placed successfully",
                  ),
                  _ActivityTile(
                    icon: LucideIcons.settings,
                    title: "Settings Updated",
                    subtitle: "Admin changed notification settings",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF7B61FF),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            // Navigate to user list page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserListPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.users),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.personStanding),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF7B61FF)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(title, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ActivityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF7B61FF).withOpacity(0.1),
        child: Icon(icon, color: const Color(0xFF7B61FF)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }
}
