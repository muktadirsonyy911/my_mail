import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_mail/app/data/config/colors.dart';

class GlobalWidgets {
  static AppBar defaultAppBar({required String title}) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: primaryColor,
    );
  }

  static ClipRRect buttonWidget(
      {required String? text, VoidCallback? press, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: color ?? primaryColor),
        child: TextButton(
          onPressed: press,
          child: Text(
            text ?? '',
            style: const TextStyle(
                color: backGroundColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  static void showCustomSnackBar(String message,
      {@required bool? isError, int? duration}) {
    Get.showSnackbar(GetSnackBar(
      title: isError == true ? 'Warning' : 'Success',
      backgroundColor: isError == true ? Colors.red : Colors.green,
      message: message,
      icon: Icon(
        isError == true
            ? CupertinoIcons.clear_circled
            : CupertinoIcons.checkmark_alt_circle,
        color: Colors.white,
      ),
      maxWidth: double.infinity,
      duration: Duration(seconds: duration ?? 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10.0),
      borderRadius: 10.0,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.horizontal,
    ));
  }

  static Widget customLoadingWidget() {
    return
      SpinKitThreeBounce(
        color: Get.theme.primaryColor,
        size: 40,
      );
  }

  static Future customLoader() {
    return Get.dialog(
      const SpinKitThreeBounce(
        color: backGroundColor,
        size: 40,
      ),
    );
  }
}
