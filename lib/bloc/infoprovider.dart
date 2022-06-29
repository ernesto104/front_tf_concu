import 'dart:convert';

import 'package:tf_concurrencia/model/createInfo.dart';
import 'package:tf_concurrencia/model/info.dart';
import 'package:http/http.dart' as http;

const API = 'http://localhost:8001';

class InfoProvider {
  Future<List<Info>> getAllInfo() async {
    var url = '$API/getinfo';

    Uri uri = Uri.parse(url);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body)['data'] as List;
      List<Info> infos = [];

      jsonResponse.forEach((element) {
        var info = Info.fromJson(element);
        infos.add(info);
      });

      return infos;
    } else {
      return Future.error("Internal server error");
    }
  }

  Future<bool> createInfo(CreateInfo createInfo) async {
    var url = '$API/create';

    Uri uri = Uri.parse(url);

    var body = createInfo.toJson();

    var response = await http.post(uri, body: json.encode(body), headers: {
      "Content-Type": "application/json",
      //"Accept": "application/json"
    });

    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.body);
      print(response.statusCode);
      return false;
    }
  }

  Future<bool> deleteInfo(infoName) async {
    var url = '$API/delete/$infoName';

    Uri uri = Uri.parse(url);
    var createInfo = CreateInfo();
    var body = createInfo.toDeleteJson(infoName);

    var response = await http.delete(uri, body: json.encode(body), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateInfo(CreateInfo createInfo, infoName) async {
    var url = '$API/update/$infoName';

    Uri uri = Uri.parse(url);

    var body = createInfo.toUpdateJson();

    var response = await http.put(uri, body: json.encode(body), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
