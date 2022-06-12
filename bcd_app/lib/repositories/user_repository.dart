import 'dart:convert';
import 'dart:io';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static final UserRepository _crackRepository = UserRepository._internal();

  factory UserRepository() {
    return _crackRepository;
  }
  Future<UserDTO> login(String username, String password) async {
    try {
      var apiPath = Uri.encodeFull(LOGIN_STAFF);
      FirebaseMessaging fm = new FirebaseMessaging();
      String fcmToken = await fm.getToken();

      final http.Response response = await http.post(
        apiPath,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userName': username,
          'password': password,
          'fcmToken': fcmToken,
        }),
      );
      if (response.statusCode != 200) {
        return null;
      }
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      UserDTO dto = UserDTO.fromJson(responseJson);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('jwtToken', dto.jwtToken);
      prefs.setString('userId', dto.userId);
      if (!dto.isNewUser) {
        dto = await getUserLogin(dto.jwtToken, dto.userId);
        return dto;
      } else
        return dto;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> changeNewUserPasss(String oldPass, String newPass) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userId');
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(USER_URL + userId + "/password");

      final http.Response response = await http.post(
        apiPath,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          'oldPass': oldPass,
          'newPass': newPass,
        }),
      );
      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserDTO> getUserLogin(String token, String userId) async {
    try {
      var apiPath = Uri.encodeFull(USER_URL + userId);
      final http.Response response = await http.get(
        apiPath,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );

      if (response.statusCode != 200) {
        return null;
      }
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      return UserDTO.fromJson(responseJson);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> changePassword(String oldPass, String newPass) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var userId = prefs.getString('userId');
      var apiPath = Uri.encodeFull(USER_URL + userId + "/password");
      final http.Response response = await http.post(
        apiPath,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          'oldPass': oldPass,
          'newPass': newPass,
        }),
      );
      if (response.statusCode != 200) {
        return null;
      }

      return response.body;
    } catch (e) {
      print("Exception at change Password " + e);
    }
  }

  Future<String> resetPassword(String username) async {
    try {
      var apiPath = Uri.encodeFull(FORGOT_PASS_URL + username);
      final http.Response response = await http.post(
        apiPath,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );
      if (response.statusCode != 200) {
        return null;
      }
      return response.body;
    } catch (e) {
      print("Exception at Reset Password " + e);
    }
  }

  UserRepository._internal();
}
