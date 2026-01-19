class ProductModel {
  final String id;
  final String name;
  final String brand;
  final List<String> images;
  final String productType;
  final double price;
  final int quantity;
  final double discount;
  final double rating;
  final int reviewCount;
  final int totalStock;
  final String status;
  final String categoryId;
  final bool isBookmarked;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.images,
    required this.productType,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.rating,
    required this.reviewCount,
    required this.totalStock,
    required this.status,
    required this.categoryId,
    required this.isBookmarked,
  });

  /// ---------- Empty Model ----------
  factory ProductModel.empty() {
    return const ProductModel(
      id: '',
      name: '',
      brand: '',
      images: [],
      productType: '',
      price: 0.0,
      quantity: 0,
      discount: 0.0,
      rating: 0.0,
      reviewCount: 0,
      totalStock: 0,
      status: '',
      categoryId: '',
      isBookmarked: false,
    );
  }

  /// ---------- From JSON ----------
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productType: json['productType'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      totalStock: json['totalStock'] ?? 0,
      status: json['status'] ?? '',
      categoryId: json['categoryId'] ?? '',
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  /// ---------- To JSON ----------
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'brand': brand,
      'images': images,
      'productType': productType,
      'price': price,
      'quantity': quantity,
      'discount': discount,
      'rating': rating,
      'reviewCount': reviewCount,
      'totalStock': totalStock,
      'status': status,
      'categoryId': categoryId,
      'isBookmarked': isBookmarked,
    };
  }
}
