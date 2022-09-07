import 'package:get/get.dart';
import 'package:my_mail/app/data/models/message_model.dart';
import 'package:my_mail/app/data/repository/my_mail_repository.dart';

class MessageController extends GetxController {
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  RxList<MessageModel> searchMessageList = <MessageModel>[].obs;
  RxBool messageDataLoaded = false.obs;

  @override
  void onInit() {
    messageGetMethod();
    super.onInit();
  }

  void messageGetMethod() {
    try {
      MyMailRepository().getMessage().then((List<MessageModel> responseData) {
        messageList.value = responseData;
        messageDataLoaded.value = true;
      });
    } catch (_) {}
  }

  List<MessageModel> messageSearchList({required String searchQuery}) {
    if (searchQuery.isEmpty) {
      searchMessageList.clear();
      messageGetMethod();
      return messageList;
    } else {
      searchMessageList.value = messageList
          .where((element) => element.subject!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      return searchMessageList;
    }
  }
}
