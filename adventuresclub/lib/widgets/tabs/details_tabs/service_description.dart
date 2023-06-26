import 'package:adventuresclub/widgets/tabs/details_tabs/description_activities_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_aimedFor_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_components.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_description.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_details_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_information_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_pricing_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_schedule_widget.dart';
import 'package:flutter/cupertino.dart';
import '../../../models/home_services/services_model.dart';

class ServiceDescription extends StatelessWidget {
  final ServicesModel gm;
  final List<dynamic> text1;
  final List<dynamic> text4;
  final List<dynamic> text5;
  final List<dynamic> text6;
  final double stars;
  final String reviewedBy;
  final String id;
  final bool? show;
  const ServiceDescription(this.gm, this.text1, this.text4, this.text5,
      this.text6, this.stars, this.reviewedBy, this.id,
      {this.show = false, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          show == false
              ? DescriptionPricingWidget(
                  gm.adventureName, gm.costInc, gm.currency, gm.costExc)
              : Container(),
          // location etc
          DescriptionDetailsWidget(
              text1, text4, text5, text6, stars, reviewedBy, id, gm),
          show!
              ? ServiceScheduleWidget(gm.sPlan, gm.programmes)
              : const SizedBox(),
          // // information widget
          DescriptionInformationWidget(gm.writeInformation),
          DescriptionActivitiesWidget(gm.activityIncludes),
          DescriptionAimedFor(gm.am),
          DescriptionDependency(gm.dependency),
          DescriptionComponents('Pre-requisites', gm.preRequisites),
          DescriptionComponents('Minimum Requirement', gm.mRequirements),
          DescriptionComponents('Terms & Conditions', gm.tnc),
        ],
      ),
    );
  }
}
