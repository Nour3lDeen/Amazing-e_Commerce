class PrintType {
  int? id;
  String? nameAr;
  String? nameEn;
  int? price;

  PrintType({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
  });

  PrintType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['price'] = this.price;
    return data;
  }
}
