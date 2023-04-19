class ConstantsCreateNewServices {
  static String selectedRegion = "";
  static int selectedRegionId = 0;
  static String adventureName = "";
  static int selectedCategoryId = 0;
  static String selectedCategory = "";
  static String selectedSector = "";
  static int selectedSectorId = 0;
  static int serviceTypeId = 0;
  static String selectedServiceType = "";
  static int selectedDurationId = 0;
  static String selectedDuration = "";
  static int selectedlevelId = 0;
  static String selectedlevel = "";
  static String startDate = "";
  static String endDate = "";
  static int number = 0;
  static List<String> selectedActivites = [];
  static List<int> selectedActivitesId = [];
  static String gatheringDate = "";
  static double lat = 0;
  static double lng = 0;
  static bool particularWeekDays = false;

  static void clearAll() {
    selectedActivitesId.clear();
    startDate = "";
    endDate = "";
    selectedRegionId = 0;
    selectedSectorId = 0;
    selectedCategoryId = 0;
    serviceTypeId = 0;
    selectedDurationId = 0;
    selectedlevelId = 0;
    lat = 0;
    lng = 0;
  }
}
