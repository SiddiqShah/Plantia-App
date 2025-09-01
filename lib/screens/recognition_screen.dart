// ignore_for_file: use_build_context_synchronously

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:plant_disease_detector/provider/recognition_provider.dart';

class RecognitionScreen extends StatelessWidget {
  const RecognitionScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Provider.of<RecognitionProvider>(context, listen: false)
          .setImage(File(pickedFile.path));
    }
  }

  Future<void> _saveToFirebase(BuildContext context) async {
    final provider = Provider.of<RecognitionProvider>(context, listen: false);
    final image = provider.image;
    final title = provider.title;
    final subtitle = provider.subtitle;

    if (title.isNotEmpty && subtitle.isNotEmpty && image != null) {
      provider.setLoading(true);
      try {
        // Upload image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('diagnosis_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await storageRef.putFile(image);
        final imageUrl = await storageRef.getDownloadURL();

        // Save data to Firestore
        await FirebaseFirestore.instance.collection("recent_diagnose").add({
          "title": title,
          "subtitle": subtitle,
          "timestamp": DateTime.now(),
          "image": imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Diagnosis saved successfully!")),
        );
        provider.clearAll();
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving diagnosis: $e")),
        );
      } finally {
        provider.setLoading(false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and capture image")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecognitionProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 225, 241, 216),
          appBar: AppBar(
            title: Center(child: const Text("Recognition", style: TextStyle(fontWeight: FontWeight.bold),)),
            backgroundColor: const Color.fromARGB(255, 225, 241, 216),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Image capture section
                GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: provider.image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 80,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Tap to capture plant image",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              provider.image!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // Camera button
                GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff256724),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Capture Image",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Input fields
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) =>
                            provider.setTitle(value),
                        decoration: InputDecoration(
                          labelText: "Disease Name",
                          hintText: "e.g., Powder Mildew",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff256724)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        onChanged: (value) =>
                            provider.setSubtitle(value),
                        decoration: InputDecoration(
                          labelText: "Plant/Fruit Name",
                          hintText: "e.g., Spinach",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff256724)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Save button
                GestureDetector(
                  onTap: provider.isLoading
                      ? null
                      : () => _saveToFirebase(context),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: provider.isLoading
                          ? Colors.grey
                          : const Color(0xff256724),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: provider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Save Diagnosis",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Cancel button
                GestureDetector(
                  onTap: () {
                    provider.clearAll();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}