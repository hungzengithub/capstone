import 'dart:convert';
import 'dart:io';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CrackRepository {
  static final CrackRepository _crackRepository = CrackRepository._internal();

  factory CrackRepository() {
    return _crackRepository;
  }
  Future<List<CrackDTO>> fetchCrackByStatus(String status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(CRACK_URL_BY_STATUS + status);
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      return parseCrack(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<List<CrackDTO>> fetchVerifyCrack() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(CRACK_URL + "?ignore=Unconfirmed");
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      return parseCrack(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<String> updateNotVerifyCrack(int crackId, String description,
      String severity, String status, String position) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var userId = prefs.getString('userId');
      var apiPath = Uri.encodeFull(CRACK_URL + "/" + crackId.toString());
      final http.Response response = await http.post(apiPath,
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(<String, String>{
            'reporterId': userId,
            'description': description,
            'position': position,
            'severity': severity,
            'status': status
          }));
      if (response.statusCode != 200) {
        return null;
      }
      return response.body;
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<String> updateVerifyCrack(int crackId, String description,
      String severity, String posDetail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');

      var apiPath = Uri.encodeFull(CRACK_URL + "/" + crackId.toString());
      final http.Response response = await http.post(apiPath,
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(<String, String>{
            'description': description,
            'position': posDetail,
            'severity': severity,
          }));
      if (response.statusCode != 200) {
        return null;
      }
      return response.body;
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<String> addToQueue(List<int> listCrack) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var arr = new List(listCrack.length);
      arr = listCrack.toList();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(QUEUE_URL);
      final http.Response response = await http.post(apiPath,
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: arr.toString());
      if (response.statusCode == 200 || response.statusCode == 400) {
        return response.body;
      } else
        return null;
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<String> removeFromQueue(List<int> listCrack) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var arr =
          new List(listCrack.length); // creates an empty array of length 5
      arr = listCrack.toList();
      var token = prefs.getString('jwtToken');
      print(arr);
      var apiPath = Uri.encodeFull(QUEUE_URL);
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

  Future<List<CrackDTO>> fetchCrackInQueue() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      print(token);
      var apiPath = Uri.encodeFull(QUEUE_URL);
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      if (response.statusCode != 200) return null;
      print(response.body);
      List<CrackDTO> listCrack = parseCrack(utf8.decode(response.bodyBytes));

      return listCrack;
    } catch (e) {
      print("Error at get queue" + e);
    }
  }

  Future<String> deleteCrack(int crackId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(CRACK_URL + "/" + crackId.toString());
      final http.Response response = await http.delete(
        apiPath,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      if (response.statusCode != 200) {
        return null;
      }
      return response.body;
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  List<CrackDTO> parseCrack(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CrackDTO>((json) => CrackDTO.fromJson(json)).toList();
  }

  CrackRepository._internal();
}
