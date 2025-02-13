class Examples {
  int? id;
  String? name;
  String? price;
  String? media;

  Examples({this.id, this.name, this.price, this.media});

  Examples.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['media'] = media;
    return data;
  }
  @override
  String toString() {
    return 'Examples{id: $id, name: $name, price: $price, media: $media}';}
}
