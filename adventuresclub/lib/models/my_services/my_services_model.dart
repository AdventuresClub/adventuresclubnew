import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';

class MyServicesModel {
  int id;
  int owner;
  String adventureName;
  String country;
  String region;
  int cityId;
  String serviceSector;
  String serviceCategory;
  String serviceLevel;
  String duration;
  int availableSeats;
  String startDate;
  String endDate;
  String lat;
  String lng;
  String writeInfo;
  dynamic servicePlan;
  dynamic sForId;
  List<String> availaibility;
  String geoLocation;
  String specificAddress;
  String costInc;
  String costExc;
  String currency;
  int points;
  String preReq;
  String minReq;
  String tnc;
  int recomended;
  int status;
  String image;
  String descreption;
  String favImg;
  String ca;
  String ua;
  dynamic da;
  int serviceId;
  int providerId;
  String providedName;
  String providerProfile;
  String incTaxes;
  String excTaxes;
  List<ServiceImageModel> imageUrl;
  List<AimedForModel> am;
  String cInc;
  String cExc;
  MyServicesModel(
      this.id,
      this.owner,
      this.adventureName,
      this.country,
      this.region,
      this.cityId,
      this.serviceSector,
      this.serviceCategory,
      this.serviceLevel,
      this.duration,
      this.availableSeats,
      this.startDate,
      this.endDate,
      this.lat,
      this.lng,
      this.writeInfo,
      this.servicePlan,
      this.sForId,
      this.availaibility,
      this.geoLocation,
      this.specificAddress,
      this.costInc,
      this.costExc,
      this.currency,
      this.points,
      this.preReq,
      this.minReq,
      this.tnc,
      this.recomended,
      this.status,
      this.image,
      this.descreption,
      this.favImg,
      this.ca,
      this.ua,
      this.da,
      this.serviceId,
      this.providerId,
      this.providedName,
      this.providerProfile,
      this.incTaxes,
      this.excTaxes,
      this.imageUrl,
      this.am,
      this.cInc,
      this.cExc);
}
