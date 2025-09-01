import 'package:flutter/material.dart';
import 'package:plant_disease_detector/provider/login_provider.dart';
import 'package:plant_disease_detector/provider/password_visibility_provider.dart';
import 'package:plant_disease_detector/screens/forgot_pass_screen.dart';
import 'package:plant_disease_detector/screens/sign_up_screen.dart';
import 'package:plant_disease_detector/widgets/round_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -------- TOP CURVED IMAGE ----------
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
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xff256724),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Login to your account ?",
              style: TextStyle(color: Colors.grey[700], fontSize: 20),
            ),
            const SizedBox(height: 30),

            // -------- TEXT FIELDS ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      controller: emailController,
                      cursorColor: const Color(0xff256724),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xff256724)),
                        hintText: "Email",
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

                    // Password with Provider
                    Consumer<PasswordVisibilityProvider>(
                      builder: (context, provider, child) {
                        return TextFormField(
                          controller: passwordController,
                          obscureText: provider.isObscured,
                          cursorColor: const Color(0xff256724),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                color: Color(0xff256724)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                provider.isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xff256724),
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
                            return null;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassScreen()),
                      );
                    },
                    child: const Text("Forgot Password?", style: TextStyle(color: Color(0xff256724)),),
                  ),
              ),
              ),

            const SizedBox(height: 40),

            // Login Button using Provider
            RoundButton(
              title: loginProvider.loading ? 'Logging in...' : 'Login',
              backgroundColor: const Color(0xff256724),
              onPressed: () {
                if (!loginProvider.loading) {
                  if (_formKey.currentState!.validate()) {
                    loginProvider.login(
                      context,
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 10),
            // -------- CONTINUE WITH GOOGLE BUTTON --------
            RoundButton(
              title: loginProvider.loading ? 'Loading...' : 'Continue with Google',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                if (!loginProvider.loading) {
                  loginProvider.signInWithGoogleForLogin(context);
                }
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Color(0xff256724),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}