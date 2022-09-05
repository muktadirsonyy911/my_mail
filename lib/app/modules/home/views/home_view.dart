import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_mail/app/data/config/colors.dart';
import 'package:my_mail/app/data/global_widgets/global_widgets.dart';
import 'package:my_mail/app/modules/home/components/domain_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.defaultAppBar(title: 'Domains'),
      backgroundColor: scaffoldBackGroundColor,
      body: Obx(() {
        if (controller.domainDataLoaded.value == false) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (controller.domainDataLoaded.value == true && controller.domainList.isEmpty) {
          return Center(child: Text('No domain found'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: controller.domainList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return DomainWidget(domainModel: controller.domainList[index]);
                }),
          );
        }
      }),
    );
  }
}
