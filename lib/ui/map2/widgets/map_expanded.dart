// expanded_widget.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/widgets/box_input_field.dart';
import '../map_viewmodel.dart';

class ExpandedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => MapViewModel(),
      builder: (context, model, child) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 181, 181, 181),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: <Widget>[
            BoxInputField(
              controller: model.searchLocation,
              placeholder: 'Full name',
              leading: Icon(
                Icons.person,
                color: const Color.fromARGB(255, 201, 201, 201),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
