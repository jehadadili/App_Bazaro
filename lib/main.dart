import 'package:bazaro_cs/firebase_options.dart';
import 'package:bazaro_cs/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: "https://qhxvmskyhsxngxbngfek.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoeHZtc2t5aHN4bmd4Ym5nZmVrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ2NDkyODIsImV4cCI6MjA2MDIyNTI4Mn0._zswN7XnW1oyrL9NBG63hOTbxwxTmyUTn3hZ9qhi6r8",
  );
  runApp(const MyApp());
}
