import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:bazaro_cs/src/features/requst_admin/view/widgets/form_section.dart';
import 'package:bazaro_cs/src/features/requst_admin/view/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/request_admin_controller.dart';

class RequestAdminView extends StatefulWidget {
  const RequestAdminView({super.key});

  @override
  State<RequestAdminView> createState() => _RequestAdminViewState();
}

class _RequestAdminViewState extends State<RequestAdminView> {
  final RequestAdminController controller = Get.put(RequestAdminController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await controller.requestAdmin(
        userName: nameController.text.trim(),
        userEmail: emailController.text.trim(),
        userPhone: phoneController.text.trim(),
      );

      SnackbarHelper.showSuccessSnackbar(
        'تم الإرسال بنجاح',
        'تم إرسال طلبك وسيتم مراجعته',
      );
      Navigator.pop(context);
    } else {
      SnackbarHelper.showErrorSnackbar('خطأ', 'يرجى تعبئة جميع الحقول');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00091e),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
            vertical: MediaQuery.of(context).size.height * 0.2,
          ),
          child: Form(
            key: _formKey, // لا يتم تكرار المفتاح
            child: Column(
              children: [
                FormSection(
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SubmitButton(
                    onPressed: _submit,
                    text: 'طلب حساب أدمن',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
