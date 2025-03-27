import '../sections_model/sections_model.dart';

class BrandModel {
  int? id;
  String? name;
  String? status;
  String? brand;
  List<Products>? products;

  BrandModel({this.id, this.name, this.status, this.brand, this.products});

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    brand = json['brand'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['brand'] = this.brand;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'BrandModel{id: $id, name: $name, status: $status, brand: $brand, products: $products}';
  }
}
