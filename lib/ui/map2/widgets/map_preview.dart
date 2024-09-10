// preview_widget.dart
import 'package:campus_compass/ui/map2/widgets/divider.dart';
import 'package:campus_compass/ui/map2/widgets/route_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/constants/assets.dart';

import 'package:campus_compass/ui/map2/widgets/map_textfield.dart';
import 'package:campus_compass/ui/map2/widgets/place_button.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:campus_compass/utils/widgets/box_text.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/shared/text_styles.dart';
import '../../../utils/widgets/box_input_field.dart';
import '../map_viewmodel.dart';

class PreviewWidget extends StatelessWidget {
  final bool? isExpanded;
  final MapViewModel model;

  PreviewWidget({
    Key? key,
    this.isExpanded,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !model.isLoadingRouteDetails
        ? Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: kcLightGreyColor,
                        borderRadius: BorderRadius.circular(
                            12), // Adjust the radius as needed
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  RichText(
                    text: TextSpan(
                      style: headlineStyle.copyWith(
                          fontSize: 17.sp, color: Colors.black),
                      children: [
                        const TextSpan(text: 'Hey '),
                        WidgetSpan(
                          child: Shimmer.fromColors(
                            baseColor: Colors.black,
                            highlightColor: Color.fromARGB(255, 230, 185, 237),
                            enabled: model.name == null,
                            child: Text(
                              model.name ?? '...',
                              style: headlineStyle.copyWith(
                                  color: Colors.black, fontSize: 17.sp),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: ', where to?',
                        ),
                      ],
                    ),
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
                        child: SizedBox(
                          child: Shimmer.fromColors(
                            baseColor: Colors.black,
                            direction: ShimmerDirection.rtl,
                            highlightColor: Color.fromARGB(255, 230, 185, 237),
                            enabled: model.userAddress == null,
                            child: Text(
                              'Current location: ${model.userAddress ?? 'Loading...'}',
                              style: headlineStyle.copyWith(
                                fontSize: 16.sp,
                                color: kcPrimaryColor,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpaceSmall,
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: kcPrimaryColor.withOpacity(
                                          0.2), // Adjust opacity as needed
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      50), // Adjust as needed
                                ),
                                child: GestureDetector(
                                  onTap: () => model.useCurrentLocation(),
                                  child: const Icon(
                                    Icons.my_location,
                                    color: kcPrimaryColor,
                                  ),
                                ),
                              ),
                              const Gap(3),
                              Container(
                                height: 10,
                                width:
                                    2, // Adjust this to make the dash slimmer
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(
                                      2), // Adjust this for rounded corners
                                ),
                              ),
                              const Gap(3),
                              Container(
                                height: 10,
                                width:
                                    2, // Adjust this to make the dash slimmer
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(
                                      2), // Adjust this for rounded corners
                                ),
                              ),
                              const Gap(3),
                              Container(
                                height: 10,
                                width:
                                    2, // Adjust this to make the dash slimmer
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
                            MapTextField(isDestination: true, model: model),
                          ],
                        ),
                      ],
                    ),
                  ),
                  (model.showProceedButton)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 45),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                print('tapping');
                                print(model.initialPosition.toString());
                                print(model.finalPosition.toString());
                                if (model.initialPosition != null &&
                                    model.finalPosition != null &&
                                    model.initialPosition!.latitude != null &&
                                    model.initialPosition!.longitude != null &&
                                    model.finalPosition!.latitude != null &&
                                    model.finalPosition!.longitude != null) {
                                  model.getPlaceDirection(
                                    model.initialPosition!,
                                    model.finalPosition!,
                                  );
                                  model.isRouteInitiated = true;
                                } else {
                                  // Optionally show an error message or handle the case where positions are null
                                }
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kcPrimaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Show Route',
                                      style: bodyStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(5),
                                    Icon(
                                      FontAwesomeIcons.arrowRight,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  verticalSpaceRegular,
                  model.isLoading
                      ? const LinearProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kcPrimaryColor),
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
                                placePredictions:
                                    model.placePredictionList[index],
                                model: model,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
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
          )
        : RouteWidget(model: model);
  }
}
