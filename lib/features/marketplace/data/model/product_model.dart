class ProductModel {
  final String id;
  final String name;
  final String brand;
  final List<String> images;
  final String productType;

  // Simple product
  final double price;
  final int quantity;
  final double discount;

  // Variable product
  final PriceRange priceRange;
  final List<VariantType> variantTypes;
  final List<ProductVariant> variants;

  // Common
  final double rating;
  final int reviewCount;
  final int totalStock;
  final String status;
  final String? categoryId;
  bool isBookmarked;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.images,
    required this.productType,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.priceRange,
    required this.variantTypes,
    required this.variants,
    required this.rating,
    required this.reviewCount,
    required this.totalStock,
    required this.status,
    required this.categoryId,
    required this.isBookmarked,
  });

  /// ✅ EMPTY STATE
  factory ProductModel.empty() {
    return ProductModel(
      id: '',
      name: '',
      brand: '',
      images: const [],
      productType: 'simple',
      price: 0,
      quantity: 0,
      discount: 0,
      priceRange: PriceRange.empty(),
      variantTypes: const [],
      variants: const [],
      rating: 0,
      reviewCount: 0,
      totalStock: 0,
      status: '',
      categoryId: null,
      isBookmarked: false,
    );
  }

  /// ✅ SAFE JSON PARSING
  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProductModel.empty();

    return ProductModel(
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      images: List<String>.from(json['images'] ?? const []),
      productType: json['productType'] ?? 'simple',

      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      discount: (json['discount'] ?? 0).toDouble(),

      priceRange: json['priceRange'] != null
          ? PriceRange.fromJson(json['priceRange'])
          : PriceRange.empty(),

      variantTypes:
          (json['variantTypes'] as List?)
              ?.map((e) => VariantType.fromJson(e))
              .toList() ??
          [],

      variants:
          (json['variants'] as List?)
              ?.map((e) => ProductVariant.fromJson(e))
              .toList() ??
          [],

      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      totalStock: json['totalStock'] ?? 0,
      status: json['status'] ?? '',
      categoryId: json['categoryId'],
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  /// 🔥 Helpers
  bool get isVariable => productType == 'variable';

  double get displayMinPrice => isVariable ? priceRange.min : price;

  double get displayMaxPrice => isVariable ? priceRange.max : price;
}

class PriceRange {
  final double min;
  final double max;

  const PriceRange({required this.min, required this.max});

  factory PriceRange.empty() {
    return const PriceRange(min: 0, max: 0);
  }

  factory PriceRange.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PriceRange.empty();

    return PriceRange(
      min: (json['min'] ?? 0).toDouble(),
      max: (json['max'] ?? 0).toDouble(),
    );
  }
}

class VariantType {
  final String name;
  final List<VariantOption> options;

  VariantType({required this.name, required this.options});

  factory VariantType.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return VariantType(name: '', options: []);
    }

    return VariantType(
      name: json['name'] ?? '',
      options:
          (json['options'] as List?)
              ?.map((e) => VariantOption.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class VariantOption {
  final String name;

  VariantOption({required this.name});

  factory VariantOption.fromJson(Map<String, dynamic>? json) {
    return VariantOption(name: json?['name'] ?? '');
  }
}

class ProductVariant {
  final String variantId;
  final Map<String, String> attributes;
  final String sku;
  final double price;
  final int quantity;
  final double discount;

  ProductVariant({
    required this.variantId,
    required this.attributes,
    required this.sku,
    required this.price,
    required this.quantity,
    required this.discount,
  });

  factory ProductVariant.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ProductVariant(
        variantId: '',
        attributes: {},
        sku: '',
        price: 0,
        quantity: 0,
        discount: 0,
      );
    }

    return ProductVariant(
      variantId: json['variantId'] ?? '',
      attributes: Map<String, String>.from(json['attributes'] ?? {}),
      sku: json['sku'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      discount: (json['discount'] ?? 0).toDouble(),
    );
  }
}
