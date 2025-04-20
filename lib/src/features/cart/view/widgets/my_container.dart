import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,

    required this.image,
    required this.titel,
    required this.pries,
    required this.orderTime,
    required this.orderData,
    this.onPressed,
  });

  final String image;
  final String titel;
  final String pries;
  final String orderTime;
  final String orderData;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Image.network(
              image,
              width: screenWidth * 0.3,
              height: screenWidth * 0.28,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    titel,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 30 : 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "JOD  $pries",
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20 : 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        orderData,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        orderTime,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(Icons.delete, color: AppColors.error),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
