import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/ui/contribute/contribute_viewmodel.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:campus_compass/utils/widgets/box_button.dart';
import 'package:campus_compass/utils/widgets/box_drop_down.dart';
import 'package:campus_compass/utils/widgets/box_input_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class ContributeView extends StatelessWidget {
  final List<String> items = [
    'School Building',
    'Restaurant and Eatery',
    'Lecture Theatre',
    'Lab',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContributeViewModel>.reactive(
      viewModelBuilder: () => ContributeViewModel(),
      onViewModelReady: (model) => model.fetchLocation(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titleSpacing: 0.0,
          title: Text(
            'Contribute to Campus Compass',
            style: heading2Style.copyWith(fontSize: 18.sp),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  child: Image.asset(Assets.collab),
                ),
                Gap(10),
                if (model.isBusy)
                  const LinearProgressIndicator(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    valueColor: AlwaysStoppedAnimation<Color>(kcPrimaryColor),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kcPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Location: ${model.currentPosition!.longitude}, ${model.currentPosition!.latitude}',
                          style: heading3Style.copyWith(fontSize: 16.sp),
                        ),
                        Gap(5),
                        Text(
                          'Your Address: ${model.currentAddress}',
                          style: heading3Style.copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Please enter the name and type of the place you want to contribute',
                          style: heading3Style.copyWith(fontSize: 16.sp),
                        ),
                        Gap(20),
                        BoxInputField(
                          width: 400,
                          controller: model.placeNameController,
                          placeholder: 'Place Name',

                          trailing: Icon(Icons.location_on_outlined),
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          //   FormBuilderValidators.match(RegExp(r'^[a-zA-Z ]+$'),
                          //       errorText: 'Only alphabets are allowed'),
                          // ]),
                        ),
                        Gap(20),
                        BoxDropDown(model: model),
                      ],
                    ),
                  ),
                ),
                Gap(30),
                GestureDetector(
                  onTap: (model.placeNameController.text.isEmpty ||
                          model.placeType == null)
                      ? null
                      : () {
                          model.sendContribution(
                            placeName: model.placeNameController.text,
                            placeType: model.placeType,
                            longitude: model.currentPosition!.longitude,
                            latitude: model.currentPosition!.latitude,
                          );
                        },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: (model.placeNameController.text.isEmpty ||
                              model.placeType == null ||
                              model.contributeBusy)
                          ? kcMediumGreyColor
                          : kcPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: model.contributeBusy
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                              Gap(5),
                              Text(
                                'Contribute',
                                style: subheadingStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
