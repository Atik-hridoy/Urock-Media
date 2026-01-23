class SingleProductModel {
  final String id;
  final SellerModel seller;
  final String category;
  final String name;
  final String? model; // optional
  final String brand;
  final String description;
  final String? overview; // optional
  final String? sku; // optional
  final List<String> images;
  final String productType; // 'simple' or 'variable'
  final double price; // for simple product
  final double minPrice; // for variable product
  final double maxPrice; // for variable product
  final List<VariantTypeModel> variantTypes; // optional
  final List<VariantModel> variants; // optional
  final int quantity;
  final double discount;
  final String status;
  final double rating;
  final int reviewCount;
  final int views;
  final bool isDeleted;
  final int totalStock;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  bool isBookmarked;

  SingleProductModel({
    required this.id,
    required this.seller,
    required this.category,
    required this.name,
    this.model,
    required this.brand,
    required this.description,
    this.overview,
    this.sku,
    required this.images,
    required this.productType,
    required this.price,
    required this.minPrice,
    required this.maxPrice,
    required this.variantTypes,
    required this.variants,
    required this.quantity,
    required this.discount,
    required this.status,
    required this.rating,
    required this.reviewCount,
    required this.views,
    required this.isDeleted,
    required this.totalStock,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.isBookmarked,
  });

  /// ---------- Empty model ----------
  factory SingleProductModel.empty() => SingleProductModel(
    id: '',
    seller: SellerModel.empty(),
    category: '',
    name: '',
    model: null,
    brand: '',
    description: '',
    overview: null,
    sku: null,
    images: const [],
    productType: '',
    price: 0.0,
    minPrice: 0.0,
    maxPrice: 0.0,
    variantTypes: const [],
    variants: const [],
    quantity: 0,
    discount: 0.0,
    status: '',
    rating: 0.0,
    reviewCount: 0,
    views: 0,
    isDeleted: false,
    totalStock: 0,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    version: 0,
    isBookmarked: false,
  );

  /// ---------- From JSON ----------
  factory SingleProductModel.fromJson(Map<String, dynamic> json) {
    return SingleProductModel(
      id: json['_id'] ?? '',
      seller: json['sellerId'] != null
          ? SellerModel.fromJson(json['sellerId'])
          : SellerModel.empty(),
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      model: json['model'],
      brand: json['brand'] ?? '',
      description: json['description'] ?? '',
      overview: json['overview'],
      sku: json['sku'],
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productType: json['productType'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      minPrice: (json['minPrice'] as num?)?.toDouble() ?? 0.0,
      maxPrice: (json['maxPrice'] as num?)?.toDouble() ?? 0.0,
      variantTypes:
          (json['variantTypes'] as List<dynamic>?)
              ?.map((e) => VariantTypeModel.fromJson(e))
              .toList() ??
          [],
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map((e) => VariantModel.fromJson(e))
              .toList() ??
          [],
      quantity: json['quantity'] ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      views: json['views'] ?? 0,
      isDeleted: json['isDeleted'] ?? false,
      totalStock: json['totalStock'] ?? 0,
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      version: json['__v'] ?? 0,
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  /// ---------- To JSON ----------
  Map<String, dynamic> toJson() => {
    '_id': id,
    'sellerId': seller.toJson(),
    'category': category,
    'name': name,
    'model': model,
    'brand': brand,
    'description': description,
    'overview': overview,
    'sku': sku,
    'images': images,
    'productType': productType,
    'price': price,
    'minPrice': minPrice,
    'maxPrice': maxPrice,
    // 'variantTypes': variantTypes.map((e) => e.toJson()).toList(),
    'variants': variants.map((e) => e.toJson()).toList(),
    'quantity': quantity,
    'discount': discount,
    'status': status,
    'rating': rating,
    'reviewCount': reviewCount,
    'views': views,
    'isDeleted': isDeleted,
    'totalStock': totalStock,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': version,
    'isBookmarked': isBookmarked,
  };
}

class SellerModel {
  final String id;
  final String name;
  final String image;
  final String country;

  const SellerModel({
    required this.id,
    required this.name,
    required this.image,
    required this.country,
  });

  factory SellerModel.empty() =>
      const SellerModel(id: '', name: '', image: '', country: 'N/A');

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name, 'image': image};
}

class VariantOptionModel {
  final String name;
  final String? value; // hex color for Color, null for Size

  VariantOptionModel({required this.name, this.value});

  factory VariantOptionModel.empty() {
    return VariantOptionModel(name: '');
  }

  factory VariantOptionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return VariantOptionModel.empty();

    return VariantOptionModel(
      name: json['name'] ?? '',
      value: json['value'], // optional
    );
  }
}

class VariantTypeModel {
  final String name;
  final List<VariantOptionModel> options;

  VariantTypeModel({required this.name, required this.options});

  /// Empty model
  factory VariantTypeModel.empty() {
    return VariantTypeModel(name: '', options: const []);
  }

  factory VariantTypeModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return VariantTypeModel.empty();

    final rawOptions = json['options'];

    final options = rawOptions is List
        ? rawOptions
              .whereType<Map<String, dynamic>>() // skip invalid items
              .map((e) => VariantOptionModel.fromJson(e))
              .where((e) => e.name.isNotEmpty) // skip empty option
              .toList()
        : <VariantOptionModel>[];

    return VariantTypeModel(name: json['name'] ?? '', options: options);
  }
}

class VariantModel {
  final String variantId;
  final Map<String, dynamic> attributes;
  final String sku;
  final double price;
  final int quantity;
  final double discount;

  const VariantModel({
    required this.variantId,
    required this.attributes,
    required this.sku,
    required this.price,
    required this.quantity,
    required this.discount,
  });

  factory VariantModel.empty() => const VariantModel(
    variantId: '',
    attributes: {},
    sku: '',
    price: 0.0,
    quantity: 0,
    discount: 0.0,
  );

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      variantId: json['variantId'] ?? '',
      attributes: (json['attributes'] as Map<String, dynamic>?) ?? {},
      sku: json['sku'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'variantId': variantId,
    'attributes': attributes,
    'sku': sku,
    'price': price,
    'quantity': quantity,
    'discount': discount,
  };
}
