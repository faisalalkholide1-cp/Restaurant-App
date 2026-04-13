class RestaurantModel {
  final String id;
  final String name;
  final String logo;
  final String subdomain;
  final String createdAt;
  final String subscriptionStartDate;
  final String subscriptionEndDate;
  String status;
  

  RestaurantModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.subdomain,
    required this.status,
    required this.createdAt,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'].toString(),
      name: json['name']??"",
      logo: json['logo_url']??"",
      subdomain: json['subdomain']??"",
      status: json['status'],
      createdAt: json['created_at']??"",
      subscriptionStartDate: json['subscription_start_date']??"",
      subscriptionEndDate: json['subscription_end_date'] ??"",
    );
  }
}
