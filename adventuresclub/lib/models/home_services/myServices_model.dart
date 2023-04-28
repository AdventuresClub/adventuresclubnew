import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import '../services/create_services/availability_plan_model.dart';
import 'become_partner.dart';

class MyServicesModel {
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
  DateTime startDate;
  DateTime endDate;
  String lat;
  String lng;
  String writeInformation;
  int sPlan;
  int sForID;
  dynamic availability; // check
  List<AvailabilityPlanModel> availabilityPlan;
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
  List<IncludedActivitiesModel> activityIncludes;
  List<DependenciesModel> dependency;
  List<BecomePartner> bp; // new
  List<AimedForModel> am; // new
  List<ProgrammesModel> programmes;
  String stars;
  int isLiked;
  String baseURL;
  List<ServiceImageModel> images;
  String rating;
  String reviewdBy;
  int remainingSeats;
  MyServicesModel(
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
    this.availabilityPlan,
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
    this.activityIncludes,
    this.dependency,
    this.bp,
    this.am,
    this.programmes,
    this.stars,
    this.isLiked,
    this.baseURL,
    this.images,
    this.rating,
    this.reviewdBy,
    this.remainingSeats,
  );
}
