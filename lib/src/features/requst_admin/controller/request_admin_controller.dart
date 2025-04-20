import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart' show rootBundle;

class RequestAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ضع هنا مسار ملف الخدمة (الملف JSON اللي حملته من فايربيس)
  final String serviceAccountPath = 'assets/service_account.json';

  // ID الخاص بـ مشروعك من فايربيس
  final String projectId = 'app-bazaro-cs';

  // توكن جهاز الأدمن
  final String adminDeviceToken =
      'e-tiF7N5QwOHzZdWy0YLoF:APA91bETAehxx3_al_eNcdr-DSrWuqW9DBk48Eib_U5az6mxBRFiAae6t7rw6B4dX8LoeqypPr1DmP2YI2el86s-pHpKZvDlHKmYxf4sperDXyXewSTawzQ';

  Future<void> requestAdmin({
    required String userName,
    required String userEmail,
    required String userPhone,
  }) async {
    try {
      // أولا: حفظ الطلب في فايرستور
      await _firestore.collection('admin_requests').add({
        'name': userName,
        'email': userEmail,
        'phone': userPhone,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // ثانيا: إرسال الإشعار
      await sendPushNotification(userName);
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء إرسال الطلب');
      print(e);
    }
  }

  Future<void> sendPushNotification(String requesterName) async {
    try {
      final accountCredentials = ServiceAccountCredentials.fromJson(
        json.decode(await rootBundle.loadString(serviceAccountPath)),
      );

      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final authClient = await clientViaServiceAccount(
        accountCredentials,
        scopes,
      );

      final String url =
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

      final Map<String, dynamic> message = {
        "message": {
          "token": adminDeviceToken,
          "notification": {
            "title": "طلب ترقية حساب",
            "body": "$requesterName يرغب بأن يصبح أدمن! تحقق من الطلب الآن.",
          },
          "android": {"priority": "high"},
          "apns": {
            "payload": {
              "aps": {"sound": "default"},
            },
          },
        },
      };

      final response = await authClient.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('تم إرسال الإشعار بنجاح');
      } else {
        print('فشل إرسال الإشعار: ${response.body}');
      }
    } catch (e) {
      print('خطأ أثناء إرسال الإشعار: $e');
    }
  }
}
