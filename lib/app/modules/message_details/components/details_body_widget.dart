import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_mail/app/data/config/colors.dart';
import 'package:my_mail/app/data/models/message_details_model.dart';
import 'package:my_mail/app/modules/message_details/controllers/message_details_controller.dart';

class DetailsBodyWidget extends StatelessWidget {
  MessageDetailsModel messageDetailsModel;
  DetailsBodyWidget({Key? key, required this.messageDetailsModel}) : super(key: key);
  final MessageDetailsController controller = Get.find<MessageDetailsController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    print('Id: ${messageDetailsModel.id}');

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(messageDetailsModel.subject ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: width * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(messageDetailsModel.from?.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(DateFormat.jm().format(
                    DateTime.parse(messageDetailsModel.retentionDate ?? '').toLocal()))
              ],
            ),
            Row(
              children: [
                Text('to me'),
                if (messageDetailsModel.cc!.isNotEmpty)
                  Text(messageDetailsModel.cc!.first.name ?? ''),
                Obx(() {
                  return controller.isExpanded.value == false
                      ? IconButton(
                      onPressed: () {
                        controller.isExpanded.value = !controller.isExpanded.value;
                      },
                      icon: Icon(Icons.arrow_drop_down_outlined))
                      : IconButton(
                      onPressed: () {
                        controller.isExpanded.value = !controller.isExpanded.value;
                      },
                      icon: Icon(Icons.arrow_drop_up));
                })
              ],
            ),
            SizedBox(height: width * 0.02),
            Obx(() => controller.isExpanded.value == true
                ? Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(bottom: width * 0.03),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('From'),
                            SizedBox(width: width * 0.04),
                            Column(
                              children: [
                                Text(messageDetailsModel.from?.name ?? ''),
                                Text(messageDetailsModel.from?.address ?? ''),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: width * 0.03),
                        Row(
                          children: [
                            Text('To'),
                            SizedBox(width: width * 0.08),
                            Text(messageDetailsModel.to?.first.address ?? '')
                          ],
                        ),
                        SizedBox(height: width * 0.03),
                        if (messageDetailsModel.cc!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(bottom: width * 0.03),
                            child: Row(
                              children: [
                                Text('cc'),
                                SizedBox(width: width * 0.08),
                                Text(messageDetailsModel.cc?.first.address ?? '')
                              ],
                            ),
                          ),
                        Row(
                          children: [
                            Text('Date'),
                            SizedBox(width: width * 0.04),
                            Text(
                                '${DateFormat.yMMMMd().format(DateTime.parse(messageDetailsModel.createdAt ?? '').toLocal())}, ${DateFormat.jm().format(DateTime.parse(messageDetailsModel.createdAt ?? '').toLocal())}')
                          ],
                        ),
                      ],
                    ),
                  )
                : Wrap()),
            Text(messageDetailsModel.text ?? ''),
            if (messageDetailsModel.hasAttachments == true)
              Padding(
                padding: EdgeInsets.only(top: width*0.03),
                child: SizedBox(
                  height: width * 0.2,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.black12,
                        height: width * 0.2,
                        width: width * 0.3,
                        child: Center(
                            child: Text(
                          '${messageDetailsModel.attachments![index].contentType}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      );
                    },
                    itemCount: messageDetailsModel.attachments?.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
