import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:bazaro_cs/src/features/cart/controller/cart_crl.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBodyDesign extends StatelessWidget {
  const CustomBodyDesign({super.key});

  @override
  Widget build(BuildContext context) {
    // Use GetBuilder to access the cart controller and rebuild when it changes
    return GetBuilder<CartCrl>(
      builder: (controller) {
        // Calculate the subtotal
        double subtotal = 0;
        for (ItemsModel item in controller.orederitem) {
          // Convert quintity to double, assuming it contains a number as string
          try {
            subtotal += double.parse(item.quintity);
          } catch (e) {
            // Handle the case where quintity isn't a valid number
            print("Error parsing quintity: ${item.quintity}");
          }
        }

        // Get the number of items in cart
        int itemCount = controller.orederitem.length;

        // Calculate the total (just the subtotal for now)
        double total = subtotal;

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
                  "JOD ${subtotal.toStringAsFixed(2)}",
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
                  "$itemCount",
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
                  "JOD ${total.toStringAsFixed(2)}",
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

             
              },
            ),
          ],
        );
      },
    );
  }
}