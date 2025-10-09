import 'package:eproject/auth/signup.dart';
import 'package:eproject/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
          return const SignUpApp(); // your sign-in screen
        }

        // 🔹 If user is logged in → check Firestore role
        // final user = snapshot.data!;
        // return FutureBuilder<DocumentSnapshot>(
        //   future: FirebaseFirestore.instance
        //       .collection('users')
        //       .doc(user.uid)
        //       .get(),
        //   builder: (context, userSnapshot) {
        //     if (!userSnapshot.hasData) {
        //       return const Center(child: CircularProgressIndicator());
        //     }

        //     final userData = userSnapshot.data!;
        //     final isAdmin = userData['admin'] == true;

        //     // 🔹 Redirect based on role
        //     if (isAdmin) {
        //       return const Admindashboard();
        //     } else {
        //       return const Home();
        //     }
        //   },
        // );

        if (snapshot.hasData) {
          return Home();
        } else {
          return SignUpApp();
        }
      },
    );
  }
}
