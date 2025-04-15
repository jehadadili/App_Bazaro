import 'dart:developer';

import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../admin/model/item_model.dart';

class CartCrl extends GetxController {
  List<ItemsModel> orederitem = [];

  Future<List<ItemsModel>> fetchOrders() async {
    orederitem.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> getData = await FirebaseFirestore
          .instance
          .collection(AppStrings.orders)
          .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      for (var doc in getData.docs) {
        orederitem.add(ItemsModel.fromQuery(doc));
      }
    } catch (e) {
      log(e.toString());
    }

    return orederitem;
  }

  Future<void> deleteItem(String orderId) async {
    orederitem.removeWhere((order) => order.id == orderId);

    await FirebaseFirestore.instance
        .collection(AppStrings.orders)
        .doc(orderId)
        .delete();

    update();
  }
}
