import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: WhatsAppIconButton(phoneNumber: "962790119723")),
    );
  }
}

class WhatsAppIconButton extends StatelessWidget {
  final String phoneNumber;

  const WhatsAppIconButton({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.chat, color: Colors.green),
        onPressed: () => _openWhatsAppChat(context),
      ),
    );
  }

  void _openWhatsAppChat(BuildContext context) async {
    final cleanPhone = phoneNumber.replaceFirst(RegExp(r'^00'), '');
    final url = Uri.parse('https://wa.me/$cleanPhone');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      // إظهار SnackBar فقط إذا كان هناك Scaffold في السياق
      if (ScaffoldMessenger.maybeOf(context) != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تعذر فتح واتساب')));
      } else {
        debugPrint('No Scaffold found to show SnackBar.');
      }
    }
  }
}
