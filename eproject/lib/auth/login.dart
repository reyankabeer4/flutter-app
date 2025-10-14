// import 'package:eproject/Admin/dashboard.dart';
// import 'package:eproject/auth/forgetpassword.dart';
// import 'package:eproject/auth/signup.dart';
// import 'package:eproject/home/home.dart';
// import 'package:eproject/services/firebase_service.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final FirebaseService _firebaseService = FirebaseService();

//   bool _obscurePassword = true;
//   bool _isLoading = false;

//   String adminEmail = "admin@app.com";
//   String adminPassword = "admin123";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back button
//               IconButton(
//                 onPressed: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignUpApp()),
//                 ),
//                 icon: const Icon(Icons.arrow_back_ios, size: 20),
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),

//               const SizedBox(height: 40),

//               // Welcome text
//               const Text(
//                 'Welcome Back!',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               const Text(
//                 'Log in to your account',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),

//               const SizedBox(height: 40),

//               // Email Field
//               _buildTextField(
//                 controller: _emailController,
//                 label: 'Email',
//                 hintText: 'Enter your email',
//                 prefixIcon: Icons.email_outlined,
//               ),

//               const SizedBox(height: 20),

//               // Password Field
//               _buildPasswordField(),

//               const SizedBox(height: 16),

//               // Forgot Password
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: _forgotPassword,
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                       color: Color(0xff0d2b3c),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Login Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff0d2b3c),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Colors.white,
//                             ),
//                           ),
//                         )
//                       : const Text(
//                           'Log In',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Divider with "or"
//               Row(
//                 children: [
//                   Expanded(
//                     child: Divider(color: Colors.grey[300], thickness: 1),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text(
//                       'or continue with',
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                   ),
//                   Expanded(
//                     child: Divider(color: Colors.grey[300], thickness: 1),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 50),

//               // Social Login Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildSocialButton(Icons.g_mobiledata, 'Google'),
//                   _buildSocialButton(Icons.apple, 'Apple'),
//                   _buildSocialButton(Icons.facebook, 'Facebook'),
//                 ],
//               ),

//               const SizedBox(height: 50),

//               // Don't have an account
//               Center(
//                 child: GestureDetector(
//                   onTap: _navigateToSignUp,
//                   child: RichText(
//                     text: const TextSpan(
//                       text: 'Don\'t have an account? ',
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                       children: [
//                         TextSpan(
//                           text: 'Sign Up',
//                           style: TextStyle(
//                             color: Color(0xff0d2b3c),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hintText,
//     required IconData prefixIcon,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           keyboardType: TextInputType.emailAddress,
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey[400]),
//             prefixIcon: Icon(prefixIcon, color: Colors.grey[600]),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Colors.blue),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             filled: true,
//             fillColor: Colors.grey[50],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Password',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: _passwordController,
//           obscureText: _obscurePassword,
//           decoration: InputDecoration(
//             hintText: 'Enter your password',
//             hintStyle: TextStyle(color: Colors.grey[400]),
//             prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600]),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                 color: Colors.grey[600],
//               ),
//               onPressed: () {
//                 setState(() {
//                   _obscurePassword = !_obscurePassword;
//                 });
//               },
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Colors.blue),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             filled: true,
//             fillColor: Colors.grey[50],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSocialButton(IconData icon, String label) {
//     return SizedBox(
//       height: 56,
//       child: OutlinedButton(
//         onPressed: () => _socialLogin(label),
//         style: OutlinedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: BorderSide(color: Colors.grey[300]!),
//         ),
//         child: Row(
//           spacing: 2,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 18, color: Colors.grey[700]),
//             Text(
//               label,
//               style: TextStyle(color: Colors.grey[700], fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // void _login() async {
//   //   // Validate fields
//   //   if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
//   //     _showError('Please enter a valid email address');
//   //     return;
//   //   }

//   //   if (_passwordController.text.isEmpty) {
//   //     _showError('Please enter your password');
//   //     return;
//   //   }

//   //   // Simulate login process
//   //   setState(() {
//   //     _isLoading = true;
//   //   });

