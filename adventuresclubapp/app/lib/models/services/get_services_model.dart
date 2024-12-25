import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/availability_model.dart';
import 'package:app/models/services/booking_data_model.dart';
import 'package:app/models/services/create_services/availability_plan_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/models/services/included_activities_model.dart';
import 'package:app/models/services/manish_model.dart';
import 'package:app/models/services/service_image_model.dart';

import '../filter_data_model/programs_model.dart';

class GetServicesModel {
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
  List<AvailabilityModel> availability;
  List<AvailabilityPlanModel> availabilityPlan; // check
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
  String pName;
  String pProfile;
  String thumbnail;
  String rating;
  int reviewedID;
  int isLiked;
  String baseURL;
  List<ServiceImageModel> images;
  List<IncludedActivitiesModel> iA;
  List<DependenciesModel> dependencies;
  List<ProgrammesModel> programmes;
  int stars;
  int bSeats;
  List<AimedForModel> aimedFor;
  int booking;
  List<BookingDataModel> bookingData;
  List<ManishModel> manish;
  int remainingSeats;
  GetServicesModel(
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
      this.pName,
      this.pProfile,
      this.thumbnail,
      this.rating,
      this.reviewedID,
      this.isLiked,
      this.baseURL,
      this.images,
      this.iA,
      this.dependencies,
      this.programmes,
      this.stars,
      this.bSeats,
      this.aimedFor,
      this.booking,
      this.bookingData,
      this.manish,
      this.remainingSeats);
}
