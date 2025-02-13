class Product {
  int? id;
  int? categoryId;
  String? categoryName;
  String? categorySlug;
  String? brandName;
  String? name;
  String? productCode;
  String? description;
  String? slug;
  String? stock;
  String? status;
  String? video;
  String? createdAt;
  String? updatedAt;
  List<Sizes>? sizes;
  List<ProductColors>? colors;

  Product(
      {this.id,
        this.categoryId,
        this.categoryName,
        this.categorySlug,
        this.brandName,
        this.name,
        this.productCode,
        this.description,
        this.slug,
        this.stock,
        this.status,
        this.video,
        this.createdAt,
        this.updatedAt,
        this.sizes,
        this.colors});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    brandName = json['brand_name'];
    name = json['name'];
    productCode = json['product_code'];
    description = json['description'];
    slug = json['slug'];
    stock = json['stock'];
    status = json['status'];
    video = json['video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <ProductColors>[];
      json['colors'].forEach((v) {
        colors!.add(ProductColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_slug'] = categorySlug;
    data['brand_name'] = brandName;
    data['name'] = name;
    data['product_code'] = productCode;
    data['description'] = description;
    data['slug'] = slug;
    data['stock'] = stock;
    data['status'] = status;
    data['video'] = video;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return 'Product{'
        'id: $id, '
        'categoryId: $categoryId, '
        'categoryName: $categoryName, '
        'categorySlug: $categorySlug, '
        'brandName: $brandName, '
        'name: $name, '
        'productCode: $productCode, '
        'description: $description, '
        'slug: $slug, '
        'stock: $stock, '
        'status: $status, '
        'video: $video, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'sizes: $sizes, '
        'colors: $colors' '}';
  }
}

class Sizes {
  int? id;
  String? sizeCode;
  String? basicPrice;
  String? discountRate;
  String? discountPrice;


  Sizes(
      {this.id,
        this.sizeCode,
        this.basicPrice,
        this.discountRate,
        this.discountPrice}
       );

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeCode = json['size_code'];
    basicPrice = json['basic_price'];
    discountRate = json['discount_rate'];
    discountPrice = json['discount_price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['size_code'] = sizeCode;
    data['basic_price'] = basicPrice;
    data['discount_rate'] = discountRate;
    data['discount_price'] = discountPrice;

    return data;
  }
  @override
  String toString() {
    return 'Sizes{id: $id, sizeCode: $sizeCode, basicPrice: $basicPrice, discountRate: $discountRate, discountPrice: $discountPrice}';
  }
}

class ProductColors {
  int? id;
  String? colorName;
  String? colorCode;
  List<Images>? images;
  String? colorImage;

  ProductColors(
      {this.id, this.colorName, this.colorCode, this.images, this.colorImage});

  ProductColors.fromJson(Map<String, dynamic> json) {
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
  @override
  toString() {
    return 'ProductColors{id: $id, colorName: $colorName, colorCode: $colorCode, images: $images, colorImage: $colorImage}';
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