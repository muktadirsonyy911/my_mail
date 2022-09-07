import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_mail/app/data/config/colors.dart';
import 'package:my_mail/app/data/models/domain_model.dart';
import 'package:my_mail/app/routes/app_pages.dart';

class DomainWidget extends StatelessWidget {
  DomainModel domainModel;
  DomainWidget({Key? key, required this.domainModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.login);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  domainModel.domain ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: backGroundColor),
                ),
                Icon(Icons.arrow_forward_ios, size: 20, color: backGroundColor)
              ],
            )),
      ),
    );
  }
}
