import 'package:adventuresclub/models/filter_data_model/activities_inc_model.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/countries_filter.dart';
import 'package:adventuresclub/models/filter_data_model/durations_model.dart';
import 'package:adventuresclub/models/filter_data_model/level_filter_mode.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/service_types_filter.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';

class FilterDataModel {
  List<SectorFilterModel> sm;
  List<CategoryFilterModel> cm;
  List<ServiceTypeFilterModel> sTM;
  List<AimedForModel> am;
  List<CountriesFilterModel> cFM;
  List<LevelFilterModel> lFM;
  List<DurationsModel> dm;
  List<ActivitiesIncludeModel> aIM;
  List<RegionFilterModel> rm;
  FilterDataModel(this.sm, this.cm, this.sTM, this.am, this.cFM, this.lFM,
      this.dm, this.aIM, this.rm);
}
