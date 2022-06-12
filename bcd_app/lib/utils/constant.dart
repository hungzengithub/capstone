class MaintenanceOrderStatus {
  static const String WaitingForConfirm = "WaitingForConfirm";
  static const String WaitingForMaintenance = "WaitingForRepair";
  static const String Completed = "Completed";
}

class CrackSeverity {
  static const String Low =
      "Low"; // Nhung vet nut chua can thiet phai sua, dua vao danh sach theo doi
  static const String Medium =
      "Medium"; // Nhung vet nut o muc do co the bo qua trong lan sua toi
  static const String High =
      "High"; //Nhung vet nut bat buoc phai sua trong lan sua toi
}

class CrackStatus {
  static const String DetectedFailed = "DetectedFailed";
  static const String Unconfirmed = "Unconfirmed";
  static const String UnscheduledForMaintenace = "UnrecordedRepair";
  static const String ScheduledForMaintenace = "RecordedRepair";
  static const String UnqualifiedRepair = "UnqualifiedRepair";
  static const String Fixed = "Fixed";
}

class MessageTypes {
  static const String AdminUpdateInfo = "AdminUpdateInfo";
  static const String SystemFinishedDetection = "SystemFinishedDetection";
  static const String StaffCreateOrder = "StaffCreateOrder";
  static const String StaffUpdateOrder = "StaffUpdateOrder";
  static const String StaffEvaluateOrder = "StaffEvaluateOrder";
}

class APPMESSAGE {
  static const LOGIN_FAIL = "Your username or password is incorrect";
  static const RESET_PASS_SUCCESS = "Reset password successfully";
  static const RESET_PASS_FAIL = "Your username is incorrect";
  static const REJECT_CRACK_SUCCESS = "Reject crack successfully";
  static const REJECT_CRACK_FAIL = "Reject crack failed";
  static const CONFIRM_CRACK_SUCCESS = "Confirm crack successfully";
  static const CONFIRM_CRACK_FAIL = "Confirm crack failed";
  static const UPDATE_CRACK_SUCCESS = "Update crack successfully";
  static const UPDATE_CRACK_FAIL = "Update crack failed";
  static const ADD_TO_QUEUE_SUCCESS = "Add crack to queue successfully";
  static const ADD_TO_QUEUE_FAIL = "Crack is existed in queue";
  static const CHANGE_PASSWORD_SUCCESS = "Change password successfully";
  static const CHANGE_PASSWORD_FAIL = "Your old password may be incorrect";
  static const REMOVE_FROM_QUEUE_SUCCESS =
      "Remove crack from queue successfully";
  static const REMOVE_FROM_QUEUE_FAIL = "Remove crack from queue failed";
  static const RECORD_REPAIR_SUCCESS = "Record repair successfully";
  static const RECORD_REPAIR_FAIL = "Record repair failed";
  static const UPDATE_REPAIR_SUCCESS = "Update repair record successfully";
  static const UPDATE_REPAIR_FAIL = "Update repair record failed";
  static const EVALUATE_CRACK_SUCCESS = "Evaluate crack successfully";
  static const EVALUATE_CRACK_FAIL = "You need evaluate all cracks";
  static const EVALUATE_REPAIR_SUCCESS = "Evaluate repair successfully";
  static const EVALUATE_REPAIR_FAIL = "Evaluate repair failed";
}
