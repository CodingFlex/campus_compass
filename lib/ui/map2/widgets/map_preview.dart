// preview_widget.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/ui/map/divider.dart';
import 'package:campus_compass/ui/map2/widgets/map_textfield.dart';
import 'package:campus_compass/ui/map2/widgets/place_button.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:campus_compass/utils/widgets/box_text.dart';

import '../../../utils/shared/text_styles.dart';
import '../../../utils/widgets/box_input_field.dart';
import '../map_viewmodel.dart';

class PreviewWidget extends StatelessWidget {
  final bool? isExpanded;
  String? address;
  String? name;

  PreviewWidget({
    Key? key,
    this.isExpanded,
    this.address,
    this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => MapViewModel(),
      builder: (context, model, child) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: kcLightGreyColor,
                  borderRadius:
                      BorderRadius.circular(12), // Adjust the radius as needed
                ),
              ),
            ),
            verticalSpaceSmall,
            Text(
              'Hey $name, where would you like to go?',
              style: headlineStyle.copyWith(fontSize: 19, color: Colors.black),
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.person,
                      color: kcPrimaryColor,
                    )),
                Flexible(
                  child: Text(
                    address != null
                        ? 'Current location: $address'
                        : 'Loading...',
                    style: headlineStyle.copyWith(
                      fontSize: 16,
                      color: kcPrimaryColor,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.my_location,
                            color: kcPrimaryColor,
                          ),
                        ),
                        const Gap(3),
                        Container(
                          height: 8,
                          width: 2, // Adjust this to make the dash slimmer
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                                2), // Adjust this for rounded corners
                          ),
                        ),
                        const Gap(3),
                        Container(
                          height: 8,
                          width: 2, // Adjust this to make the dash slimmer
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                                2), // Adjust this for rounded corners
                          ),
                        ),
                        const Gap(3),
                        Container(
                          height: 8,
                          width: 2, // Adjust this to make the dash slimmer
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                                2), // Adjust this for rounded corners
                          ),
                        ),
                        const Gap(3),
                        const Icon(
                          Icons.location_on_outlined,
                          color: kcPrimaryColor,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      MapTextField(isDestination: false, model: model),
                      verticalSpaceRegular,
                      MapTextField(isDestination: true, model: model)
                    ],
                  ),
                ],
              ),
            ),
            verticalSpaceRegular,
            model.isLoading
                ? const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kcPrimaryColor),
                  )
                : Container(),
            (model.placePredictionList.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return PlaceButton(
                          placePredictions: model.placePredictionList[index],
                          isDestination: model.isResponseForDestination,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          DividerWidget(),
                      itemCount: model.placePredictionList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
