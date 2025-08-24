class SplashProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? userName;
  final String? country;
  final String? image;
  final String role;
  final bool isSubscribed;
  final DateTime createdAt;

  SplashProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.userName,
    this.country,
    this.image,
    required this.role,
    required this.isSubscribed,
    required this.createdAt,
  });

  // Factory constructor for JSON deserialization
  factory SplashProfileModel.fromJson(Map<String, dynamic> json) {
    return SplashProfileModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userName: json['userName'] as String?,
      country: json['country'] as String?,
      image: json['image'] as String?,
      role: json['role'] as String,
      isSubscribed: json['isSubscribed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Method to convert Dart object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'country': country,
      'image': image,
      'role': role,
      'isSubscribed': isSubscribed,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
