class PrintType {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;

  PrintType({this.id, this.nameAr, this.nameEn, this.price, });

  PrintType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
  }


}