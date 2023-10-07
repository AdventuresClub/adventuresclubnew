import 'package:adventuresclub/models/services/service_image_model.dart';

class UpcomingRequestsModel {
  int BookingId;
  int serviceId;
  int providerId;
  int servicePlan;
  String country;
  String currency;
  String region;
  String adventureName;
  String pName;
  String height;
  String weight;
  String hC;
  String bDate;
  String aDate;
  int adult;
  int kids;
  String uCost;
  String tCost;
  String dAmount;
  String pChanel;
  String status;
  String pStatus;
  int points;
  String des;
  String registration;
  List<ServiceImageModel> sImage;
  UpcomingRequestsModel(
      this.BookingId,
      this.serviceId,
      this.providerId,
      this.servicePlan,
      this.country,
      this.currency,
      this.region,
      this.adventureName,
      this.pName,
      this.height,
      this.weight,
      this.hC,
      this.bDate,
      this.aDate,
      this.adult,
      this.kids,
      this.uCost,
      this.tCost,
      this.dAmount,
      this.pChanel,
      this.status,
      this.pStatus,
      this.points,
      this.des,
      this.registration,
      this.sImage);
}
