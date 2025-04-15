import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Text(
            "Quicklens",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              fontFamily: 'serif',
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Login",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
