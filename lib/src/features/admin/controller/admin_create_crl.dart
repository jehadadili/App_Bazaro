import 'dart:developer';
import 'dart:io';
import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_crl.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminCreateCrl extends GetxController {
  ItemsModel itemsModel = ItemsModel(
    id: '',
    title: '',
    description: '',
    quintity: '',
    image: '',
    userId: '',
    orderTime: '',
    orderData: '',
    type: '',
    sellerName: '',
    whatsappNumber: '',
  );

  void setTitle(String newVal) {
    itemsModel.title = newVal;
    update();
  }

  void setDescription(String newVal) {
    itemsModel.description = newVal;
    update();
  }

  void setQuintity(String newVal) {
    itemsModel.quintity = newVal;
    update();
  }

  void setSellerName(String newVal) {
    itemsModel.sellerName = newVal;
    update();
  }

  void setWhatsappNumber(String newVal) {
    itemsModel.whatsappNumber = newVal;
    update();
  }

  File itemImage = File('');

  // دالة لاختيار الصورة
  Future<File> selectImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      itemImage = File(image.path);
    }

    update();
    return itemImage;
  }

  bool isLoading = false;

  // دالة لتحديد حالة التحميل
  void setIsLoading(bool newVal) {
    isLoading = newVal;
    update();
  }

  // دالة لرفع الصورة إلى Supabase Storage
  Future<String> uploadImage() async {
    try {
      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // رفع الصورة إلى Supabase Storage
      await Supabase.instance.client.storage
          .from('market')
          .upload(fileName, itemImage);

      // الحصول على رابط الصورة
      String imageUrl = Supabase.instance.client.storage
          .from('market')
          .getPublicUrl(fileName);

      return imageUrl; // إرجاع رابط الصورة
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  // دالة لإضافة العنصر إلى Firestore
  Future addItem(context) async {
    setIsLoading(true);

    try {
      // احصل على userId من AuthCrl
      String currentUserId = Get.find<AuthCrl>().userId;

      // التحقق من userId
      if (currentUserId.isEmpty) {
        log('userId فارغ، التحقق من المستخدم الحالي');
        // محاولة الحصول على userId من المستخدم الحالي مباشرة
        var currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          currentUserId = currentUser.uid;
          Get.find<AuthCrl>().setUserId(currentUserId);
          log('تم الحصول على userId من المستخدم الحالي: $currentUserId');
        } else {
          throw Exception('المستخدم غير مسجل الدخول');
        }
      }

      log('userId: $currentUserId');
      log('AppStrings.users: ${AppStrings.users}');
      log('AppStrings.market: ${AppStrings.market}');

      // تعيين userId للمنتج
      itemsModel.userId = currentUserId;

      // رفع الصورة والحصول على الرابط
      itemsModel.image = await uploadImage();

      // استخدم نفس مسار التجميع كما في AdminCrl
      DocumentReference ref =
          FirebaseFirestore.instance
              .collection(AppStrings.users)
              .doc(currentUserId)
              .collection(AppStrings.market)
              .doc();

      itemsModel.id = ref.id;

      // حفظ بيانات العنصر في Firestore
      await ref.set(itemsModel.toMap());

      // إضافة العنصر إلى قائمة العناصر في AdminCrl
      Get.find<AdminCrl>().itemsList.add(itemsModel);
      Get.find<AdminCrl>().update();

      // مسح البيانات بعد الإضافة
      clearData();

      // العودة إلى الصفحة السابقة
      Navigator.pop(context);
    } catch (e) {
      log('Error adding item: $e');
      // عرض رسالة خطأ للمستخدم
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إضافة المنتج: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setIsLoading(false);
    }
  }

  // دالة لمسح البيانات بعد إضافة العنصر
  void clearData() {
    itemsModel = ItemsModel(
      id: '',
      title: '',
      description: '',
      quintity: '',
      image: '',
      orderTime: '',
      userId: '',
      orderData: '',
      type: '',
      sellerName: '',
      whatsappNumber: '',
    );
    itemImage = File('');
    setIsLoading(false);
    update();
  }
}
