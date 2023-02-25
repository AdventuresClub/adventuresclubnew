import 'package:adventuresclub/models/packages_become_partner/bp_excluded_model.dart';
import 'package:adventuresclub/models/packages_become_partner/bp_includes_model.dart';

class PackagesBecomePartnerModel {
  int id;
  String title;
  String symbol;
  String duration;
  String cost;
  int days;
  int status;
  String ca;
  String ua;
  String da;
  List<BpIncludesModel> im;
  List<BpExcludesModel> em;
  PackagesBecomePartnerModel(
      this.id,
      this.title,
      this.symbol,
      this.duration,
      this.cost,
      this.days,
      this.status,
      this.ca,
      this.ua,
      this.da,
      this.im,
      this.em);
}
