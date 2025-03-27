class Countries {
  int? id;
  String? countryName;
  String? countryPhoneCode;
  List<Cities>? cities;

  Countries({this.id, this.countryName, this.countryPhoneCode, this.cities});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    countryPhoneCode = json['country_phone_code'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_name'] = this.countryName;
    data['country_phone_code'] = this.countryPhoneCode;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {

    return 'Countries{id: $id, countryName: $countryName, countryPhoneCode: $countryPhoneCode, cities: $cities}';
  }
}

class Cities {
  int? id;
  int? countryId;
  String? country;
  String? cityName;
  int? shippingAmount;

  Cities(
      {this.id,
      this.countryId,
      this.country,
      this.cityName,
      this.shippingAmount});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    country = json['country'];
    cityName = json['city_name'];
    shippingAmount = json['shipping_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['city_name'] = this.cityName;
    data['shipping_amount'] = this.shippingAmount;
    return data;
  }

  @override
  String toString() {
    return 'Cities{id: $id, countryId: $countryId, country: $country, cityName: $cityName, shippingAmount: $shippingAmount}';
  }
}
