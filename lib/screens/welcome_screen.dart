// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:plant_disease_detector/screens/login_screen.dart';
import 'package:plant_disease_detector/screens/sign_up_screen.dart';
import 'package:plant_disease_detector/widgets/round_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/plant.jpeg", 
            fit: BoxFit.cover,
          ),

          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Heading text
                const Text(
                  "The best\napp for\nyour plants",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),

                const Spacer(flex: 3),

                // Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: RoundButton(title: "Sign in", backgroundColor: const Color.fromARGB(100, 255, 255, 255), onPressed: () { 
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                       },)
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: RoundButton(title: "Create an account",  onPressed: () { 
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                       },)
                    ),
                    
                  ],
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
