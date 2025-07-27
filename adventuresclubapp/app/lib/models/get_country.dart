class GetCountryModel {
  String country;
  String shortName;
  String flag;
  dynamic code;
  int id;
  String currency;
  dynamic serviceCount;
  String? maxPrice;
  GetCountryModel(this.country, this.shortName, this.flag, this.code, this.id,
      this.currency,
      {this.serviceCount, this.maxPrice});
}
