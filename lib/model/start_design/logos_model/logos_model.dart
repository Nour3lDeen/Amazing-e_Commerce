class Logos {
  int? id;
  String? price;
  String? image;

  Logos({this.id,  this.price, this.image});

  Logos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
  }

  @override
  String toString() {
    return 'Examples{id: $id, price: $price, media: $image}';}
}
