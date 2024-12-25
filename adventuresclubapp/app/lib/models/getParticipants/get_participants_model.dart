import 'package:app/models/services/service_image_model.dart';

class GetParticipantsModel {
  int bookingId;
  int bookingUser;
  int providerId;
  String providerProfile;
  String email;
  int nationalityId;
  int ownerId;
  int serviceId;
  String healthConditions;
  String country;
  String region;
  String adventureName;
  String providerName;
  String customer;
  String serviceDate;
  String bookedOn;
  int adult;
  int kids;
  String unitCost;
  String totalCost;
  String discountedAmount;
  String paymentChannel;
  String currency;
  String dob;
  String height;
  String weight;
  String message;
  String bookingStatus;
  String status;
  String category;
  String nationality;
  List<ServiceImageModel> sm;
  GetParticipantsModel(
    this.bookingId,
    this.bookingUser,
    this.providerId,
    this.providerProfile,
    this.email,
    this.nationalityId,
    this.ownerId,
    this.serviceId,
    this.healthConditions,
    this.country,
    this.region,
    this.adventureName,
    this.providerName,
    this.customer,
    this.serviceDate,
    this.bookedOn,
    this.adult,
    this.kids,
    this.unitCost,
    this.totalCost,
    this.discountedAmount,
    this.paymentChannel,
    this.currency,
    this.dob,
    this.height,
    this.weight,
    this.message,
    this.bookingStatus,
    this.status,
    this.category,
    this.nationality,
    this.sm,
  );
}
