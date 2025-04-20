import 'package:bazaro_cs/src/features/home/controller/home_crl.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/greeting_header.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/product_grid_widget.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCrl homeCrl = Get.put(HomeCrl());
  String searchQuery = ''; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00091e),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const GreetingHeader(),
            SearchWidget(
              onSearch: (query) {
                setState(() {
                  searchQuery =
                      query; 
                });
              },
            ),
            ProductGridWidget(
              controller: homeCrl,
              searchQuery: searchQuery,
            ), 
          ],
        ),
      ),
    );
  }
}
