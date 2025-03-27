import '../sections_model/sections_model.dart';

class SeasonModel {
  int? id;
  String? name;
  String? color;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? icon;

  SeasonModel(
      {this.id,
        this.name,
        this.color,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.icon,
        });

  SeasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['icon'] = this.icon;

    return data;
  }
  @override
  String toString() {
    return 'SeasonModel{id: $id, name: $name, color: $color, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, icon: $icon}';
  }
}


