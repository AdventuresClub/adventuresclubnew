class ServiceTypeFilterModel {
  int id;
  String type;
  String image;
  int status;
  String ca;
  String ua;
  dynamic da;
  bool? showServiceFilter= false;
  ServiceTypeFilterModel(
      this.id, this.type, this.image, this.status, this.ca, this.ua, this.da , );
}
