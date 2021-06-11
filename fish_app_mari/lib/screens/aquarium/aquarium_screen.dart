import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fish_app_mari/screens/home/components/title_with_more_bbtn.dart'
    as title;
import 'package:fish_app_mari/screens/aquarium/model/locations.dart'
    as locations;
import 'package:location/location.dart';

class AquariumScreen extends StatefulWidget {
  @override
  _AquariumScreenState createState() => _AquariumScreenState();
}

class _AquariumScreenState extends State<AquariumScreen> {
  final Map<String, Marker> _markers = {};
  Location location = Location();
  LocationData _locationData;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    final LocationData _locationResult = await location.getLocation();

    setState(() {
      _markers.clear();
      // for (final office in googleOffices.offices) {
      //   final marker = Marker(
      //     markerId: MarkerId(office.name),
      //     position: LatLng(office.lat, office.lng),
      //     infoWindow: InfoWindow(
      //       title: office.name,
      //       snippet: office.address,
      //     ),
      //   );
      //   _markers[office.name] = marker;
      // }
      _locationData = _locationResult;
      print('location: $_locationData');
      _markers['me'] = Marker(
          markerId: MarkerId('me'),
          position: LatLng(_locationData.latitude, _locationData.longitude),
          infoWindow: InfoWindow(title: 'me'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 20.0,
            bottom: 20.0,
          ),
          child: title.TitleWithCustomUnderline(
            text: "수족관",
          ),
        ),
        Expanded(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(37.5642135, 127.0016985),
              zoom: 7,
            ),
            // myLocationButtonEnabled: false,
            markers: _markers.values.toSet(),
            //myLocationEnabled: true,
          ),
        ),
      ],
    );
  }
}
