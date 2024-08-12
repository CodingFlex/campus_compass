import 'dart:convert';

import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/ui/map2/map_viewmodel.dart';
import 'package:campus_compass/ui/map2/models/placepredictions.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:campus_compass/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
// Import your MapViewModel

class PlaceButton extends StatelessWidget {
  final PlacePredictions placePredictions;

  PlaceButton({required this.placePredictions, required bool isDestination});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => MapViewModel(),
      builder: (context, model, child) => Container(
        padding: const EdgeInsets.all(0),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(10)),
          onPressed: () {
            // model.updatePlace();
            // model.getPlaceAddressDetails(placePredictions.place_id, context);
            // Update the appropriate TextField
            print('clicked');
            if (model.isResponseForDestination) {
              model.destLocation.text = placePredictions.main_text;
              UserSecureStorage.setSource(json.encode(placePredictions));
            } else {
              model.startLocation.text = placePredictions.main_text;
              UserSecureStorage.setDestination(json.encode(placePredictions));
            }
            model.placePredictionList.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            child: Column(
              children: [
                SizedBox(width: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Assets.location, height: 30, width: 25),
                    Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            placePredictions.main_text,
                            overflow: TextOverflow.ellipsis,
                            style: subheadingStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
