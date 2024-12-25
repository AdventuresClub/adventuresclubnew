import 'package:app/models/getReviews/review_model.dart';

class GetReviews {
  int averageRating;
  List<ReviewModel> rm;
  GetReviews(
    this.averageRating,
    this.rm,
  );
}
