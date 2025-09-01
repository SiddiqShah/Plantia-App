import 'package:flutter/material.dart';
import 'package:plant_disease_detector/provider/password_visibility_provider.dart';
import 'package:plant_disease_detector/provider/signup_provider.dart';
import 'package:plant_disease_detector/screens/login_screen.dart';
import 'package:plant_disease_detector/widgets/round_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xff256724),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Create your new account",
              style: TextStyle(color: Colors.grey[700], fontSize: 20),
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Color(0xff256724),
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xff256724)),
                        hintText: "Full Name",
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Color(0xff256724),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xff256724)),
                        hintText: "abc123@gmail.com",
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
                    const SizedBox(height: 16),
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, provider, child) {
                        return TextFormField(
                          controller: passwordController,
                          obscureText: provider.isObscured,
                          cursorColor: Color(0xff256724),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                color: Color(0xff256724)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                provider.isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff256724),
                              ),
                              onPressed: provider.toggleVisibility,
                            ),
                            hintText: "Password",
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
                              return "Please enter password";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Email/Password Sign Up Button
            RoundButton(
              title: signUpProvider.loading ? 'Signing up...' : 'Sign Up',
              backgroundColor: const Color(0xff256724),
              onPressed: () {
                if (!signUpProvider.loading) {
                  if (_formKey.currentState!.validate()) {
                    signUpProvider.signUpWithEmail(
                      context,
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  }
                }
              },
            ),
          const SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Expanded(child: Divider(thickness: 2, color: Colors.black)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Or Continue with",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                  ),
                  const Expanded(child: Divider(thickness: 2, color: Colors.black)),
                ],
              ),
            ),
          const SizedBox(height: 20),

         Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
            GoogleRoundButton(
              image: "assets/images/fb.jpeg",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Facebook login not implemented yet')),
                );
              },
           ),
             GoogleRoundButton(
              image: "assets/images/google.png",
              onPressed: () {
                if (!signUpProvider.loading) {
                  signUpProvider.signInWithGoogleLoginOnly(context);
                }
              },
            ),
              GoogleRoundButton(
              image: "assets/images/apple.png",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Apple login not implemented yet')),
                );
              },
             ),
          ],
         ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // 👈 removes spacing
                    minimumSize: Size(0, 0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(
                      color: Color(0xff256724),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}