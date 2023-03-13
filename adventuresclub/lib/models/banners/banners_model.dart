class BannersModel {
  int serviceId;
  int countryId;
  String name;
  String startDate;
  String endDate;
  String discountType;
  int discountAmount;
  String banner;
  int status;
  String ca;
  String ua;
  dynamic da;
  BannersModel(
      this.serviceId,
      this.countryId,
      this.name,
      this.startDate,
      this.endDate,
      this.discountType,
      this.discountAmount,
      this.banner,
      this.status,
      this.ca,
      this.ua,
      this.da);
}
