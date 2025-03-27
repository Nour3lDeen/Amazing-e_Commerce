class SettingsModel {
  int? id;
  String? companyNameAr;
  String? companyNameEn;
  String? cod;
  String? onlinePayment;
  String? bankTransfer;
  String? description;
  String? maintenanceMode;
  String? maintenanceModeEndDate;
  String? maintenanceModeEndTime;
  String? mainLogo;
  String? secondaryLogo;
  int? returnedDayCount;
  int? returnedWalletDayCount;
  int? returnedPercentage;
  int? taxPercentage;
  String? returnedWalletStatus;
  String? returnedNormalStatus;

  SettingsModel(
      {this.id,
        this.companyNameAr,
        this.companyNameEn,
        this.cod,
        this.onlinePayment,
        this.bankTransfer,
        this.description,
        this.maintenanceMode,
        this.maintenanceModeEndDate,
        this.maintenanceModeEndTime,
        this.mainLogo,
        this.secondaryLogo,
        this.returnedDayCount,
        this.returnedWalletDayCount,
        this.returnedPercentage,
        this.taxPercentage,
        this.returnedWalletStatus,
        this.returnedNormalStatus});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyNameAr = json['company_name_ar'];
    companyNameEn = json['company_name_en'];
    cod = json['cod'];
    onlinePayment = json['online_payment'];
    bankTransfer = json['bank_transfer'];
    description = json['description'];
    maintenanceMode = json['maintenance_mode'];
    maintenanceModeEndDate = json['maintenance_mode_end_date'];
    maintenanceModeEndTime = json['maintenance_mode_end_time'];
    mainLogo = json['main_logo'];
    secondaryLogo = json['scoendary_logo'];
    returnedDayCount = json['returned_day_count'];
    returnedWalletDayCount = json['returned_wallet_day_count'];
    returnedPercentage = json['returned_percentage'];
    taxPercentage = json['tax_percentage'];
    returnedWalletStatus = json['returned_wallet_status'];
    returnedNormalStatus = json['returned_normal_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name_ar'] = this.companyNameAr;
    data['company_name_en'] = this.companyNameEn;
    data['cod'] = this.cod;
    data['online_payment'] = this.onlinePayment;
    data['bank_transfer'] = this.bankTransfer;
    data['description'] = this.description;
    data['maintenance_mode'] = this.maintenanceMode;
    data['maintenance_mode_end_date'] = this.maintenanceModeEndDate;
    data['maintenance_mode_end_time'] = this.maintenanceModeEndTime;
    data['main_logo'] = this.mainLogo;
    data['scoendary_logo'] = this.secondaryLogo;
    data['returned_day_count'] = this.returnedDayCount;
    data['returned_wallet_day_count'] = this.returnedWalletDayCount;
    data['returned_percentage'] = this.returnedPercentage;
    data['tax_percentage'] = this.taxPercentage;
    data['returned_wallet_status'] = this.returnedWalletStatus;
    data['returned_normal_status'] = this.returnedNormalStatus;
    return data;
  }
}