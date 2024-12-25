import 'package:app/models/getReviews/review_user_data_model.dart';

class LocationReviewModel {
  String id;
  String userId;
  String rating;
  String ratingDescription;
  ReviewUserDataModel rdm;
  int count;
  LocationReviewModel(this.id, this.userId, this.rating, this.ratingDescription,
      this.rdm, this.count);
}
