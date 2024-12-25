// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:app/models/filter_data_model/level_filter_mode.dart';
import 'package:app/models/filter_data_model/sector_filter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/filter_data_model/activities_inc_model.dart';
import '../models/filter_data_model/category_filter_model.dart';
import '../models/filter_data_model/countries_filter.dart';
import '../models/filter_data_model/durations_model.dart';
import '../models/filter_data_model/filter_data_model.dart';
import '../models/filter_data_model/region_model.dart';
import '../models/filter_data_model/service_types_filter.dart';
import '../models/services/aimed_for_model.dart';

class FilterProvider with ChangeNotifier {
  Map mapFilter = {};
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<ServiceTypeFilterModel> serviceFilter = [];
  List<CountriesFilterModel> countriesFilter = [];
  List<LevelFilterModel> levelFilter = [];
  List<DurationsModel> durationFilter = [];
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<RegionFilterModel> regionFilter = [];
  List<AimedForModel> aimedFilter = [];
  List<FilterDataModel> fDM = [];
  List<AimedForModel> am = [];

  void getFilter() async {
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/filter_modal_data"));
    if (response.statusCode == 200) {
      mapFilter = json.decode(response.body);
      dynamic result = mapFilter['data'];
      List<dynamic> sectorData = result['sectors'];
      sectorData.forEach((data) {
        SectorFilterModel sm = SectorFilterModel(
          int.tryParse(data['id'].toString()) ?? 0,
          data['sector'],
          data['image'],
          int.tryParse(data['status'].toString()) ?? 0,
          data['created_at'],
          data['updated_at'],
          data['deleted_at'] ?? "",
        );
        filterSectors.add(sm);
      });
      List<dynamic> cat = result['categories'];
      cat.forEach((cateGory) {
        int c = int.tryParse(cateGory['id'].toString()) ?? 0;
        CategoryFilterModel cm = CategoryFilterModel(
          c,
          cateGory['category'],
          cateGory['image'],
          cateGory['status'],
          cateGory['created_at'],
          cateGory['updated_at'],
          cateGory['deleted_at'] ?? "",
        );
        categoryFilter.add(cm);
      });
      List<dynamic> serv = result['service_types'];
      serv.forEach((type) {
        ServiceTypeFilterModel st = ServiceTypeFilterModel(
          int.tryParse(type['id'].toString()) ?? 0,
          type['type'],
          type['image'],
          int.tryParse(type['status'].toString()) ?? 0,
          type['created_at'],
          type['updated_at'],
          type['deleted_at'] ?? "",
        );
        serviceFilter.add(st);
      });
      //List<dynamic> aimedF = result['aimed_for'];
      List<dynamic> count = result['countries'];
      count.forEach((country) {
        int cb = int.tryParse(country['created_by'].toString()) ?? 0;
        CountriesFilterModel cf = CountriesFilterModel(
          int.tryParse(country['id'].toString()) ?? 0,
          country['country'],
          country['short_name'],
          country['code'],
          country['currency'],
          country['description'] ?? "",
          country['flag'],
          country['status'],
          cb,
          country['created_at'],
          country['updated_at'],
          country['deleted_at'] ?? "",
        );
        countriesFilter.add(cf);
      });
      List<dynamic> lev = result['levels'];
      lev.forEach((level) {
        LevelFilterModel lm = LevelFilterModel(
          int.tryParse(level['id'].toString()) ?? 0,
          level['level'],
          level['image'],
          level['status'],
          level['created_at'],
          level['updated_at'],
          level['deleted_at'] ?? "",
        );
        levelFilter.add(lm);
      });
      List<dynamic> d = result['durations'];
      d.forEach((dur) {
        int id = int.tryParse(dur['id'].toString()) ?? 0;
        DurationsModel dm = DurationsModel(id, dur['duration'].toString());
        durationFilter.add(dm);
      });
      List<dynamic> a = result['activities_including'];
      a.forEach((act) {
        int id = int.tryParse(act['id'].toString()) ?? 0;
        ActivitiesIncludeModel activities = ActivitiesIncludeModel(
            id, act['activity'].toString(), act['images'] ?? "");
        activitiesFilter.add(activities);
      });
      List<dynamic> r = result['regions'];
      r.forEach((reg) {
        int id = int.tryParse(reg['id'].toString()) ?? 0;
        RegionFilterModel rm = RegionFilterModel(id, reg['region']);
        regionFilter.add(rm);
      });
      FilterDataModel fm = FilterDataModel(
          filterSectors,
          categoryFilter,
          serviceFilter,
          am,
          countriesFilter,
          levelFilter,
          durationFilter,
          activitiesFilter,
          regionFilter);
      fDM.add(fm);
      // parseService(serviceFilter);
      // parseDuration(durationFilter);
      // parseLevel(levelFilter);
      // parseCategories(categoryFilter);
    }
    notifyListeners();
  }
}
