import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TurnByTurn extends StatefulWidget {
  final LatLng? source;
  final LatLng? destination;
  const TurnByTurn({
    Key? key,
    required this.source,
    required this.destination,
  }) : super(key: key);

  @override
  State<TurnByTurn> createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {
  // Waypoints to mark trip start and end
  // LatLng source = ;
  // LatLng destination = ;
  late WayPoint sourceWaypoint, destinationWaypoint;
  var wayPoints = <WayPoint>[];

  MapBoxNavigation directions = MapBoxNavigation.instance;

  double? distanceRemaining = 0;
  double? durationRemaining = 0;
  MapBoxNavigationViewController? _controller;
  final bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;
  late MapBoxOptions _options;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options
    MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.walking,
        initialLatitude: widget.source?.latitude,
        initialLongitude: widget.source?.longitude,
        isOptimized: true,
        units: VoiceUnits.metric,
        alternatives: true,
        simulateRoute: true,
        showEndOfRouteFeedback: true,
        enableRefresh: true,
        showReportFeedbackButton: true,
        longPressDestinationEnabled: false,
        language: "en");

    // Configure waypoints
    sourceWaypoint = WayPoint(
        isSilent: true,
        name: "Source",
        latitude: widget.source?.latitude,
        longitude: widget.source?.longitude);
    destinationWaypoint = WayPoint(
        isSilent: true,
        name: "Destination",
        latitude: widget.destination?.latitude,
        longitude: widget.destination?.longitude);
    wayPoints.add(sourceWaypoint);
    wayPoints.add(destinationWaypoint);

    // Start the trip
    await directions.startNavigation(wayPoints: wayPoints, options: _options);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Simulating your walk, Give us a minute...',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRouteEvent(e) async {
    distanceRemaining = await directions.getDistanceRemaining();
    durationRemaining = await directions.getDurationRemaining();

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller?.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        Navigator.of(context).pop();
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }
}
