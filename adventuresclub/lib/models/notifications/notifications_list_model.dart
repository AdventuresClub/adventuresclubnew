class NotificationsListModel {
  int id;
  int senderId;
  int userId;
  String title;
  String message;
  String isApproved;
  String isRead;
  String notificationsType;
  String ca;
  String raed;
  String sendAt;
  String ua;
  String senderImage;
  NotificationsListModel(
      this.id,
      this.senderId,
      this.userId,
      this.title,
      this.message,
      this.isApproved,
      this.isRead,
      this.notificationsType,
      this.ca,
      this.raed,
      this.sendAt,
      this.ua,
      this.senderImage);
}
