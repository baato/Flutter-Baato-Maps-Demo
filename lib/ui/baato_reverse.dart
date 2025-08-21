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
        title: const Text("Baato Reverse"),
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
  BaatoMapController mapController = BaatoMapController();
  BaatoPlaceResponse? placeResponse;

  void _onStyleLoaded() {
    AppToast.showMessage(
      "Tap on any point on the map to get location details of that point... ",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaatoMap(
        onStyleLoadedCallback: _onStyleLoaded,
        myLocationEnabled: true,
        controller: mapController,
        // onTap: (point, coordinate, features) {
        //   print("hello I have been tapped2");
        //   mapController.controller?.addSymbol(SymbolOptions(
        //       geometry: LatLng(coordinate.latitude, coordinate.longitude),
        //       iconImage: "assets/baato_marker.png"));
        // },
        onMapClick: (point, coordinate, features) {
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

  Future<void> _requestLocationDetails(BaatoCoordinate baatoCoordinate) async {
    final response = await Baato.api.place.reverseGeocode(baatoCoordinate);

    //perform reverse Search
    print("hello $response");

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
        "Name: ${response.data![0].name} \nAddress: ${response.data![0].address}",
      );
    }
  }
}
