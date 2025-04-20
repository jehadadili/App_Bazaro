import 'package:bazaro_cs/src/features/requst_admin/controller/request_admin_controller.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_create_crl.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_crl.dart';
import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:bazaro_cs/src/features/cart/controller/cart_crl.dart';
import 'package:bazaro_cs/src/features/home/controller/home_crl.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCrl());

    Get.put(AdminCreateCrl());
    Get.put(RequestAdminController());
    Get.put(AdminCrl());
    Get.put(HomeCrl());
    Get.put(CartCrl());
  }
}
