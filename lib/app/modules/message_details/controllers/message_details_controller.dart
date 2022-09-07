import 'package:get/get.dart';
import 'package:my_mail/app/data/global_widgets/global_widgets.dart';
import 'package:my_mail/app/data/models/message_details_model.dart';
import 'package:my_mail/app/data/repository/my_mail_repository.dart';
import 'package:my_mail/app/modules/message/controllers/message_controller.dart';
import 'package:my_mail/app/routes/app_pages.dart';

class MessageDetailsController extends GetxController {
  Rx<MessageDetailsModel> messageDetails = MessageDetailsModel().obs;
  RxBool messageDataLoading = false.obs;
  RxBool isExpanded = false.obs;
  RxString messageId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    messageId.value = Get.arguments;
    messageDetailsGetMethod(messageId: messageId.value);
  }

  void messageDetailsGetMethod({required String messageId}) {
    try {
      messageDataLoading.value = true;
      MyMailRepository()
          .getMessageDetails(messageId: messageId)
          .then((MessageDetailsModel? responseData) {
        messageDetails.value = responseData!;
        messageDataLoading.value = false;
      });
    } catch (_) {}
  }

  void deleteMessageMethod({required String messageId}) {
    try {
      GlobalWidgets.customLoader();
      MyMailRepository().deleteMessage(messageId: messageId).then((bool value) {
        Get.back();
        if (value == true) {
          GlobalWidgets.showCustomSnackBar('This message has been deleted', isError: false);
          Get.find<MessageController>().messageGetMethod();
          Get.offNamed(Routes.message);
        } else {
          GlobalWidgets.showCustomSnackBar('This message has been deleted yet', isError: true);
        }
      });
    } catch (_) {}
  }
}
