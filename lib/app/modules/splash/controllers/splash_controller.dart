import 'dart:async';
import 'package:get/get.dart';
import 'package:my_mail/app/data/providers/storage_provider.dart';
import 'package:my_mail/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(
        const Duration(seconds: 4),
        () => Get.offNamed(
            StorageProvider.object.getUserToken() == null ? Routes.home : Routes.message));
    super.onInit();
  }
}
