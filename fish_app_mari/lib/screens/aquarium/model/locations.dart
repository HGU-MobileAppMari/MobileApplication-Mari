import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'locations.g.dart';

@JsonSerializable(nullable: false)
class LatLng {
  LatLng({
    @required this.lat,
    @required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable(nullable: false)
class Region {
  Region({
    @required this.coords,
    @required this.id,
    @required this.name,
    @required this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable(nullable: false)
class Office {
  Office({
    @required this.address,
    @required this.id,
    @required this.image,
    @required this.lat,
    @required this.lng,
    @required this.name,
    @required this.phone,
    @required this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable(nullable: false)
class Locations {
  Locations({
    @required this.offices,
    @required this.regions,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
  final List<Region> regions;
}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'http://wlwlwl321.dothome.co.kr/locations.json';

  // Retrieve the locations of Aquariums
  final response = await http.get(Uri.parse(googleLocationsURL));
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(utf8.decode((response.bodyBytes))));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}
