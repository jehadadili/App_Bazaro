import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDesign extends StatefulWidget {
  const CustomDesign({super.key});

  @override
  State<CustomDesign> createState() => _CustomDesignState();
}

class _CustomDesignState extends State<CustomDesign> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUsernameFromFirestore();
  }

  Future<void> getUsernameFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (doc.exists) {
        setState(() {
          username = doc.data()?['username'] ?? 'Admin';
        });
      } else {
        setState(() {
          username = 'Admin';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Use LayoutBuilder for responsive layout based on screen width
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hi ${username ?? ''}!",
                style: TextStyle(
                  color: AppColors.background,
                  fontSize:
                      screenWidth > 600
                          ? 30
                          : 25, // Adjust font size based on screen width
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout, color: AppColors.background),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ), // Adjust vertical spacing based on screen height
          Text(
            "Welcome back to your panel.",
            style: TextStyle(
              color: AppColors.background,
              fontSize:
                  screenWidth > 600
                      ? 25
                      : 20, // Adjust font size for larger screens
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ), // Adjust vertical spacing for responsiveness
          const Center(
            child: Text(
              "List Item",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
