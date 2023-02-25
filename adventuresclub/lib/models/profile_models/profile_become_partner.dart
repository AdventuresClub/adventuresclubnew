class ProfileBecomePartner {
  int id;
  int userId;
  String companyName;
  String address;
  String location;
  String description;
  String license;
  String crName;
  String crNumber;
  String crCopy;
  int debitCard;
  int visaCard;
  String payOnArrival;
  String paypal;
  String bankName;
  String accountHoldername;
  String accountNumber;
  String isOnline;
  String isApproved;
  int packagesId;
  dynamic startDate;
  dynamic endDate;
  String isWiretransfer;
  String isFreeUsed;
  String ca;
  String ua;
  ProfileBecomePartner(
      this.id,
      this.userId,
      this.companyName,
      this.address,
      this.location,
      this.description,
      this.license,
      this.crName,
      this.crNumber,
      this.crCopy,
      this.debitCard,
      this.visaCard,
      this.payOnArrival,
      this.paypal,
      this.bankName,
      this.accountHoldername,
      this.accountNumber,
      this.isOnline,
      this.isApproved,
      this.packagesId,
      this.startDate,
      this.endDate,
      this.isWiretransfer,
      this.isFreeUsed,
      this.ca,
      this.ua);
}
