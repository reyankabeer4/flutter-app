// import 'package:eproject/auth/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:eproject/services/firebase_service.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String? userName = user?.displayName ?? user?.email ?? "Guest";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         automaticallyImplyLeading: false, // remove back arrow
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 40,
//               backgroundImage: AssetImage(
//                 "assets/images/channels4_profile.jpg",
//               ),
//             ),
//             const SizedBox(height: 15),
//             Text(
//               userName,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 40),

//             // Logout button
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//                 minimumSize: Size(double.infinity, 50),
//               ),
//               onPressed: () async {
//                 await FirebaseAuth.instance.signOut();

//                 if (!mounted)
//                   return; // async ke baad context safe karne ke liye

//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                   (Route<dynamic> route) =>
//                       false, // sari purani routes hata dega
//                 );
//                 // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//               },
//               icon: const Icon(Icons.logout),
//               label: const Text("Logout"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:eproject/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? userName = user?.displayName ?? "reyan";
    String? phoneNumber = user?.phoneNumber ?? "+123456789";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Account Overview Title
            const Text(
              "Account Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Menu Items
            _buildMenuCard(),

            const SizedBox(height: 40),

            // Logout button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                if (!mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.person_outline,
              title: "My Profile",
              onTap: () {
                // Navigate to My Profile
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.shopping_bag_outlined,
              title: "My Orders",
              onTap: () {
                // Navigate to My Orders
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.currency_exchange_outlined,
              title: "Refund",
              onTap: () {
                // Navigate to Refund
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.lock_outline,
              title: "Change Password",
              onTap: () {
                // Navigate to Change Password
              },
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.language_outlined,
              title: "Change Language",
              onTap: () {
                // Navigate to Change Language
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700], size: 24),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey[500],
        size: 16,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      minLeadingWidth: 0,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
    );
  }
}
