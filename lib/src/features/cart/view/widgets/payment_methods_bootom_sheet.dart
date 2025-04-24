import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:flutter/material.dart';

import '../../../payment_details/view/payment_details_view.dart';
import '../../../payment_details/view/widgets/payment_method_list_view.dart';

class PaymentMethodsBootomSheet extends StatelessWidget {
  const PaymentMethodsBootomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const PymentMethodListView(),
          const SizedBox(height: 32),
          SubmitButton(
            text: "continuer",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PaymentDetailsView();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
