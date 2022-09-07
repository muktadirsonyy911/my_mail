import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_mail/app/data/providers/storage_provider.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init(DbStrings.dbName);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Muktadir'
      ),
      themeMode: ThemeMode.light, // Change it as you want
      debugShowCheckedModeBanner: false,
      title: "My Mail",
      defaultTransition: Transition.cupertino,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
