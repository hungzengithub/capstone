class UserDTO {
  final String userId;
  final String email;
  final String userName;
  final String phoneNumber;
  final String name;
  final String address;
  final String role;
  final bool isNewUser;
  final String jwtToken;
  final String locationName;
  final int locationID;

  UserDTO._(
      {this.userId,
      this.email,
      this.userName,
      this.phoneNumber,
      this.name,
      this.address,
      this.role,
      this.isNewUser,
      this.jwtToken,
      this.locationName,
      this.locationID});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return new UserDTO._(
        userId: json['userId'] ?? '',
        userName: json['userName'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        name: json['name'] ?? '',
        address: json['address'] ?? '',
        role: json['role'] ?? '',
        isNewUser: json['isNewUser'] ?? '',
        jwtToken: json['jwtToken'] ?? '',
        locationName:
            json['locations'] != null ? json['locations'][0]["name"] : "",
        locationID: json['locations'] != null
            ? int.parse(json['locations'][0]['locationId'].toString())
            : -1);
  }
}
