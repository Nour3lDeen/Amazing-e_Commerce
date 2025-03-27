class PolicyModel {
  int? id;
  String? title;
  String? policy;
  String? type;
  String? createdAt;
  String? updatedAt;

  PolicyModel(
      {this.id,
        this.title,
        this.policy,
        this.type,
        this.createdAt,
        this.updatedAt});

  PolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    policy = json['policy'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['policy'] = this.policy;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}