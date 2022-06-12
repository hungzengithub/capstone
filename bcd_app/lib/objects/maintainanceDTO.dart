import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:intl/intl.dart';

import 'crackDTO.dart';

class MaintainanceDTO {
  static CrackRepository crackRepo = new CrackRepository();
  final int maintenanceOrderId;
  final int maintenanceWorkerId;
  final String maintenanceWorkerName;
  final String assessorId;
  final String assessorName;
  final String description;
  final int assessmentResult;
  final String status;
  final String maintenanceDate;
  final List<CrackDTO> cracks;
  final double maintenanceExpense;

  MaintainanceDTO._({
    this.maintenanceOrderId,
    this.maintenanceWorkerId,
    this.maintenanceWorkerName,
    this.assessorId,
    this.assessorName,
    this.description,
    this.assessmentResult,
    this.status,
    this.maintenanceDate,
    this.cracks,
    this.maintenanceExpense,
  });
  factory MaintainanceDTO.fromJson(Map<String, dynamic> json) {
    return new MaintainanceDTO._(
      maintenanceOrderId: json['maintenanceOrderId'] ?? 0,
      maintenanceWorkerId: json['maintenanceWorkerId'] ?? 0,
      maintenanceWorkerName: json['maintenanceWorkerName'] ?? "",
      assessorId: json['assessorId'] ?? "",
      assessorName: json['assessorName'] ?? "",
      description: json['description'] ?? "",
      assessmentResult: json['assessmentResult'] ?? "",
      status: json['status'] ?? "",
      maintenanceDate:
          convertTimeToLocal(json['maintenanceDate'] ?? "2021-05-01T08:05:00"),
      cracks: fetchCrackInQueue(json['cracks']),
      maintenanceExpense: json['maintenanceExpense'] != null
          ? double.parse(json['maintenanceExpense'].toString())
          : 0,
    );
  }
}

String convertTimeToLocal(String time) {
  try {
    DateTime tmpDate =
        DateFormat("yyyy-MM-ddThh:mm:ss").parse(time, true).toLocal();
    return tmpDate.toString().split(".").first;
  } catch (e) {
    print("Error when convert time" + e);
  }
  return '';
}

List<CrackDTO> fetchCrackInQueue(List<dynamic> cracks) {
  try {
    return cracks.map<CrackDTO>((json) => CrackDTO.fromJson(json)).toList();
  } catch (e) {
    print(e);
  }
  return List<CrackDTO>();
}
