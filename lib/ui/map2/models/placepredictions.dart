class PlacePredictions {
  late String secondary_text;
  late String main_text;
  late String place_id;
  String? image;
  bool? isSupplement;
  List<double>? coordinates;

  PlacePredictions({
    required this.secondary_text,
    required this.main_text,
    required this.place_id,
    this.image,
    this.isSupplement,
    this.coordinates,
  });

  // Constructor for creating PlacePredictions from JSON
  PlacePredictions.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
    main_text = json["structured_formatting"]["main_text"];
    secondary_text = json["structured_formatting"]["secondary_text"] ??
        json["structured_formatting"]["main_text"];
  }
}
