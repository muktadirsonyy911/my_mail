import 'package:get/get.dart';
import 'package:my_mail/app/data/models/domain_model.dart';
import 'package:my_mail/app/data/repository/my_mail_repository.dart';

class HomeController extends GetxController {
  RxList<DomainModel> domainList = <DomainModel>[].obs;
  RxBool domainDataLoaded = false.obs;

  @override
  void onInit() {
    domainGetMethod();
    super.onInit();
  }

  void domainGetMethod() {
    try {
      MyMailRepository().getDomains().then((List<DomainModel> responseData) {
        domainList.value = responseData;
        domainDataLoaded.value = true;
      });
    } catch (_) {}
  }
}
