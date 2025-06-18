// Marketplace Models

class MarketplaceItem {
  final String id;
  final String name;
  final String description;
  final int points;
  final int originalPrice;
  final String imageUrl;
  final String category;
  final double rating;
  final bool isPopular;
  final bool isAvailable;
  final int stock;
  final List<String> tags;
  final String? discount;
  final DateTime? availableUntil;

  const MarketplaceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.originalPrice,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.isPopular,
    this.isAvailable = true,
    this.stock = 0,
    this.tags = const [],
    this.discount,
    this.availableUntil,
  });

  factory MarketplaceItem.fromJson(Map<String, dynamic> json) {
    return MarketplaceItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      points: json['points'] as int,
      originalPrice: json['originalPrice'] as int,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
      isPopular: json['isPopular'] as bool,
      isAvailable: json['isAvailable'] as bool? ?? true,
      stock: json['stock'] as int? ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      discount: json['discount'] as String?,
      availableUntil: json['availableUntil'] != null
          ? DateTime.parse(json['availableUntil'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'points': points,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
      'isPopular': isPopular,
      'isAvailable': isAvailable,
      'stock': stock,
      'tags': tags,
      'discount': discount,
      'availableUntil': availableUntil?.toIso8601String(),
    };
  }
}

class MarketplaceCategory {
  final String id;
  final String name;
  final String icon;
  final int itemCount;
  final bool isActive;

  const MarketplaceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.itemCount,
    this.isActive = true,
  });

  factory MarketplaceCategory.fromJson(Map<String, dynamic> json) {
    return MarketplaceCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      itemCount: json['itemCount'] as int,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'itemCount': itemCount,
      'isActive': isActive,
    };
  }
}

enum PurchaseStatus { pending, processing, shipped, delivered, cancelled }

class PurchaseHistory {
  final String id;
  final String itemId;
  final String itemName;
  final int pointsSpent;
  final DateTime purchaseDate;
  final PurchaseStatus status;
  final String? trackingNumber;
  final String? notes;

  const PurchaseHistory({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.pointsSpent,
    required this.purchaseDate,
    required this.status,
    this.trackingNumber,
    this.notes,
  });

  factory PurchaseHistory.fromJson(Map<String, dynamic> json) {
    return PurchaseHistory(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      pointsSpent: json['pointsSpent'] as int,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      status: PurchaseStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => PurchaseStatus.pending,
      ),
      trackingNumber: json['trackingNumber'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'itemName': itemName,
      'pointsSpent': pointsSpent,
      'purchaseDate': purchaseDate.toIso8601String(),
      'status': status.name,
      'trackingNumber': trackingNumber,
      'notes': notes,
    };
  }
}
