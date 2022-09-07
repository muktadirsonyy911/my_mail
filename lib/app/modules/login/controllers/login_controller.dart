import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_mail/app/data/global_widgets/global_widgets.dart';
import 'package:my_mail/app/data/models/login_model.dart';
import 'package:my_mail/app/data/models/user_model.dart';
import 'package:my_mail/app/data/providers/storage_provider.dart';
import 'package:my_mail/app/data/repository/my_mail_repository.dart';
import 'package:my_mail/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool obscureText = true.obs;
  IconData icon = Icons.visibility;

  void loginPostMethod({required Map<String, String> loginData}) {
    try {
      GlobalWidgets.customLoader();
      MyMailRepository().login(loginData: loginData).then((LoginModel? responseData) {
        Get.back();
        if (responseData?.id != null) {
          Map<String, dynamic> userData = JwtDecoder.decode(responseData?.token ?? '');
          saveDataToDb(userToken: responseData?.token ?? '', userData: userData);
        } else {
          GlobalWidgets.showCustomSnackBar('${responseData?.message}', isError: true, duration: 3);
        }
      });
    } catch (e) {
      GlobalWidgets.showCustomSnackBar('Internal server error', isError: true);
    }
  }

  void saveDataToDb({required String userToken, required Map<String, dynamic> userData}) async {
    String token = userToken.replaceAll('"', '');
    UserModel user = UserModel.fromJson(userData);
    await StorageProvider.object.setUserToken(token);
    await StorageProvider.object.setUserData(user);
    Get.toNamed(Routes.message);
    GlobalWidgets.showCustomSnackBar('You are successfully logged in', isError: false, duration: 3);
  }
}
