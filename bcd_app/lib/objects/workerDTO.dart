import 'package:intl/intl.dart';

class WorkerDTO {
  final int maintenanceWorkerId;
  final String email;
  final String phone;
  final String name;
  final String address;
  final String created;
  final String lastModified;
  WorkerDTO._({
    this.maintenanceWorkerId,
    this.email,
    this.phone,
    this.name,
    this.address,
    this.created,
    this.lastModified,
  });

  factory WorkerDTO.fromJson(Map<String, dynamic> json) {
    return new WorkerDTO._(
      maintenanceWorkerId: json['maintenanceWorkerId'] ?? 0,
      address: json['address'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      name: json['name'] ?? "",
      created: convertTimeToLocal(json['created'] ?? "2021-05-01T08:05:00"),
      lastModified:
          convertTimeToLocal(json['lastModified'] ?? "2021-05-01T08:05:00"),
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
