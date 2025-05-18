class PlanModel {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final List<String>? features;
  final String? planType;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Subscription>? subscriptions;

  PlanModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.features,
    this.planType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.subscriptions,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num?)?.toDouble(),
      features: (json['features'] as List<dynamic>?)?.map((e) => e as String).toList(),
      planType: json['planType'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      subscriptions: (json['subscriptions'] as List<dynamic>?)
          ?.map((e) => Subscription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'features': features,
      'planType': planType,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'subscriptions': subscriptions?.map((e) => e.toJson()).toList(),
    };
  }
}

class Subscription {
  final String? id;
  final String? userId;
  final String? planId;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isActive;
  final String? promoCodeId;
  final String? paymentStatus;
  final String? paymentIntentId;
  final String? paymentMethod;
  final DateTime? paidAt;
  final String? invoiceUrl;

  Subscription({
    this.id,
    this.userId,
    this.planId,
    this.startDate,
    this.endDate,
    this.isActive,
    this.promoCodeId,
    this.paymentStatus,
    this.paymentIntentId,
    this.paymentMethod,
    this.paidAt,
    this.invoiceUrl,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      userId: json['userId'],
      planId: json['planId'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isActive: json['isActive'],
      promoCodeId: json['promoCodeId'],
      paymentStatus: json['paymentStatus'],
      paymentIntentId: json['paymentIntentId'],
      paymentMethod: json['paymentMethod'],
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
      invoiceUrl: json['invoiceUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'planId': planId,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive,
      'promoCodeId': promoCodeId,
      'paymentStatus': paymentStatus,
      'paymentIntentId': paymentIntentId,
      'paymentMethod': paymentMethod,
      'paidAt': paidAt?.toIso8601String(),
      'invoiceUrl': invoiceUrl,
    };
  }
}
