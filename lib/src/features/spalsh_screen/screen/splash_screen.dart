import 'package:bazaro_cs/src/features/pages_start/init_start_view.dart';
import 'package:bazaro_cs/src/features/spalsh_screen/widgets/splash_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getAdminDeviceToken(); // نادينا الدالة هنا
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (mounted) {
        Get.to(InitStartView());
      }
    });
  }

  Future<void> _getAdminDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print('توكن جهاز الأدمن: $token');
      } else {
        print('فشل جلب التوكن!');
      }
    } catch (e) {
      print('خطأ أثناء جلب التوكن: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreenWidgets();
  }
}
