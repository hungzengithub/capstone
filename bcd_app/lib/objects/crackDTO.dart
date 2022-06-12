import 'package:intl/intl.dart';

class CrackDTO {
  final int crackId;
  int maintenanceOrderId;
  final int locationId;
  final String locationName;
  final double accuracy;
  final String reporterId;
  final String reporterName;
  final String position;
  final String description;
  final String severity;
  final String status;
  final String image;
  final String imageThumbnails;
  final int assessmentResult;
  final String assessmentDescription;
  final String created;
  final String lastModified;
  final DateTime createdDate;
  final DateTime modifiedDate;

  CrackDTO._({
    this.crackId,
    this.maintenanceOrderId,
    this.locationId,
    this.accuracy,
    this.locationName,
    this.reporterId,
    this.reporterName,
    this.position,
    this.description,
    this.severity,
    this.status,
    this.image,
    this.assessmentResult,
    this.assessmentDescription,
    this.created,
    this.lastModified,
    this.createdDate,
    this.modifiedDate,
    this.imageThumbnails,
  });

  factory CrackDTO.fromJson(Map<String, dynamic> json) {
    return new CrackDTO._(
      crackId: json['crackId'] ?? 0,
      maintenanceOrderId: json['maintenanceOrderId'] ?? -1,
      locationId: json['locationId'] ?? 0,
      accuracy: convertAccuracy(json['accuracy'] ?? 0),
      locationName: json['locationName'] ?? "",
      reporterId: json['reporterId'] ?? "",
      reporterName: json['reporterName'] ?? "",
      position: json['position'] ?? "",
      description: json['description'] ?? "",
      status: json['status'] ?? "",
      severity: json['severity'] ?? "",
      image: json['image'] ?? "",
      assessmentResult: json['assessmentResult'] ?? 0,
      assessmentDescription: json['assessmentDescription'] ?? "",
      created: convertTimeToLocal(json['created']),
      lastModified: convertTimeToLocal(json['lastModified']),
      imageThumbnails: json['imageThumbnails'],
      createdDate: json['created'] == null
          ? null
          : DateFormat("yyyy-MM-ddThh:mm:ss")
              .parse(json['created'] ?? "2021-05-01T08:05:00", true)
              .toLocal(),
      modifiedDate: json['lastModified'] == null
          ? null
          : DateFormat("yyyy-MM-ddThh:mm:ss")
              .parse(json['lastModified'] ?? "2021-05-01T08:05:00", true)
              .toLocal(),
    );
  }
}

double convertAccuracy(double accuracy) {
  return accuracy * 100;
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
