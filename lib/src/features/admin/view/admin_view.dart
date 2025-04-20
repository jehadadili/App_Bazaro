import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_crl.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/admin_add_item_view.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/custom_design.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/custom_my_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final adminCrl = Get.find<AdminCrl>();

    return FutureBuilder(
      future:
          adminCrl.fetchUserItems(), // بتم تحميل البيانات أول ما تفتح الصفحة
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return GetBuilder<AdminCrl>(
          builder: (admincrl) {
            return Scaffold(
              backgroundColor: const Color(0xff00091e),
              body: Column(
                children: [
                  const SizedBox(height: 60),
                  const CustomDesign(),
                  Expanded(
                    child:
                        admincrl.itemsList.isEmpty
                            ? const Center(
                              child: Text(
                                "لا يوجد عناصر حالياً",
                                style: TextStyle(color: AppColors.white),
                              ),
                            )
                            : ListView.builder(
                              itemCount: admincrl.itemsList.length,
                              itemBuilder: (context, index) {
                                final item = admincrl.itemsList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomMyContainer(
                                    image: item.image,
                                    titel: item.title,
                                    description: item.description,
                                    quintity: item.quintity,
                                    onPressedelet:
                                        () => admincrl.deleteItem(item.id),
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Get.to(() => const AdminAddItemView());
                  // بعد الرجوع من صفحة الإضافة، أعد تحميل البيانات
                  await adminCrl.fetchUserItems();
                },
                backgroundColor: AppColors.error,
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            );
          },
        );
      },
    );
  }
}
