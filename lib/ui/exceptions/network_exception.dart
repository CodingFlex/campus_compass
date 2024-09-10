import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/ui/contribute/contribute_viewmodel.dart';
import 'package:campus_compass/ui/exceptions/exception_viewmodel.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:campus_compass/utils/widgets/box_button.dart';
import 'package:campus_compass/utils/widgets/box_drop_down.dart';
import 'package:campus_compass/utils/widgets/box_input_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class NetworkExceptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExceptionViewModel>.reactive(
      viewModelBuilder: () => ExceptionViewModel(),
      onViewModelReady: (model) => (),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titleSpacing: 0.0,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   color: Colors.black,
          // ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 350,
                    child: Image.asset(Assets.noNetwork),
                  ),
                  Gap(20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          'Oops!',
                          style: headlineStyle.copyWith(fontSize: 20.sp),
                        ),
                        Gap(5),
                        Text(
                          'Couldn\'t connect to internet',
                          style: heading3Style.copyWith(fontSize: 16.sp),
                        ),
                        Gap(5),
                        Text(
                          'Please check your network settings',
                          style: heading3Style.copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  Gap(30),
                  GestureDetector(
                    onTap: () {
                      model.navigateToMap();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kcPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.redo,
                            color: Colors.white,
                          ),
                          Gap(10),
                          Text(
                            'Retry',
                            style:
                                subheadingStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
