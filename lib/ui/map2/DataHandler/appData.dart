import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../models/address.dart';

class AppData extends ChangeNotifier {
  Address? startLocation, destLocation;

  void updateStartAddress(Address startAddress) {
    startLocation = startAddress;
    notifyListeners();
  }

  void updatedestLocationAddress(Address destAddress) {
    destLocation = destAddress;
    notifyListeners();
  }
}
