// pocketbase_service.dart
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  final PocketBase pb;

  PocketBaseService() : pb = PocketBase('http://10.0.2.2:8090/');
}
