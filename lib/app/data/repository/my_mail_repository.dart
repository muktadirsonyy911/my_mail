import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_mail/app/data/models/domain_model.dart';
import 'package:my_mail/app/data/models/login_model.dart';
import 'package:my_mail/app/data/models/message_details_model.dart';
import 'package:my_mail/app/data/models/message_model.dart';
import 'package:my_mail/app/data/models/sign_up_model.dart';
import 'package:my_mail/app/data/providers/api_provider.dart';
import 'package:my_mail/app/data/providers/storage_provider.dart';

class MyMailRepository {
  Future<List<DomainModel>> getDomains() async {
    try {
      List<DomainModel> domainList = <DomainModel>[];
      Uri url = Uri.parse(ApiProvider.domainsUrl);

      final http.Response response = await http.get(url, headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        var jsonMap = jsonDecode(response.body);
        for (var domain in jsonMap) {
          domainList.add(DomainModel.fromJson(domain));
        }
        return domainList;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<SignUpModel?> signUp({required Map<String, String> signUpData}) async {
    try {
      Uri url = Uri.parse(ApiProvider.signUpUrl);
      SignUpModel signUpModel;
      final http.Response response = await http.post(url,
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
          body: jsonEncode({"address": signUpData['address'], "password": signUpData['password']}));
      var jsonMap = jsonDecode(response.body);
      signUpModel = SignUpModel.fromJson(jsonMap);
      return signUpModel;
    } catch (e) {
      return null;
    }
  }

  Future<LoginModel?> login({required Map<String, String> loginData}) async {
    try {
      Uri url = Uri.parse(ApiProvider.loginUrl);
      LoginModel loginModel;
      final http.Response response = await http.post(url,
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
          body: jsonEncode({"address": loginData['address'], "password": loginData['password']}));
      var jsonMap = jsonDecode(response.body);
      loginModel = LoginModel.fromJson(jsonMap);
      return loginModel;
    } catch (e) {
      return null;
    }
  }

  Future<List<MessageModel>> getMessage() async {
    try {
      List<MessageModel> messageList = <MessageModel>[];
      Uri url = Uri.parse(ApiProvider.messageUrl);

      final http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer ${StorageProvider.object.getUserToken()}',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonMap = jsonDecode(response.body);
        for (var message in jsonMap) {
          messageList.add(MessageModel.fromJson(message));
        }
        return messageList;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<MessageDetailsModel?> getMessageDetails({required String messageId}) async {
    try {
      Uri url = Uri.parse('${ApiProvider.messageUrl}/$messageId');
      MessageDetailsModel messageDetailsModel;
      final http.Response response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${StorageProvider.object.getUserToken()}',
      });
      var jsonMap = jsonDecode(response.body);
      messageDetailsModel = MessageDetailsModel.fromJson(jsonMap);
      return messageDetailsModel;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteMessage({required String messageId}) async {
    try {
      Uri url = Uri.parse('${ApiProvider.messageUrl}/$messageId');
      final http.Response response = await http.delete(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${StorageProvider.object.getUserToken()}',
      });
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateMessage({required String messageId}) async {
    try {
      Uri url = Uri.parse('${ApiProvider.messageUrl}/$messageId');
      final http.Response response = await http.patch(url,
          headers: {
            'Accept': 'application/json',
           // 'Content-Type': 'application/json',
            'Authorization': 'Bearer ${StorageProvider.object.getUserToken()}'
          },
          body: jsonEncode({"seen": true}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
