import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';

class UserProfileModel {
  int id;
  String userRole;
  String profileImage;
  String name;
  String height;
  String weight;
  String email;
  int countryId;
  dynamic regionId;
  dynamic cityId;
  dynamic nowIn;
  String mobile;
  String mobileVerifiedAt;
  String dob;
  String gender;
  int languageId;
  String nationalityId;
  int currencyId;
  dynamic appNotification;
  String points;
  String healthCondtions;
  String healthConditionsId;
  dynamic emailVerified;
  String mobileCode;
  String status;
  int addedFrom;
  String ca;
  String ua;
  String da;
  String deviceId;
  ProfileBecomePartner bp;
  UserProfileModel(
      this.id,
      this.userRole,
      this.profileImage,
      this.name,
      this.height,
      this.weight,
      this.email,
      this.countryId,
      this.regionId,
      this.cityId,
      this.nowIn,
      this.mobile,
      this.mobileVerifiedAt,
      this.dob,
      this.gender,
      this.languageId,
      this.nationalityId,
      this.currencyId,
      this.appNotification,
      this.points,
      this.healthCondtions,
      this.healthConditionsId,
      this.emailVerified,
      this.mobileCode,
      this.status,
      this.addedFrom,
      this.ca,
      this.ua,
      this.da,
      this.deviceId,
      this.bp);
}
