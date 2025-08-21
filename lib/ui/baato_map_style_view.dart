import 'package:baato_maps/baato_maps.dart';
import 'package:flutter/material.dart';

class BaatoMapStyleView extends StatefulWidget {
  const BaatoMapStyleView({super.key, required this.style});

  final BaatoMapStyle style;

  @override
  State<BaatoMapStyleView> createState() => _BaatoMapStyleView();
}

class _BaatoMapStyleView extends State<BaatoMapStyleView> {
  BaatoMapController mapController = BaatoMapController();

  @override
  void dispose() {
    mapController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baato Breeze Map')),
      body: BaatoMap(
        controller: mapController,
        myLocationEnabled: true,
        initialPosition: BaatoCoordinate(
          latitude: 27.7192873,
          longitude: 85.3238007,
        ),
        style: widget.style,
      ),
    );
  }
}
