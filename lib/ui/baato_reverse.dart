import 'package:baato_flutter_demo/utils/toast.dart';
import 'package:baato_maps/baato_maps.dart';
import 'package:flutter/material.dart';

class BaatoReverseExample extends StatelessWidget {
  const BaatoReverseExample({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baato Reverse"),
        backgroundColor: Color.fromRGBO(8, 30, 42, 50),
      ),
      body: BaatoReversePage(),
    );
  }
}

class BaatoReversePage extends StatefulWidget {
  const BaatoReversePage({super.key});

  @override
  State<BaatoReversePage> createState() => _BaatoReversePageState();
}

class _BaatoReversePageState extends State<BaatoReversePage> {
  late BaatoMapController mapController;
  BaatoPlaceResponse? placeResponse;

  void _onMapCreated(BaatoMapController controller) {
    mapController = controller;
    mapController.styleManager.setStyle(BaatoMapStyle.defaultStyle);

    mapController.markerManager.addMarker(BaatoSymbolOption(
      geometry: BaatoCoordinate(
        latitude: 27.8192878,
        longitude: 85.3238007,
      ),
      textField: "Marker added from Style",
      // iconImage: //Can add your own marker image
    ));
    mapController.controller!.addSymbol(SymbolOptions(
        geometry: LatLng(27.7192873, 85.3238007),
        textField: "from maplibre",
        fontNames: ['OpenSans'],
        iconImage: "assets/baato_marker.png"));
  }

  void _onStyleLoaded() {
    AppToast.showMessage(
      "Tap on any point on the map to get location details of that point... ",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaatoMap(
        onMapCreated: _onMapCreated,
        onStyleLoadedCallback: _onStyleLoaded,
        myLocationEnabled: true,
        onTap: (point, coordinate, features) {
          mapController.markerManager.addMarker(
            BaatoSymbolOption(
              geometry: coordinate,
              textField: "Drop a pin",
              // iconImage: //Can add your own marker image
            ),
          );
          _requestLocationDetails(coordinate);
        },
        initialPosition: BaatoCoordinate(
          latitude: 27.7192873,
          longitude: 85.3238007,
        ),
      ),
    );
  }

  _requestLocationDetails(BaatoCoordinate baatoCoordinate) async {
    final response = await Baato.api.place.reverseGeocode(baatoCoordinate);

    //perform reverse Search

    setState(() {
      placeResponse = response;
    });
    _showAddressInfo(response);
  }

  _showAddressInfo(BaatoPlaceResponse response) {
    if (response.data!.isEmpty)
      print("No result found");
    else {
      AppToast.showMessage(
        "Name: ${response.data![0].name} \nAddress: ${response.data![0].address}",
      );
    }
  }
}
