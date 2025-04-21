import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:bazaro_cs/src/features/cart/controller/cart_crl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBodyDesign extends StatelessWidget {
  const CustomBodyDesign({super.key});

  @override
  Widget build(BuildContext context) {
    // Use GetBuilder to access the cart controller and rebuild when it changes
    return GetBuilder<CartCrl>(
      builder: (controller) {
        // Get the total quantity of all items
        int totalQuantity = 0;
        for (var item in controller.orederitem) {
          totalQuantity += item.quantity;
        }

        // Get the total price
        double totalPrice = controller.getTotalPrice();

        return Column(
          children: [
            Row(
              children: [
                const Text(
                  "المجموع الفرعي",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "JOD ${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "عدد المنتجات",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "${controller.orederitem.length}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "إجمالي الكمية",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "$totalQuantity",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2, height: 37, color: Color(0xffC7C7C7)),
            Row(
              children: [
                const Text(
                  "المجموع الكلي",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "JOD ${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SubmitButton(
              text: "إتمام الدفع",
              onPressed: () {
                if (controller.orederitem.isEmpty) {
                  Get.snackbar(
                    'سلة فارغة',
                    'سلتك فارغة. أضف منتجات قبل إتمام الدفع.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                // Handle checkout process
                Get.snackbar(
                  'تم إتمام الطلب',
                  'سيتم التواصل معك قريباً',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
            ),
          ],
        );
      },
    );
  }
}