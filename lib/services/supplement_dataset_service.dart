import 'package:campus_compass/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

import '../app/app.locator.dart';

class SupplementDatasetService {
  final _pocketBaseService = locator<PocketBaseService>();
  List<RecordModel> records = [];
  Future<List<RecordModel>> fetchDataSetRecords() async {
    records = await _pocketBaseService.pb.collection('Locations').getFullList(
          sort: '-place_name',
        );
    print(records);
    return records;
  }
}
