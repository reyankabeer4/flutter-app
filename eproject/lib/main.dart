// import 'package:eproject/Admin/dashboard.dart';
// import 'package:eproject/auth/signup.dart';
// import 'package:eproject/home/home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'E-Project App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: AuthGate(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return StreamBuilder(
//     //   stream: FirebaseAuth.instance.authStateChanges(),
//     //   builder: (context, snapshot) {
//     //     // 🔹 If user not logged in → show SignIn
//     //     if (!snapshot.hasData) {
//     //       print("🔴 No user logged in");
//     //       return const SignUpApp(); // your sign-in screen
//     //     }

//     //     final user = FirebaseAuth.instance.currentUser;
//     //     print("🟢 Logged in user: ${user?.email}");

//     //     return FutureBuilder<DocumentSnapshot>(
//     //       future: FirebaseFirestore.instance
//     //           .collection('users')
//     //           .doc(user!.uid)
//     //           .get(),
//     //       builder: (context, snapshot) {
//     //         if (snapshot.connectionState == ConnectionState.waiting) {
//     //           return const Center(child: CircularProgressIndicator());
//     //         }

//     //         if (snapshot.hasError) {
//     //           print("❌ Firestore error: ${snapshot.error}");
//     //           return const Center(child: Text("Error loading data"));
//     //         }

//     //         if (!snapshot.hasData || !snapshot.data!.exists) {
//     //           print("⚠️ No user document found for: ${user.email}");
//     //           return const Center(child: Text("User not found"));
//     //         }

//     //         final data = snapshot.data!.data() as Map<String, dynamic>;
//     //         print("🧩 Firestore user data: $data");

//     //         final userType = data['userType'] ?? 0;
//     //         print("🧠 userType value: $userType");

//     //         if (userType == 1) {
//     //           print("✅ Redirecting to Admin Dashboard");
//     //           return const AdminDashboard();
//     //         } else {
//     //           print("👤 Redirecting to Home");
//     //           return const Home();
//     //         }
//     //       },
//     //     );
//     //   },
//     // );
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasData) {
//           User user = snapshot.data!;
//           debugPrint("🟢 Logged in user: ${user.email}");
//           return user.email == "reyankabeer4@gmail.com"
//               ? const AdminDashboard()
//               : const Home();
//         } else {
//           debugPrint("🔴 No user logged in");
//           return const Home();
//         }
//       },
//     );
//   }
// }

import 'package:eproject/Admin/dashboard.dart';
import 'package:eproject/auth/login.dart';
import 'package:eproject/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  Widget? _nextScreen;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("🔴 No user logged in");
      setState(() {
        _nextScreen = const LoginPage();
        _isLoading = false;
      });
      return;
    }

    print("🟢 Logged in user: ${user.email}");

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        print("🧩 Firestore user data: $data");

        // ✅ Safely parse userType to int (handles both int or string)
        final userType = int.tryParse(data['userType'].toString()) ?? 0;
        print("🧠 userType value: $userType");

        setState(() {
          if (userType == 1) {
            print("✅ Redirecting to Admin Dashboard");
            _nextScreen = const AdminDashboard();
          } else {
            print("👤 Redirecting to Home");
            _nextScreen = const Home();
          }
          _isLoading = false;
        });
      } else {
        print("❌ Firestore user document not found for ${user.uid}");
        setState(() {
          _nextScreen = const LoginPage();
          _isLoading = false;
        });
      }
    } catch (e) {
      print("🚨 Error checking Firestore user: $e");
      setState(() {
        _nextScreen = const LoginPage();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return _nextScreen ?? const LoginPage();
  }
}
