
import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/ui/map2/map_viewmodel.dart';
import 'package:campus_compass/ui/map2/models/placepredictions.dart';
import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Import your MapViewModel

class PlaceButton extends StatelessWidget {
  final PlacePredictions placePredictions;
  final MapViewModel model;

  PlaceButton({required this.placePredictions, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.all(10)),
        onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          if (model.isResponseForDestination == true) {
            model.destLocation.text = placePredictions.main_text;
            model.destInfo = placePredictions.secondary_text;
            model.placePredictionList.clear();
            if (model.startLocation.text.isNotEmpty) {
              model.showProceedButton = true;
            }
          } else {
            model.startLocation.text = placePredictions.main_text;
            model.placePredictionList.clear();
            if (model.destLocation.text.isNotEmpty) {
              model.showProceedButton = true;
            }
          }
          if (placePredictions.isSupplement == true) {
            model.initiateSupplementCoordinates(
              placePredictions.coordinates![0],
              placePredictions.coordinates![1],
              placePredictions.main_text,
            );
          } else {
            model.getPlaceAddressDetails(
              placePredictions.place_id,
              context,
              isDestination: model.isResponseForDestination,
            );
          }
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(width: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  placePredictions.image != null && placePredictions.image != ""
                      ? Image.asset(Assets.futa, height: 30, width: 25)
                      : Image.asset(Assets.location, height: 30, width: 25),
                  Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          placePredictions.main_text,
                          overflow: TextOverflow.ellipsis,
                          style: subheadingStyle.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Gap(3),
                        Text(
                          placePredictions.secondary_text,
                          overflow: TextOverflow.ellipsis,
                          style: bodyStyle.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
