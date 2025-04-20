import 'dart:developer';

import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:bazaro_cs/src/core/utils/my_aleart_dialog.dart';
import 'package:bazaro_cs/src/features/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCrl extends GetxController {
  // لا تستخدم نفس الـ GlobalKey في أكثر من مكان
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(); // فورم الدخول
  GlobalKey<FormState> forgotpassword = GlobalKey<FormState>(); // فورم الدخول
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // فورم التسجيل

  ///----User Model
  UserModel userModel = UserModel(
    id: '',
    email: '',
    password: '',
    username: '',
    cpassword: '',
    isAdmin: false,
  );
  String userId = '';

  // المتغيرات الخاصة بعملية التحميل والظهور
  bool isLoading = false;
  bool isVisable = true;

  // تحديث القيم
  void setEmail(String newVal) {
    userModel.email = newVal;
    update();
  }

  void setUserId(String id) {
    userId = id;
    update();
  }

  void setName(String newVal) {
    userModel.username = newVal;
    update();
  }

  void setPassword(String newVal) {
    userModel.password = newVal;
    update();
  }

  void setCPassword(String newVal) {
    userModel.cpassword = newVal;
    update();
  }

  void setIsLoading(bool newVal) {
    isLoading = newVal;
    update();
  }

  void setIsVisable() {
    isVisable = !isVisable;
    update();
  }

  // مسح البيانات
  void clearData() {
    userModel = UserModel(
      id: '',
      email: '',
      password: '',
      username: '',
      cpassword: '',
      isAdmin: false,
    );
    update();
  }

  // دالة التسجيل
  Future<void> signUp(BuildContext context) async {
    FocusScope.of(context).unfocus();
    signupFormKey.currentState!.save();
    final bool isValid = signupFormKey.currentState!.validate();

    try {
      if (!userModel.email.isEmail) {
        myAleartDialog(context, text: 'Please enter a valid email');
      } else if (userModel.username.isEmpty) {
        myAleartDialog(context, text: 'Please enter your name');
      } else if (userModel.password.length <= 6 &&
          userModel.cpassword.length <= 6) {
        myAleartDialog(context, text: 'Password must be 6 characters at least');
      } else if (userModel.password != userModel.cpassword) {
        myAleartDialog(context, text: 'Passwords do not match');
      } else if (isValid) {
        setIsLoading(true);
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: userModel.email,
              password: userModel.password,
            )
            .then((UserCredential userCedential) {
              userModel.id = userCedential.user!.uid;

              setUserId(userCedential.user!.uid);

              DocumentReference ref = FirebaseFirestore.instance
                  .collection(AppStrings.users)
                  .doc(userCedential.user!.uid);

              ref.set(userModel.toMap()).then((val) {
                log('OK');
              });

              setIsLoading(false);
              Navigator.pop(context);
            });
      }
    } on FirebaseAuthException catch (e) {
      setIsLoading(false);
      log(e.toString());

      if (e.code == 'weak-password') {
        myAleartDialog(context, text: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        myAleartDialog(
          context,
          text: 'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        myAleartDialog(context, text: 'The email address is badly formatted.');
      } else {
        log(e.toString());
      }
    }
  }

  // دالة تسجيل الدخول
  Future<void> logIn(BuildContext context) async {
    FocusScope.of(context).unfocus();
    loginFormKey.currentState!.save();
    final bool isValid = loginFormKey.currentState!.validate();

    try {
      if (!userModel.email.isEmail) {
        myAleartDialog(context, text: 'Please enter a valid email');
      } else if (userModel.password.length <= 6) {
        myAleartDialog(
          context,
          text: 'Passwords must be 6 characters at least',
        );
      } else if (isValid) {
        setIsLoading(true);

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: userModel.email,
              password: userModel.password,
            )
            .then((UserCredential userCedential) async {
              // تعيين userId عند تسجيل الدخول
              setUserId(userCedential.user!.uid);
              log('تم تعيين userId: ${userCedential.user!.uid}');

              // يمكنك أيضًا جلب بيانات المستخدم من Firestore إذا كنت بحاجة إليها
              DocumentSnapshot userDoc =
                  await FirebaseFirestore.instance
                      .collection(AppStrings.users)
                      .doc(userCedential.user!.uid)
                      .get();

              if (userDoc.exists) {
                // تحديث بيانات المستخدم إذا لزم الأمر
                Map<String, dynamic> userData =
                    userDoc.data() as Map<String, dynamic>;
                userModel = UserModel.fromJson(userData);
                userModel.id = userCedential.user!.uid;
                update();
              }

              setIsLoading(false);
            });
      }
    } on FirebaseAuthException catch (e) {
      myAleartDialog(context, text: e.toString());
      setIsLoading(false);
      log(e.toString());

      if (e.code == 'weak-password') {
        myAleartDialog(context, text: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        myAleartDialog(
          context,
          text: 'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        myAleartDialog(context, text: 'The email address is badly formatted.');
      } else {
        log(e.toString());
      }
    }
  }

  // دالة إعادة تعيين كلمة المرور
  Future<bool> resetPassword(BuildContext context) async {
    FocusScope.of(context).unfocus();
    forgotpassword.currentState!.save();
    final bool isValid = forgotpassword.currentState!.validate();

    try {
      if (!userModel.email.isEmail) {
        myAleartDialog(context, text: 'Please enter a valid email');
        return false;
      } else if (isValid) {
        setIsLoading(true);

        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: userModel.email)
            .then((_) {
              setIsLoading(false);
              Navigator.pop(context);
            });
        return true;
      }
    } on FirebaseAuthException catch (e) {
      setIsLoading(false);
      myAleartDialog(context, text: e.message ?? 'An error occurred.');
      log(e.toString());
      return false;
    }
    return false;
  }
}
