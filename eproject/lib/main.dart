import 'package:eproject/Admin/dashboard.dart';
import 'package:eproject/auth/signup.dart';
import 'package:eproject/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Project App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 🔹 If user not logged in → show SignIn
        if (!snapshot.hasData) {
          print("🔴 No user logged in");
          return const SignUpApp(); // your sign-in screen
        }

        final user = FirebaseAuth.instance.currentUser;
        print("🟢 Logged in user: ${user?.email}");

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print("❌ Firestore error: ${snapshot.error}");
              return const Center(child: Text("Error loading data"));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              print("⚠️ No user document found for: ${user.email}");
              return const Center(child: Text("User not found"));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            print("🧩 Firestore user data: $data");

            final userType = data['userType'] ?? 0;
            print("🧠 userType value: $userType");

            if (userType == 1) {
              print("✅ Redirecting to Admin Dashboard");
              return const AdminDashboard();
            } else {
              print("👤 Redirecting to Home");
              return const Home();
            }
          },
        );
      },
    );
  }
}
