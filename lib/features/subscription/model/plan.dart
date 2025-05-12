class Plan {
  final String planName;
  final int price;
  final String planTime;

  Plan({required this.planName, required this.price, required this.planTime});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planName: json['planName'],
      price: json['price'],
      planTime: json['planTime'],
    );
  }
}
