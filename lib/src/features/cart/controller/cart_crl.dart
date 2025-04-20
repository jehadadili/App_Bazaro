import 'dart:developer';

import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartCrl extends GetxController {
  List<ItemsModel> orederitem = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchOrders(); // Load orders when controller initializes
  }

  Future<List<ItemsModel>> fetchOrders() async {
    orederitem.clear();
    try {
      // Check if user is logged in
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // If no user is logged in, return empty list
        return orederitem;
      }

      QuerySnapshot<Map<String, dynamic>> getData =
          await FirebaseFirestore.instance
              .collection(AppStrings.orders)
              .where('user_id', isEqualTo: currentUser.uid)
              .get();

      for (var doc in getData.docs) {
        orederitem.add(ItemsModel.fromQuery(doc));
      }
      update(); // Notify listeners that data has changed
    } catch (e) {
      log("Error fetching orders: $e");
    }

    return orederitem;
  }

  Future<void> deleteItem(String orderId) async {
    try {
      isLoading = true;
      update();

      // ابحث عن الدوكيومنت اللي يحتوي على هذا الـ id
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(AppStrings.orders)
              .where('id', isEqualTo: orderId)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        // احذف من الذاكرة بعد حذف من Firestore
        orederitem.removeWhere((order) => order.id == orderId);

        // رسالة نجاح
        Get.snackbar(
          'نجاح',
          'تم حذف المنتج من السلة',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        // لو ما لقى المنتج
        Get.snackbar(
          'خطأ',
          'لم يتم العثور على المنتج لحذفه',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log("Error deleting order: $e");
      Get.snackbar(
        'خطأ',
        'فشل في حذف المنتج: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // Add a method to clear cart if user logs out
  void clearCart() {
    orederitem.clear();
    update();
  }
}