//   //   if (_emailController.text == adminEmail &&
//   //       _passwordController.text == adminPassword) {
//   //     Navigator.pushAndRemoveUntil(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => AdminDashboard()),
//   //       (route) => false,
//   //     );
//   //   } else {
//   //     _firebaseService
//   //         .userLogin(
//   //           email: _emailController.text,
//   //           password: _passwordController.text,
//   //         )
//   //         .then((value) {
//   //           setState(() {
//   //             _isLoading = false;
//   //           });
//   //           ScaffoldMessenger.of(
//   //             context,
//   //           ).showSnackBar(SnackBar(content: Text("Success")));
//   //           Navigator.pushAndRemoveUntil(
//   //             context,
//   //             MaterialPageRoute(builder: (context) => Home()),
//   //             (route) => false,
//   //           );
//   //         })
//   //         .catchError((error) {
//   //           setState(() {
//   //             _isLoading = false;
//   //           });
//   //           ScaffoldMessenger.of(
//   //             context,
//   //           ).showSnackBar(SnackBar(content: Text(error.toString())));
//   //         });
//   //   }
//   // }

//   void _login() async {
//     // Validate inputs
//     if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
//       _showError('Please enter a valid email address');
//       return;
//     }
//     if (_passwordController.text.isEmpty) {
//       _showError('Please enter your password');
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // 🔹 Step 1: Login with Firebase
//       final userCredential = await _firebaseService.userLogin(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       final user = userCredential.user;
//       if (user == null) {
//         throw Exception("User not found");
//       }

//       // 🔹 Step 2: Fetch userType from Firestore
//       final snapshot = await _firebaseService.getUserData(user.uid);
//       if (!snapshot.exists) {
//         throw Exception("User data not found in Firestore");
//       }

//       final userData = snapshot.data() as Map<String, dynamic>?;
//       final int userType = userData?['userType'] ?? 0;

//       // 🔹 Step 3: Navigate based on userType
//       setState(() => _isLoading = false);

//       if (userType == 1) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const AdminDashboard()),
//           (route) => false,
//         );
//       } else {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const Home()),
//           (route) => false,
//         );
//       }

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Login Successful")));
//     } catch (error) {
//       setState(() => _isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
//       );
//     }
//   }

//   void _socialLogin(String platform) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Login with $platform clicked'),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }

//   void _forgotPassword() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
//     );
//   }

//   void _navigateToSignUp() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => SignUpApp()),
//     );
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

import 'package:eproject/Admin/dashboard.dart';
import 'package:eproject/auth/forgetpassword.dart';
import 'package:eproject/auth/signup.dart';
import 'package:eproject/home/home.dart';
import 'package:eproject/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 40),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Log in to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _forgotPassword,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xff0d2b3c),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0d2b3c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 50),

              Center(
                child: GestureDetector(
                  onTap: _navigateToSignUp,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Color(0xff0d2b3c),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ LOGIN FUNCTION WITH ROLE CHECK
  Future<void> _login() async {
    // Validate inputs
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _showError('Please enter a valid email address');
      return;
    }
    if (_passwordController.text.isEmpty) {
      _showError('Please enter your password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 🔹 Step 1: Login with Firebase
      await _firebaseService.userLogin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 🔹 Step 2: Get user info
      User? user = _firebaseService.currentUser;
      if (user == null) throw Exception("User not found");

      // 🔹 Step 3: Fetch user data
      final userData = await _firebaseService.getUserData(user.uid);
      if (userData == null) throw Exception("User data not found in Firestore");

      // 🔹 Step 4: Check role
      final int userType = userData['userType'] ?? 0;

      setState(() => _isLoading = false);

      // 🔹 Step 5: Navigate by role
      if (userType == 1) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AdminDashboard()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Home()),
          (route) => false,
        );
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));
    } catch (error) {
      setState(() => _isLoading = false);
      _showError(error.toString());
    }
  }

  // 🔹 TextField widgets
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            hintText: 'Enter your password',
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
    );
  }

  void _navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpApp()),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
