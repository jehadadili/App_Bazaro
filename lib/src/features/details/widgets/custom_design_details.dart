import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomDesignDetails extends StatelessWidget {
  final String image;
  final String description;
  final String title;
  final String quintity;
  final void Function() onPressed;

  const CustomDesignDetails({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.quintity,
   required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 300,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(
                          color: AppColors.blackText,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 120),
                      Expanded(
                        child: Text(
                          "$quintity JOD", // Display total price
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                    ],
                  ),
                  SizedBox(height: 20),

                  SubmitButton(text: "Add Cart", onPressed: onPressed),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
