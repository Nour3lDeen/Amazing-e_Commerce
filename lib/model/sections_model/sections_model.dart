class Section {
  int? id;
  String? name;
  String? description;
  String? status;
  String? media;
  List<Categories>? categories;

  Section(
      {this.id,
        this.name,
        this.description,
        this.status,
        this.media,
        this.categories});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    media = json['media'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['media'] = media;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return 'Section{id: $id, name: $name, description: $description, status: $status, media: $media, categories: $categories}';
  }
}

class Categories {
  int? id;
  String? sectionId;
  String? name;
  String? slug;
  String? description;
  String? status;
  String? media;
  List<Products>? products;

  Categories(
      {this.id,
        this.sectionId,
        this.name,
        this.slug,
        this.description,
        this.status,
        this.media,
        this.products});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    status = json['status'];
    media = json['media'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_id'] = sectionId;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['status'] = status;
    data['media'] = media;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return 'Categories{id: $id, sectionId: $sectionId, name: $name, slug: $slug, description: $description, status: $status, media: $media, products: $products}';
  }
}

class Products {
  int? id;
  int? categoryId;
  String? categoryName;
  String? categorySlug;
  String? brandName;
  String? name;
  String? productCode;
  String? description;
  String? stock;
  String? status;
  String? video;
  String? createdAt;
  String? updatedAt;
  List<Sizes>? sizes;
  List<ProductsColors>? colors;

  Products(
      {this.id,
        this.categoryId,
        this.categoryName,
        this.categorySlug,
        this.brandName,
        this.name,
        this.productCode,
        this.description,
        this.stock,
        this.status,
        this.video,
        this.createdAt,
        this.updatedAt,
        this.sizes,
        this.colors});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    brandName = json['brand_name'];
    name = json['name'];
    productCode = json['product_code'];
    description = json['description'];
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
      colors = <ProductsColors>[];
      json['colors'].forEach((v) {
        colors!.add(ProductsColors.fromJson(v));
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
   return 'Products{id: $id, categoryId: $categoryId, categoryName: $categoryName, categorySlug: $categorySlug, brandName: $brandName, name: $name}';

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
        this.discountPrice,
        });

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

class ProductsColors {
  int? id;
  String? colorName;
  String? colorCode;
  List<Images>? images;
  String? colorImage;

  ProductsColors(
      {this.id, this.colorName, this.colorCode, this.images, this.colorImage});

  ProductsColors.fromJson(Map<String, dynamic> json) {
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
  String toString() {
    // TODO: implement toString
    return 'ProductsColors{id: $id, colorName: $colorName, colorCode: $colorCode, images: $images, colorImage: $colorImage}';
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