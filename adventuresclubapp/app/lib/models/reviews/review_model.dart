import 'package:app/models/reviews/review_user_data.dart';

class ReviewModel {
  String locationId;
  String userId;
  String rating;
  String ratingDescription;
  List<ReviewUserData> userData;
  int count;
  ReviewModel(this.locationId, this.userId, this.rating, this.ratingDescription,
      this.userData, this.count);
}
