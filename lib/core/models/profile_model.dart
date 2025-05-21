class ProfileModel {
  final String id;
  final String? name;
  final String? userName;
  final String? phone;
  final String? image;
  final String? country;
  final String? userId;

  ProfileModel({
    required this.id,
    this.name,
    this.userName,
    this.phone,
    this.image,
    this.country,
    this.userId,
  });

  // Parse JSON to ProfileModel
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      country: json['country'] as String?,
      userId: json['userId'] as String?,
    );
  }

  // Convert ProfileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userName': userName,
      'phone': phone,
      'image': image,
      'country': country,
      'userId': userId,
    };
  }
}
