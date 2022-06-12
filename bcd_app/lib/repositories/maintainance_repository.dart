import 'dart:convert';
import 'dart:io';
import 'package:bcd_app/objects/crackEvaluationDTO.dart';
import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MaintainanceRepository {
  static final MaintainanceRepository _maintainanceRepository =
      MaintainanceRepository._internal();

  factory MaintainanceRepository() {
    return _maintainanceRepository;
  }

  Future<String> confirmMaintainance(int maintenanceWorkerId,
      String maintenanceDate, double maintenanceExpense) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(CONFIRM_MAINTAINANCE_URL);
      final http.Response response = await http.post(apiPath,
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(<String, Object>{
            'maintenanceWorkerId': maintenanceWorkerId.toString(),
            'maintenanceDate': maintenanceDate,
            'maintenanceExpense': maintenanceExpense
          }));
      if (response.statusCode != 200) {
        return null;
      }
      return response.body;
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<String> updateMaintenance(int maintenanceWorkerId,
      String maintenanceDate, int id, double maintenanceExpense) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(MAINTAINANCE_URL + "/" + id.toString());
      final http.Response response = await http.post(apiPath,
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(<String, Object>{
            'maintenanceWorkerId': maintenanceWorkerId.toString(),
            'maintenanceDate': maintenanceDate,
            'maintenanceExpense': maintenanceExpense
          }));
      if (response.statusCode != 200) {
        return null;
      }
      return response.body;
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<MaintainanceDTO> getMaintainanceById(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(MAINTAINANCE_URL + "/" + id);
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      if (response.statusCode != 200) {
        return null;
      }
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      return MaintainanceDTO.fromJson(responseJson);
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<List<MaintainanceDTO>> getWaitingMaintainance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(
          "https://bcdsys.azurewebsites.net/api/v1/maintenance-orders?status=WaitingForRepair");
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      if (response.statusCode != 200) {
        return null;
      }
      return parseCrack(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  Future<List<MaintainanceDTO>> getCompletedMaintainance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(
          "https://bcdsys.azurewebsites.net/api/v1/maintenance-orders?status=Completed");
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      if (response.statusCode != 200) {
        return null;
      }
      return parseCrack(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  List<MaintainanceDTO> parseCrack(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MaintainanceDTO>((json) => MaintainanceDTO.fromJson(json))
        .toList();
  }

  Future<String> evaluate(int average, int id,
      List<CrackEvaluationDTO> listCrack, String description) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath =
          Uri.encodeFull(MAINTAINANCE_URL + "/" + id.toString() + "/evaluate");
      final http.Response response = await http.post(apiPath,
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(<String, dynamic>{
            "description": description,
            "assessmentResult": average,
            "crackAssessments": listCrack.map((e) => e.toJson()).toList(),
          }));
      if (response.statusCode != 200) {
        return null;
      }
      return response.body;
    } catch (e) {
      throw Exception("Error on server");
    }
  }

  MaintainanceRepository._internal();
}
