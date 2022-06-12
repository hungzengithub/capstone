import 'dart:convert';
import 'dart:io';
import 'package:bcd_app/objects/workerDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkerRepository {
  static final WorkerRepository _workerRepository =
      WorkerRepository._internal();
  List<WorkerDTO> listWorkerDTO;

  factory WorkerRepository() {
    return _workerRepository;
  }
  Future<List<WorkerDTO>> fetchListWorker() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwtToken');
      var apiPath = Uri.encodeFull(MAINTAINANCE_WORKER_URL);
      final response = await http.get(apiPath, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      if (response.statusCode != 200) {
        return null;
      }
      listWorkerDTO = parseWorker(utf8.decode(response.bodyBytes));
      return listWorkerDTO;
    } catch (e) {
      print("Error at get worker" + e);
    }
  }

  List<WorkerDTO> parseWorker(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<WorkerDTO>((json) => WorkerDTO.fromJson(json)).toList();
  }

  WorkerRepository._internal();
}
