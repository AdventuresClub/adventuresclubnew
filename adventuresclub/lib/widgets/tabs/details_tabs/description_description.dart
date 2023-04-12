import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DescriptionDependency extends StatelessWidget {
  final List<DependenciesModel> dm;
  const DescriptionDependency(this.dm, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                text: 'Dependency',
                color: greyTextColor,
                weight: FontWeight.w500,
                fontFamily: 'Roboto',
                size: 14,
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              children: List.generate(dm.length,
                  //widget.gm.dependencies.length,

                  (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      if (dm[index].name.isEmpty)
                        const Icon(
                          Icons.power_input,
                          size: 20,
                        ),
                      if (dm[index].name.isNotEmpty)
                        Image.network(
                          "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${dm[index].name}",
                          height: 18,
                          width: 18,
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        text: dm[index].dName,
                        //text: aimedFor[index],
                        color: greyColor2,
                        weight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        size: 12,
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
