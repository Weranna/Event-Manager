// ignore_for_file: avoid_web_libraries_in_flutter, implementation_imports, library_prefixes, must_be_immutable

import 'package:flutter/material.dart';

import 'dart:html';
import 'package:flutter/src/widgets/icon.dart' as Icon;
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({super.key, required this.coordinates});
  String coordinates;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  Widget build(BuildContext context) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      // another location
      final myLatlng2 = LatLng(
          getLatitude(widget.coordinates), getLongiitude(widget.coordinates));

      final mapOptions = MapOptions()
        ..zoom = 15
        ..center = LatLng(
            getLatitude(widget.coordinates), getLongiitude(widget.coordinates));

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      // Another marker
      Marker(
        MarkerOptions()
          ..position = myLatlng2
          ..map = map,
      );

      return elem;
    });

    return Scaffold(
      body: HtmlElementView(viewType: htmlId),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.pink,
        hoverColor: Colors.black,
        tooltip: 'Go Back',
        child: const Icon.Icon(
          Icons.arrow_back_rounded,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  num? getLatitude(String coordinates) {
    List<String> splitCoordinates = coordinates.split(',');
    num? latitude = num.tryParse(splitCoordinates[0].trim());
    return latitude;
  }

  num? getLongiitude(String coordinates) {
    List<String> splitCoordinates = coordinates.split(',');
    num? longitude = num.tryParse(splitCoordinates[1].trim());
    return longitude;
  }
}
