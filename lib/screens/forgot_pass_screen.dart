import 'package:flutter/material.dart';
import 'package:plant_disease_detector/provider/login_provider.dart';
import 'package:plant_disease_detector/widgets/round_button.dart';
import 'package:provider/provider.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            // Top Image
           Container(
            height: 325,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/plant1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
            const SizedBox(height: 20),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Text(
                    "Reset Your Password",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff256724),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Enter your registered email to receive a password reset link.",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                          
                  // Email Field
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: const Color(0xff256724),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email, color: Color(0xff256724)),
                        hintText: "Enter your email",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff256724),
                        ),
                        filled: true,
                        fillColor: Colors.green.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                          
                  // Reset Password Button
                  RoundButton(
                    title: loginProvider.loading
                        ? 'Sending...'
                        : 'Send Reset Link',
                    backgroundColor: const Color(0xff256724),
                    onPressed: () {
                      if (!loginProvider.loading) {
                        if (_formKey.currentState!.validate()) {
                          loginProvider.resetPassword(
                            context,
                            emailController.text.trim(),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
