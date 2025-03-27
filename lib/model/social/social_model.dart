class Social {
  int? id;
  String? socialLink;
  int? socialStatus;
  String? socialIcon;

  Social({this.id, this.socialLink, this.socialStatus, this.socialIcon});

  Social.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialLink = json['social_link'];
    socialStatus = json['social_status'];
    socialIcon = json['social_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['social_link'] = this.socialLink;
    data['social_status'] = this.socialStatus;
    data['social_icon'] = this.socialIcon;
    return data;
  }
}