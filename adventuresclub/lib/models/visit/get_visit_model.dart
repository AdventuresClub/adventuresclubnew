class GetVisitModel {
  int id;
  int userID;
  String destinationImage;
  String destinationName;
  String destinationType;
  String geoLocation;
  String destinationAdd;
  String destMobile;
  String destWeb;
  String destDes;
  String isApp;
  String lat;
  String lng;
  String ca;
  String ua;
  String da;
  String rS;
  GetVisitModel(
      this.id,
      this.userID,
      this.destinationImage,
      this.destinationName,
      this.destinationType,
      this.geoLocation,
      this.destinationAdd,
      this.destMobile,
      this.destWeb,
      this.destDes,
      this.isApp,
      this.lat,
      this.lng,
      this.ca,
      this.ua,
      this.da,
      this.rS);
}

class GetVisitedTitleModel {
  String title;
  String image;
  GetVisitedTitleModel(
    this.title,
    this.image,
  );
}
