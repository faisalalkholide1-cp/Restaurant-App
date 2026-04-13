class UserSettingModel {
  final String? id;
  final String username;
  final String password;
  final String role;
  final String? restaurantId;
  final String? restaurantName;

  UserSettingModel({
     this.id,
    required this.username,
    required this.password,
    required this.role,
    this.restaurantId,
    this.restaurantName,
  });

  factory UserSettingModel.fromJson(Map<String, dynamic> json) {
    return UserSettingModel(
      id: json['id'].toString(),
      username: json['username'] ?? "",
      password: json['password'] ?? "",
      role: json['role'] ?? "",
      restaurantId: json['restaurant_id'] ?? "",
      restaurantName: json['name'] ?? "",
    );
  }
}