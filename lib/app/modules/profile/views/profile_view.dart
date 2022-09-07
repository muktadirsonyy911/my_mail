import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_mail/app/data/config/colors.dart';
import 'package:my_mail/app/data/global_widgets/bottom_nav_bar_widget.dart';
import 'package:my_mail/app/data/global_widgets/global_widgets.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.defaultAppBar(title: 'Message'),
      backgroundColor: scaffoldBackGroundColor,
      body: Center(
        child: Text(
          'ProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 1),
    );
  }
}
