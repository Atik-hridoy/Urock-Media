class CartModel {
  final String id;
  final String userId;
  final List<CartItemModel> products;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  const CartModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  /// Empty model
  factory CartModel.empty() => CartModel(
    id: '',
    userId: '',
    products: const [],
    totalAmount: 0.0,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    version: 0,
  );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId,
    'products': products.map((e) => e.toJson()).toList(),
    'totalAmount': totalAmount,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': version,
  };
}

class CartItemModel {
  final String id;
  final CartProductRefModel product;
  final String? variantId;
  final double price;
  int quantity;
  final String productName;
  final String productImage;
  final String productType; // simple | variable
  final Map<String, dynamic> selectedAttributes;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItemModel({
    required this.id,
    required this.product,
    required this.variantId,
    required this.price,
    required this.quantity,
    required this.productName,
    required this.productImage,
    required this.productType,
    required this.selectedAttributes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItemModel.empty() => CartItemModel(
    id: '',
    product: CartProductRefModel.empty(),
    variantId: null,
    price: 0.0,
    quantity: 0,
    productName: '',
    productImage: '',
    productType: '',
    selectedAttributes: const {},
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['_id'] ?? '',
      product: json['productId'] != null
          ? CartProductRefModel.fromJson(json['productId'])
          : CartProductRefModel.empty(),
      variantId: json['variantId'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      productType: json['productType'] ?? '',
      selectedAttributes:
          (json['selectedAttributes'] as Map<String, dynamic>?) ?? {},
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'productId': product.toJson(),
    'variantId': variantId,
    'price': price,
    'quantity': quantity,
    'productName': productName,
    'productImage': productImage,
    'productType': productType,
    'selectedAttributes': selectedAttributes,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

class CartProductRefModel {
  final String id;
  final String name;
  final List<String> images;
  final String productType;

  const CartProductRefModel({
    required this.id,
    required this.name,
    required this.images,
    required this.productType,
  });

  factory CartProductRefModel.empty() =>
      const CartProductRefModel(id: '', name: '', images: [], productType: '');

  factory CartProductRefModel.fromJson(Map<String, dynamic> json) {
    return CartProductRefModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productType: json['productType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'images': images,
    'productType': productType,
  };
}
