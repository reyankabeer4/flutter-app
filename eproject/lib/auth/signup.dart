import 'package:eproject/auth/login.dart';
import 'package:eproject/services/firebase_service.dart';
import 'package:flutter/material.dart';

class SignUpApp extends StatefulWidget {
  const SignUpApp({super.key});

  @override
  State<SignUpApp> createState() => _SignUpAppState();
}

class _SignUpAppState extends State<SignUpApp> {
  final FirebaseService _authService = FirebaseService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
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


              // Welcome text
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign up to get started',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              // Full Name Field
              _buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hintText: 'Enter your full name',
                prefixIcon: Icons.person_outline,
              ),

              const SizedBox(height: 20),

              // Email Field
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password Field
              _buildPasswordField(
                controller: _passwordController,
                label: 'Password',
                hintText: 'Enter your password',
                isConfirm: false,
              ),

              const SizedBox(height: 20),

              // Confirm Password Field
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                hintText: 'Confirm your password',
                isConfirm: true,
              ),

              const SizedBox(height: 30),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 40),

              // Already have an account
              Center(
                child: GestureDetector(
                  onTap: _navigateToLogin,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            color: Colors.blue,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(prefixIcon, color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool isConfirm,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isConfirm ? _obscureConfirmPassword : _obscurePassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600]),
            suffixIcon: IconButton(
              icon: Icon(
                (isConfirm ? _obscureConfirmPassword : _obscurePassword)
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  if (isConfirm) {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  } else {
                    _obscurePassword = !_obscurePassword;
                  }
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  void _signUp() async {
    // Validate fields
    if (_fullNameController.text.isEmpty) {
      _showError('Please enter your full name');
      return;
    }

    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _showError('Please enter a valid email address');
      return;
    }

    if (_passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters long');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Call Firebase service
    AuthResult result = await _authService.signUpWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _fullNameController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (result.isSuccess) {
      // Show success message
      _showSuccess(
        'Account created successfully for ${_fullNameController.text}',
      );

      // Send email verification
      await _authService.sendEmailVerification();

      // Navigate to home page
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      _showError(result.error!);
    }
  }

  void _navigateToLogin() {
    // You'll need to create a LoginPage class or adjust this navigation
    // For now, I'll show a message
    // _showSuccess('Navigate to login page');

    // Uncomment and adjust when you have a LoginPage:
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
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
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }
}
