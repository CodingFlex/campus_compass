// preview_widget.dart
import 'package:campus_compass/ui/map2/turn_by_turn.dart';
import 'package:campus_compass/ui/map2/widgets/trip_type_button.dart';
import 'package:campus_compass/utils/widgets/box_button.dart';
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
import 'package:shimmer/shimmer.dart';

import '../../../utils/shared/text_styles.dart';
import '../../../utils/widgets/box_input_field.dart';
import '../map_viewmodel.dart';

class RouteWidget extends StatelessWidget {
  final bool? isExpanded;
  final MapViewModel model;

  RouteWidget({
    Key? key,
    this.isExpanded,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Text(
            model.destLocation.text,
            style: headlineStyle.copyWith(color: Colors.black, fontSize: 22),
          ),
          Text(
            model.destInfo.toString(),
            style: subheadingStyle,
          ),
          Container(
              width: MediaQuery.sizeOf(context).width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kcLightGreyColor,
              ),
              child: model.tripDetails?.durationText != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TripTypeButton(icon: FontAwesomeIcons.walking),
                          Column(
                            children: [
                              Text('Trip Duration',
                                  style: bodyStyle.copyWith(
                                      fontWeight: FontWeight.w700)),
                              Text(model.tripDetails!.durationText.toString(),
                                  style: heading3Style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 2, // Adjust this to make the dash slimmer
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(
                                  2), // Adjust this for rounded corners
                            ),
                          ),
                          Column(
                            children: [
                              Text('Trip Distance',
                                  style: bodyStyle.copyWith(
                                      fontWeight: FontWeight.w700)),
                              Text(model.tripDetails!.distanceText.toString(),
                                  style: heading3Style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            'Fetching Route Details',
                            style: bodyStyle,
                          ),
                          verticalSpaceSmall,
                          LinearProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kcPrimaryColor),
                          ),
                        ],
                      ),
                    )),
          const Gap(2),
          BoxButton(
              leading: Icon(
                FontAwesomeIcons.locationArrow,
                color: Colors.white,
              ),
              title: 'Start Navigation',
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: model.tripDetails?.durationText != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return TurnByTurn(
                            source: model.startTripLatLng,
                            destination: model.destTripLatLng,
                          );
                        }),
                      );
                    }
                  : null),
        ],
      ),
    );
  }
}
