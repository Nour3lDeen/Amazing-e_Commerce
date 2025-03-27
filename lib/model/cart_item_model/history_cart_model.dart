import 'package:ecommerce/model/auth/user.dart';
import 'package:ecommerce/model/sections_model/sections_model.dart';

class HistoryCartItem {
  final int id;
  final String orderNumber;
  final String paymentMethod;
  final int shippingAmount;
  final int taxAmount;
  final int total;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Addresses address;
  final List<OrderItems> orderItems;

  HistoryCartItem({
    required this.id,
    required this.orderNumber,
    required this.paymentMethod,
    required this.shippingAmount,
    required this.taxAmount,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.orderItems,
  });

  factory HistoryCartItem.fromJson(Map<String, dynamic> json) {
    return HistoryCartItem(
      id: json['id'] as int,
      orderNumber: json['order_number']?.toString().trim() ?? '',
      paymentMethod: json['payment_method']?.toString() ?? '',
      shippingAmount: json['shipping_amount'] as int,
      taxAmount: json['tax_amount'] as int,
      total: json['total'] as int,
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      address: Addresses.fromJson(json['address'] ?? {}),
      orderItems: (json['orderitems'] as List<dynamic>?)
              ?.map((item) => OrderItems.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class OrderItems {
  int? id;
  int? orderId;
  Products? product;
  String? exampleName;
  int? examplePrice;
  String? nameName;
  int? namePrice;
  String? logo;
  int? logoPrice;
  String? image;
  int? imagePrice;
  String? number;
  String? printTypeNameAr;
  String? printTypeNameEn;
  int? printTypePrice;
  String? sizeDirectionName;
  int? sizeDirectionPrices;
  String? modelNameAr;
  String? modelNameEn;
  int? modelPrice;
  String? printColor;
  String? materialNameAr;
  String? materialNameEn;
  int? materialPrice;
  int? quantity;
  String? colorName;
  String? colorCode;
  String? colorImage;
  String? sizeCode;
  int? sizePrice;
  String? orderType;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? total;

  OrderItems(
      {this.id,
      this.orderId,
      this.product,
      this.exampleName,
      this.examplePrice,
      this.nameName,
      this.namePrice,
      this.logo,
      this.logoPrice,
      this.image,
      this.imagePrice,
      this.number,
      this.printTypeNameAr,
      this.printTypeNameEn,
      this.printTypePrice,
      this.sizeDirectionName,
      this.sizeDirectionPrices,
      this.modelNameAr,
      this.modelNameEn,
      this.modelPrice,
      this.printColor,
      this.materialNameAr,
      this.materialNameEn,
      this.materialPrice,
      this.quantity,
      this.colorName,
      this.colorCode,
      this.colorImage,
      this.sizeCode,
      this.sizePrice,
      this.orderType,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.total});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    orderId = json['order_id'] as int;
    product =
        json['product'] != null ? new Products.fromJson(json['product']) : null;
    json['example_name'] != null ? exampleName = json['example_name'] : null;
    examplePrice = json['example_price'];
    json['name_name'] != null ? nameName = json['name_name'] : null;
    namePrice = json['name_price'];
    logo = json['logo'];
    logoPrice = json['logo_price'];
    image = json['image'];
    imagePrice = json['image_price'];
    number = json['number'];
    json['printtype_name_ar'] != null
        ? printTypeNameAr = json['printtype_name_ar']
        : null;
    json['printtype_name_en'] != null
        ? printTypeNameEn = json['printtype_name_en']
        : null;
    printTypePrice = json['printtype_price'];
    sizeDirectionName = json['sizedirection_name'];
    sizeDirectionPrices = json['sizedirection_prices'] as int;
    modelNameAr = json['model_name_ar'];
    modelNameEn = json['model_name_en'];
    modelPrice = json['model_price'];
    printColor = json['print_color'];
    materialNameAr = json['material_name_ar'];
    materialNameEn = json['material_name_en'];
    materialPrice = json['material_price'];
    quantity = json['quantity'];
    colorName = json['color_name'];
    colorCode = json['color_code'];
    colorImage = json['color_image'];
    sizeCode = json['size_code'];
    sizePrice = json['size_price'];
    orderType = json['order_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['example_name'] = this.exampleName;
    data['example_price'] = this.examplePrice;
    data['name_name'] = this.nameName;
    data['name_price'] = this.namePrice;
    data['logo'] = this.logo;
    data['logo_price'] = this.logoPrice;
    data['image'] = this.image;
    data['image_price'] = this.imagePrice;
    data['number'] = this.number;
    data['printtype_name_ar'] = this.printTypeNameAr;
    data['printtype_name_en'] = this.printTypeNameEn;
    data['printtype_price'] = this.printTypePrice;
    data['sizedirection_name'] = this.sizeDirectionName;
    data['sizedirection_prices'] = this.sizeDirectionPrices;
    data['model_name_ar'] = this.modelNameAr;
    data['model_name_en'] = this.modelNameEn;
    data['model_price'] = this.modelPrice;
    data['print_color'] = this.printColor;
    data['material_name_ar'] = this.materialNameAr;
    data['material_name_en'] = this.materialNameEn;
    data['material_price'] = this.materialPrice;
    data['quantity'] = this.quantity;
    data['color_name'] = this.colorName;
    data['color_code'] = this.colorCode;
    data['color_image'] = this.colorImage;
    data['size_code'] = this.sizeCode;
    data['size_price'] = this.sizePrice;
    data['order_type'] = this.orderType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['total'] = this.total;
    return data;
  }
}
