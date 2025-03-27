class SliderModel {
  int? id;
  String? media;

  SliderModel({this.id, this.media});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media'] = this.media;
    return data;
  }
}