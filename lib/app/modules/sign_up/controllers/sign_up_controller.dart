import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_mail/app/data/global_widgets/global_widgets.dart';
import 'package:my_mail/app/data/models/sign_up_model.dart';
import 'package:my_mail/app/data/repository/my_mail_repository.dart';
import 'package:my_mail/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  RxBool obscureText = true.obs;
  IconData icon = Icons.visibility;

  void signUpMethod(Map<String, String> signUpData) {
    try {
      GlobalWidgets.customLoader();
      MyMailRepository().signUp(signUpData: signUpData).then((SignUpModel? responseData) {
        Get.back();
        if (responseData?.id != null) {
          GlobalWidgets.showCustomSnackBar('Registration has successfully been completed',
              isError: false, duration: 3);
          Get.toNamed(Routes.login);
        } else {
          GlobalWidgets.showCustomSnackBar('${responseData?.detail}', isError: true, duration: 3);
        }
      });
    } catch (e) {
      GlobalWidgets.showCustomSnackBar('Internal server error', isError: true);
    }
  }
}
