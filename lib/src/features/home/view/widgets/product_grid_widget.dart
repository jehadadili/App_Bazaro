import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:bazaro_cs/src/features/details/view/details_view.dart';
import 'package:bazaro_cs/src/features/home/controller/home_crl.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGridWidget extends StatelessWidget {
  final HomeCrl controller;
  final String searchQuery; // Add searchQuery as a parameter

  const ProductGridWidget({
    super.key,
    required this.controller,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<ItemsModel>>(
        stream: controller.itemsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final items = snapshot.data ?? [];

          // Filter items based on the search query
          final filteredItems =
              searchQuery.isEmpty
                  ? items
                  : items
                      .where(
                        (item) => item.title.toLowerCase().contains(
                          searchQuery.toLowerCase(),
                        ),
                      )
                      .toList();

          if (filteredItems.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد منتجات مطابقة',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .48,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: filteredItems.length, // Use filteredItems.length
            itemBuilder: (context, index) {
              final item = filteredItems[index]; // ✅ هنا عرّفت item

              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailsView(itemsModel: item));
                },
                child: ProductCard(item: filteredItems[index]),
              );
            },
          );
        },
      ),
    );
  }
}
