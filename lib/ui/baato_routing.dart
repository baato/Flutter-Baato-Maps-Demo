import 'package:baato_flutter_demo/utils/toast.dart';
import 'package:baato_maps/baato_maps.dart';
import 'package:flutter/material.dart';

class BaatoDirectionsExample extends StatelessWidget {
  const BaatoDirectionsExample({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baato Directions"),
        backgroundColor: Color.fromRGBO(8, 30, 42, 50),
      ),
      body: BaatoDirectionsPage(),
    );
  }
}

class BaatoDirectionsPage extends StatefulWidget {
  const BaatoDirectionsPage({super.key});

  @override
  State<BaatoDirectionsPage> createState() => _BaatoDirectionsPageState();
}

class _BaatoDirectionsPageState extends State<BaatoDirectionsPage> {
  late BaatoMapController mapController;
  int _circleCount = 0;

  final List<BaatoCoordinate> _points = List.empty(growable: true);

  void _onMapCreated(BaatoMapController controller) {
    mapController = controller;

    //show initial information
    AppToast.showMessage(
      "Tap on the map to select any two points to get routes between them...",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaatoMap(
        onMapCreated: _onMapCreated,
        onTap: (point, coordinate, feature) {
          _addTappedPointToPointsList(coordinate);
        },
        initialPosition: BaatoCoordinate(
          latitude: 27.7192873,
          longitude: 85.3238007,
        ),
      ),
    );
  }

  _requestRoutingDetails(List<BaatoCoordinate> coordinates) async {
    //get routes between start and destination point
    final response = await Baato.api.direction.getRoutes(
        startCoordinate: coordinates[0],
        endCoordinate: coordinates[1],
        mode: BaatoDirectionMode.foot,
        decodePolyline: true);
    _showRouteDetails(response);
  }

  _showRouteDetails(BaatoRouteResponse route) {
    mapController.routeManager.drawRouteFromResponse(
      route,
      // lineLayerProperties: BaatoLineLayerProperties() //Customize line property
    );
  }

  void _addTappedPointToPointsList(BaatoCoordinate coordinate) {
    if (_circleCount < 2) {
      _addCircle(coordinate);
      _circleCount++;
      _points.add(coordinate);
      if (_circleCount == 2) _requestRoutingDetails(_points);
    } else {
      mapController.shapeManager.clearCircles();
      mapController.shapeManager.clearLines();
      _circleCount = 0;
      _points.clear();
      _addTappedPointToPointsList(coordinate);
    }
  }

  // add circle layer to indicate start and destination points
  void _addCircle(BaatoCoordinate coordinate) {
    String circleColor = "#081E2A";
    if (_circleCount == 1) circleColor = "#63A088";
    mapController.shapeManager.addCircle(BaatoCircleOptions(
        center: coordinate, circleRadius: 10, circleColor: circleColor));
  }
}
