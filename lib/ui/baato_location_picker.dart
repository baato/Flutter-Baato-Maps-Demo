import 'package:baato_flutter_demo/utils/toast.dart';
import 'package:baato_maps/baato_maps.dart';
import 'package:flutter/material.dart';

class BaatoLocationPickerExample extends StatelessWidget {
  const BaatoLocationPickerExample({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Baato Location Picker Example"),
      ),
      body: const BaatoReversePage(),
    );
  }
}

class BaatoReversePage extends StatefulWidget {
  const BaatoReversePage({super.key});

  @override
  State<BaatoReversePage> createState() => _BaatoReversePageState();
}

class _BaatoReversePageState extends State<BaatoReversePage> {
  final BaatoMapController mapController = BaatoMapController();
  BaatoPlaceResponse? placeResponse;
  bool isCameraMoving = false;

  void _onMapCreated(BaatoMapController controller) {
    //show initial information
    AppToast.showMessage(
      "Move the map to change the marker location and get location details of that point... ",
    );

    mapController.addListener(() {
      final cameraManager = mapController.cameraManager;
      if (cameraManager.isCameraMoving) {
        setState(() {
          isCameraMoving = cameraManager.isCameraMoving;
        });
      }
    });
  }

  void _onCameraIdle() {
    final cameraManager = mapController.cameraManager;
    if (!cameraManager.isCameraMoving) {
      isCameraMoving = false;
      setState(() {});
      final coordinate = cameraManager.getCameraPosition()!.target;
      _requestLocationDetails(coordinate);
      _showMarkerOnTheTappedLocation(coordinate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BaatoMap(
              controller: mapController,
              trackCameraPosition: true,
              onMapCreated: _onMapCreated,
              onCameraIdle: _onCameraIdle,
              onMapClick: (point, coordinate, features) async {
                //onTAP--> onMapClick
                mapController.cameraManager.moveTo(coordinate);
                _requestLocationDetails(coordinate);
                _showMarkerOnTheTappedLocation(coordinate);
              },
              initialZoom: 14,
              initialPosition:
                  BaatoCoordinate(latitude: 27.7192873, longitude: 85.3238007)),
          Center(
            child: Container(
              child: isCameraMoving
                  ? Image.asset(
                      'assets/baato_marker.png',
                      scale: 3,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestLocationDetails(BaatoCoordinate coordinate) async {
    //perform reverse Search
    final response = await Baato.api.place.reverseGeocode(coordinate);
    print(response);

    setState(() {
      placeResponse = response;
    });

    _showAddressInfo(response);
  }

  void _showAddressInfo(BaatoPlaceResponse response) {
    if (response.data!.isEmpty) {
      print("No result found");
    } else {
      AppToast.showMessage(
        "Name: ${response.data![0].name}\nAddress: ${response.data![0].address}",
      );
    }
  }

  void _showMarkerOnTheTappedLocation(BaatoCoordinate coordinate) {
    mapController.markerManager
        .addMarker(BaatoSymbolOption(geometry: coordinate));
  }
}
