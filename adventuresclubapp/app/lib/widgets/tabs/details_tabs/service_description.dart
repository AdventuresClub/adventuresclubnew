import 'package:app/widgets/tabs/details_tabs/description_activities_widget.dart';
import 'package:app/widgets/tabs/details_tabs/description_aimedFor_widget.dart';
import 'package:app/widgets/tabs/details_tabs/description_components.dart';
import 'package:app/widgets/tabs/details_tabs/description_description.dart';
import 'package:app/widgets/tabs/details_tabs/description_details_widget.dart';
import 'package:app/widgets/tabs/details_tabs/description_information_widget.dart';
import 'package:app/widgets/tabs/details_tabs/description_pricing_widget.dart';
import 'package:app/widgets/tabs/details_tabs/service_schedule_widget.dart';
import 'package:flutter/cupertino.dart';
import '../../../models/home_services/services_model.dart';

class ServiceDescription extends StatelessWidget {
  final ServicesModel gm;
  final List<String> text1;
  final List<String> text4;
  final List<String> text5;
  final List<String> text6;
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
          DescriptionInformationWidget(gm.writeInformation),
          show!
              ? ServiceScheduleWidget(gm.sPlan, gm.programmes)
              : const SizedBox(),
          // // information widget

          DescriptionActivitiesWidget(gm.activityIncludes),
          DescriptionAimedFor(gm.am),
          DescriptionDependency(gm.dependency),
          DescriptionComponents('prerequisites', gm.preRequisites),
          DescriptionComponents('minimumRequirements', gm.mRequirements),
          DescriptionComponents('termsAndConditions', gm.tnc),
        ],
      ),
    );
  }
}
