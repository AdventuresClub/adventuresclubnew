import 'package:adventuresclub/models/getReviews/user_data_model.dart';

class ReviewModel {
  int id;
  int serviceId;
  int userId;
  int star;
  String remarks;
  int status;
  String ca;
  String up;
  List<UserDataModel> um;
  int count;
  ReviewModel(this.id, this.serviceId, this.userId, this.star, this.remarks,
      this.status, this.ca, this.up, this.um, this.count);
}
