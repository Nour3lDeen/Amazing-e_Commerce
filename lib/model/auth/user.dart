class User {
  int? id;
  String? email;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? mobile;
  String? dateOfBirth;
  String? gender;
  String? avatar;
  List<Addresses>? addresses;

  User(
      {this.id,
        this.email,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.mobile,
        this.dateOfBirth,
        this.gender,
        this.avatar,
        this.addresses});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    avatar = json['avatar'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['avatar'] = avatar;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return 'User{id: $id, email: $email, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, '
        'firstName: $firstName, lastName: $lastName, mobile: $mobile, dateOfBirth: $dateOfBirth, gender: $gender, '
        'avatar: $avatar, addresses: $addresses}';
  }
}

class Addresses {
  int? id;
  String? firstName;
  String? lastName;
  String? name;
  String? description;
  String? mobile;
  String? otherMobile;
  String? countryCode;
  String? city;
  String? street;
  String? build;
  String? floor;
  String? apartment;
  String? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
        this.firstName,
        this.lastName,
        this.name,
        this.description,
        this.mobile,
        this.otherMobile,
        this.countryCode,
        this.city,
        this.street,
        this.build,
        this.floor,
        this.apartment,
        this.createdAt,
        this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    description = json['description'];
    mobile = json['mobile'];
    otherMobile = json['other_mobile'];
    countryCode = json['country_code'];
    city = json['city'];
    street = json['street'];
    build = json['build'];
    floor = json['floor'];
    apartment = json['apartment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['name'] = name;
    data['description'] = description;
    data['mobile'] = mobile;
    data['other_mobile'] = otherMobile;
    data['country_code'] = countryCode;
    data['city'] = city;
    data['street'] = street;
    data['build'] = build;
    data['floor'] = floor;
    data['apartment'] = apartment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

}