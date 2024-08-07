// pocketbase_service.dart
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  final PocketBase pb;
  static const url = 'https://campus-compass.pockethost.io/';

  PocketBaseService() : pb = PocketBase(url);
}
