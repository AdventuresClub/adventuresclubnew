import 'package:app/models/services/service_image_model.dart';

class GetFavouriteModel {
  int serviceId;
  int providerId;
  String adventureName;
  String costInc;
  String currency;
  String providerName;
  String providerProfile;
  List<ServiceImageModel> sm;
  dynamic stars;
  GetFavouriteModel(
      this.serviceId,
      this.providerId,
      this.adventureName,
      this.costInc,
      this.currency,
      this.providerName,
      this.providerProfile,
      this.sm,
      this.stars);
}
