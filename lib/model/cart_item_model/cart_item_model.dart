import 'package:ecommerce/model/sections_model/sections_model.dart';


class CartItem {
  int? id;
  Products? product;
  int? example;
  int? name;
  int? logo;
  int? image;
  String? customImage;
  int? printType;
  List<int>? sizeDirection;
  int? model;
  int? material;
  int? number;
  int? printColor;
  String? quantity;
  ProductsColors? color;
  Sizes? size;
  String? orderType;
  String? createdAt;
  String? updatedAt;
  String? total;

  CartItem({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.total,
  });
 @override
  String toString() {
   return 'CartItem{'
       'id: $id, '
       'product: $product, '
       'example: $example, '
       'name: $name, '
       'logo: $logo, '
       'image: $image, '
       'customImage: $customImage, '
       'printType: $printType, '
       'sizeDirection: $sizeDirection, '
       'model: $model, '
       'material: $material, '
       'number: $number, '
       'printColor: $printColor, '
       'quantity: $quantity, '
       'color: $color, '
       'size: $size, '
       'orderType: $orderType, '
       'createdAt: $createdAt, '
       'updatedAt: $updatedAt, '
       'total: $total' '}';
  }

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Products.fromJson(json['product']) : null;
    example = json['example'];
    name = json['name'];
    logo = json['logo'];
    image = json['image'];
    customImage = json['custom_image'];
    printType = json['printtype'];
    sizeDirection = json['sizedirection'] != null
        ? List<int>.from(json['sizedirection'])
        : null;
    model = json['model'];
    material = json['material'];
    number = json['number'];
    printColor = json['print_color'];
    quantity = json['quantity'];
    color = json['color'] != null ? ProductsColors.fromJson(json['color']) : null;
    size = json['size'] != null ? Sizes.fromJson(json['size']) : null;
    orderType = json['order_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['example'] = example;
    data['name'] = name;
    data['logo'] = logo;
    data['image'] = image;
    data['custom_image'] = customImage;
    data['printtype'] = printType;
    if (sizeDirection != null) {
      data['sizedirection'] = sizeDirection;
    }
    data['model'] = model;
    data['material'] = material;
    data['number'] = number;
    data['print_color'] = printColor;
    data['quantity'] = quantity;
    if (color != null) {
      data['color'] = color!.toJson();
    }
    if (size != null) {
      data['size'] = size!.toJson();
    }
    data['order_type'] = orderType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total'] = total;
    return data;
  }
}




class Colors {
  int? id;
  String? colorName;
  String? colorCode;
  List<Images>? images;
  String? colorImage;

  Colors(
      {this.id, this.colorName, this.colorCode, this.images, this.colorImage});

  Colors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colorName = json['color_name'];
    colorCode = json['color_code'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    colorImage = json['color_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['color_name'] = colorName;
    data['color_code'] = colorCode;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['color_image'] = colorImage;
    return data;
  }
}

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

class Color {
  int? id;
  String? colorName;
  String? colorCode;
  List<Images>? images;

  Color({this.id, this.colorName, this.colorCode, this.images});

  Color.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colorName = json['color_name'];
    colorCode = json['color_code'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['color_name'] = colorName;
    data['color_code'] = colorCode;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  int? id;
  String? productId;
  String? sizeCode;
  String? basicPrice;
  String? discountRate;
  String? discountPrice;

  Size(
      {this.id,
        this.productId,
        this.sizeCode,
        this.basicPrice,
        this.discountRate,
        this.discountPrice});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    sizeCode = json['size_code'];
    basicPrice = json['basic_price'];
    discountRate = json['discount_rate'];
    discountPrice = json['discount_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['size_code'] = sizeCode;
    data['basic_price'] = basicPrice;
    data['discount_rate'] = discountRate;
    data['discount_price'] = discountPrice;
    return data;
  }
}