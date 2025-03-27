import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/model/start_design/example_model/example_model.dart';
import 'package:ecommerce/model/start_design/logos_model/logos_model.dart';
import 'package:ecommerce/model/start_design/print_types/print_types.dart';

class CartItem {
  int? id;
  Coupon? coupon;
  int? couponDiscountAmount;
  int? total;
  List<CartItems>? cartItems;

  CartItem(
      {this.id,
      this.coupon,
      this.couponDiscountAmount,
      this.total,
      this.cartItems});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
    couponDiscountAmount = json['coupon_discount_amaount'];
    total = json['total'];
    if (json['cartitems'] != null) {
      cartItems = <CartItems>[];
      json['cartitems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon'] = this.coupon;
    data['coupon_discount_amaount'] = this.couponDiscountAmount;
    data['total'] = this.total;
    if (this.cartItems != null) {
      data['cartitems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'CartItem{id: $id, coupon: $coupon, couponDiscountAmount: $couponDiscountAmount, total: $total, cartItems: $cartItems}';
  }
}

class Coupon {
  int? id;
  String? name;
  String? coupon;
  int? discount;
  int? minimumAmount;
  String? startDateTime;
  String? endDateTime;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  Coupon(
      {this.id,
      this.name,
      this.coupon,
      this.discount,
      this.minimumAmount,
      this.startDateTime,
      this.endDateTime,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coupon = json['coupon'];
    discount = json['discount'];
    minimumAmount = json['minimum_amount'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['coupon'] = this.coupon;
    data['discount'] = this.discount;
    data['minimum_amount'] = this.minimumAmount;
    data['start_date_time'] = this.startDateTime;
    data['end_date_time'] = this.endDateTime;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CartItems {
  int? id;
  Products? product;
  Examples? example;
  Examples? name;
  Logos? logo;
  Logos? image;
  String? customImage;
  PrintType? printType;
  List<PrintType>? sizeDirection;
  PrintType? model;
  PrintType? material;
  String? number;
  String? printColor;
  int? quantity;
  ProductsColors? color;
  Sizes? size;
  String? orderType;
  int? total;
  String? createdAt;
  String? updatedAt;

  CartItems(
      {this.id,
      this.product,
      this.example,
      this.name,
      this.logo,
      this.image,
      this.customImage,
      this.printType,
      this.sizeDirection,
      this.model,
      this.material,
      this.number,
      this.printColor,
      this.quantity,
      this.color,
      this.size,
      this.orderType,
      this.total,
      this.createdAt,
      this.updatedAt});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Products.fromJson(json['product']) : null;

    // Deserialize example
    example =
        json['example'] != null ? Examples.fromJson(json['example']) : null;

    // Deserialize name
    name = json['name'] != null ? Examples.fromJson(json['name']) : null;

    // Deserialize logo
    logo = json['logo'] != null ? Logos.fromJson(json['logo']) : null;

    // Deserialize image
    image = json['image'] != null ? Logos.fromJson(json['image']) : null;

    customImage = json['custom_image'];
    printType = json['printtype'] != null
        ? PrintType.fromJson(json['printtype'])
        : null;

    if (json['sizedirection'] != null) {
      sizeDirection = <PrintType>[];
      json['sizedirection'].forEach((v) {
        sizeDirection!.add(PrintType.fromJson(v));
      });
    }

    model = json['model'] != null ? PrintType.fromJson(json['model']) : null;
    material =
        json['material'] != null ? PrintType.fromJson(json['material']) : null;
    number = json['number'];
    printColor = json['print_color'];
    quantity = json['quantity'];

    color =
        json['color'] != null ? ProductsColors.fromJson(json['color']) : null;
    size = json['size'] != null ? Sizes.fromJson(json['size']) : null;
    total = json['total'];
    orderType = json['order_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['example'] = this.example;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['image'] = this.image;
    data['custom_image'] = this.customImage;
    data['printtype'] = this.printType;
    if (this.sizeDirection != null) {
      data['sizedirection'] =
          this.sizeDirection!.map((v) => v.toJson()).toList();
    }
    data['model'] = this.model;
    data['material'] = this.material;
    data['number'] = this.number;
    data['print_color'] = this.printColor;
    data['quantity'] = this.quantity;
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    data['total'] = this.total;
    data['order_type'] = this.orderType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  toString() {
    return 'CartItems{id: $id, product: $product, example: $example, name: $name, logo: $logo, image: $image, customImage: $customImage, '
        'printtype: $printType, sizedirection: $sizeDirection, model: $model, material: $material, '
        'number: $number, printColor: $printColor, quantity: $quantity, color: $color, size: $size, '
        'total: $total, '
        'orderType: $orderType, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
