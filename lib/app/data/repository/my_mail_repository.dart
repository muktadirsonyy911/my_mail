import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_mail/app/data/models/domain_model.dart';
import 'package:my_mail/app/data/models/sign_up_model.dart';
import 'package:my_mail/app/data/providers/api_provider.dart';

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
      print('error: $e');
      return [];
    }
  }

  Future<SignUpModel?> signUp({required Map<String, String> signUpData}) async {
    try {
      Uri url = Uri.parse(ApiProvider.signUpUrl);
      SignUpModel signUpModel;
      final http.Response response = await http.post(url,
          headers: {'Accept': 'application/json', 'Content-Type':'application/json'},
          body: jsonEncode({"address": signUpData['address'], "password": signUpData['password']}));
      var jsonMap = jsonDecode(response.body);
      signUpModel = SignUpModel.fromJson(jsonMap);
      return signUpModel;
    } catch (e) {
      return null;
    }
  }
}
