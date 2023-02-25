import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'become_partner.dart';

class ServicesModel {
  int id;
  int owner;
  String adventureName;
  String country;
  String region;
  String cityId;
  String serviceSector;
  String serviceCategory;
  String serviceType;
  String serviceLevel;
  String duration;
  int aSeats;
  dynamic startDate;
  dynamic endDate;
  String lat;
  String lng;
  String writeInformation;
  int sPlan;
  int sForID;
  List<AvailabilityModel> availability; // check
  String geoLocation;
  String sAddress;
  String costInc;
  String costExc;
  String currency;
  int points;
  String preRequisites;
  String mRequirements;
  String tnc;
  int recommended;
  String status;
  String image;
  String des;
  String fImage;
  String ca;
  String upda;
  String da;
  int providerId;
  int serviceId; // new addition
  String pName;
  String pProfile;
  String iaot; // new
  String eaot; // new
  List<BecomePartner> bp; // new
  List<AimedForModel> am; // new
  String stars;
  int isLiked;
  String baseURL;
  List<ServiceImageModel> images;
  ServicesModel(
    this.id,
    this.owner,
    this.adventureName,
    this.country,
    this.region,
    this.cityId,
    this.serviceSector,
    this.serviceCategory,
    this.serviceType,
    this.serviceLevel,
    this.duration,
    this.aSeats,
    this.startDate,
    this.endDate,
    this.lat,
    this.lng,
    this.writeInformation,
    this.sPlan,
    this.sForID,
    this.availability,
    this.geoLocation,
    this.sAddress,
    this.costInc,
    this.costExc,
    this.currency,
    this.points,
    this.preRequisites,
    this.mRequirements,
    this.tnc,
    this.recommended,
    this.status,
    this.image,
    this.des,
    this.fImage,
    this.ca,
    this.upda,
    this.da,
    this.providerId,
    this.serviceId,
    this.pName,
    this.pProfile,
    this.iaot,
    this.eaot,
    this.bp,
    this.am,
    this.stars,
    this.isLiked,
    this.baseURL,
    this.images,
  );
}
