import 'dart:convert';
import 'dart:io';
import 'package:bcd_app/objects/notificationDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepository {
  static final NotificationRepository _crackRepository =
      NotificationRepository._internal();
  Future<List<NotificationDTO>> fetchNotification() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(NOTIFICATION_URL);
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      return parseNotification(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  factory NotificationRepository() {
    return _crackRepository;
  }
  List<NotificationDTO> parseNotification(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<NotificationDTO>((json) => NotificationDTO.fromJson(json))
        .toList();
  }

  Future<String> deleteNoti(List<int> listNoti) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var arr = new List(listNoti.length);
      arr = listNoti.toList();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(NOTIFICATION_URL);
      final request = http.Request("DELETE", Uri.parse(apiPath));
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      request.body = arr.toString();
      final response = await request.send();
      if (response.statusCode != 200)
        return Future.error("error: status code ${response.statusCode}");
      return await response.stream.bytesToString();
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<String> readNoti(int notiId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var arr = new List(1);
      arr[0] = notiId;
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(NOTIFICATION_URL);
      final request = http.Request("DELETE", Uri.parse(apiPath));
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      request.body = arr.toString();
      final response = await request.send();
      if (response.statusCode != 200)
        return Future.error("error: status code ${response.statusCode}");
      return await response.stream.bytesToString();
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  NotificationRepository._internal();
}
