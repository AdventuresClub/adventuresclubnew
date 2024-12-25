class ServiceImageModel {
  int id;
  int serviceId;
  int isDefault;
  String imageUrl;
  String thumbnail;
  ServiceImageModel(
      this.id, this.serviceId, this.isDefault, this.imageUrl, this.thumbnail);
}
