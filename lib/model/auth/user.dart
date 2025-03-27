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
  String? wallet;
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
      this.wallet,
      this.addresses});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    status = json['status'];
    wallet = json['wallet'];
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
    data['wallet'] = wallet;
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
    return 'User{id: $id, email: $email, status: $status, wallet: $wallet, createdAt: $createdAt, updatedAt: $updatedAt, '
        'firstName: $firstName, lastName: $lastName, mobile: $mobile, dateOfBirth: $dateOfBirth, gender: $gender, '
        'avatar: $avatar, addresses: $addresses}';
  }
}

class Addresses {
  int? id;
  String? fullName;
  String? name;
  String? description;
  String? mobile;
  String? otherMobile;
  String? country;
  int? countryId;
  String? city;
  int? cityId;
  int? cityShippingAmount;
  String? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
      this.fullName,
      this.name,
      this.description,
      this.mobile,
      this.otherMobile,
      this.country,
      this.countryId,
      this.city,
      this.cityId,
      this.cityShippingAmount,
      this.createdAt,
      this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    name = json['name'];
    description = json['description'];
    mobile = json['mobile'];
    otherMobile = json['other_mobile'];
    country = json['country'];
    countryId = json['country_id'];
    city = json['city'];
    cityId = json['city_id'];
    cityShippingAmount = json['city_shipping_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['name'] = name;
    data['description'] = description;
    data['mobile'] = mobile;
    data['other_mobile'] = otherMobile;
    data['country'] = country;
    data['country_id'] = countryId;
    data['city'] = city;
    data['city_id'] = cityId;
    data['city_shipping_amount'] = cityShippingAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Addresses{id: $id, fullName: $fullName, name: $name, description: $description, '
        'mobile: $mobile, otherMobile: $otherMobile, country: $country, countryId: $countryId, city: $city, cityId: $cityId, cityShippingAmount: $cityShippingAmount, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
