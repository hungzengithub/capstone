class CrackEvaluationDTO {
  final int crackId;
  final int assessmentResult;
  final String assessmentDescription;
  final String status;
  CrackEvaluationDTO(this.crackId, this.assessmentResult,
      this.assessmentDescription, this.status);
  CrackEvaluationDTO._({
    this.crackId,
    this.status,
    this.assessmentResult,
    this.assessmentDescription,
  });
  Map<String, dynamic> toJson() {
    return {
      "crackId": this.crackId,
      "assessmentResult": this.assessmentResult,
      "assessmentDescription": this.assessmentDescription,
      "status": this.status
    };
  }

  factory CrackEvaluationDTO.fromJson(Map<String, dynamic> json) {
    return new CrackEvaluationDTO._(
      crackId: json['crackId'] ?? 0,
      status: json['status'] ?? "",
      assessmentResult: json['assessmentResult'] ?? "",
      assessmentDescription: json['assessmentDescription'] ?? "",
    );
  }
}
