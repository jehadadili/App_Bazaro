import 'package:flutter/material.dart';
import 'package:bazaro_cs/src/core/widgets/my_text_field.dart';
import 'package:bazaro_cs/src/core/validator/validater.dart';

class FormSection extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  const FormSection({
    super.key,
    this.nameController,
    this.emailController,
    this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: nameController,
          hintText: 'الاسم الكامل',
          keyboardType: TextInputType.name,
          validator: (value) => MyValidator.nameValidator(value),
        ),
        const SizedBox(height: 20),
        MyTextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: 'البريد الإلكتروني',
          validator: (value) => MyValidator.emailValidator(value),
        ),
        const SizedBox(height: 20),
        MyTextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          hintText: 'رقم الهاتف',
          validator: (value) => MyValidator.phoneValidator(value),
        ),
      ],
    );
  }
}
