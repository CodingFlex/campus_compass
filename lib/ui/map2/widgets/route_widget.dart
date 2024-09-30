// preview_widget.dart
import 'package:campus_compass/ui/map2/turn_by_turn.dart';
import 'package:campus_compass/ui/map2/widgets/trip_type_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';

import '../../../utils/shared/text_styles.dart';
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
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis)),
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
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis)),
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
          GestureDetector(
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
                : null,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (model.tripDetails?.durationText != null ||
                        model.tripDetails?.durationText != null)
                    ? kcPrimaryColor
                    : kcMediumGreyColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.arrowUp,
                    color: Colors.white,
                  ),
                  Gap(5),
                  Text(
                    'Start Navigation',
                    style: subheadingStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
