import 'package:baato_flutter_demo/ui/baato_map_style_view.dart';
import 'package:baato_maps/baato_maps.dart';
import 'package:flutter/material.dart';

class RetroMapStyle extends StatelessWidget {
  const RetroMapStyle({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BaatoMapStyleView(style: BaatoMapStyle.retro);
  }
}
