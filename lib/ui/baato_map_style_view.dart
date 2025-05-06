import 'dart:math';

import 'package:baato_maps/baato_maps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BaatoMapStyleView extends StatefulWidget {
  const BaatoMapStyleView({super.key, required this.style});

  final BaatoMapStyle style;

  @override
  State<BaatoMapStyleView> createState() => _BaatoMapStyleView();
}

class _BaatoMapStyleView extends State<BaatoMapStyleView> {
  BaatoMapController? mapController;

  void _onMapCreated(BaatoMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baato Breeze Map'),
        backgroundColor: Color.fromRGBO(8, 30, 42, 50),
      ),
      body: Stack(
        children: [
          BaatoMap(
            logoViewMargins: Point(-50, -50),
            onMapCreated: _onMapCreated,
            initialPosition: BaatoCoordinate(
              latitude: 27.7192873,
              longitude: 85.3238007,
            ),
            style: widget.style,
          ),
          //add Baato logo
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 35.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white70),
                child: Image.network(
                  "https://i.postimg.cc/k5DpLQKQ/baato-Logo.png",
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(color: Colors.white70),
              padding: EdgeInsets.only(bottom: 2.0, right: 2.0),
              child: InkWell(
                child: RichText(
                  text: TextSpan(
                    text: "© ",
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: "OpenStreetMap contributors",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  await launchUrlString(
                    "https://www.openstreetmap.org/copyright",
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
