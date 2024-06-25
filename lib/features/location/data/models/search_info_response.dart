import 'dart:convert';

import 'package:pamphlets_management/features/location/domain/entities/address_suggestion.dart';

AddressSuggestionsResponse searchInfoResponseFromJson(String str) =>
    AddressSuggestionsResponse.fromJson(json.decode(str));

class AddressSuggestionsResponse {
  List<FeatureResponse> features;

  AddressSuggestionsResponse({
    required this.features,
  });

  factory AddressSuggestionsResponse.fromJson(Map<String, dynamic> json) =>
      AddressSuggestionsResponse(
        features: List<FeatureResponse>.from(
            json["features"].map((x) => FeatureResponse.fromJson(x))),
      );

  static AddressSuggestions fromAddressSuggestionsResponse(
      AddressSuggestionsResponse response) {
    return AddressSuggestions(
      features: response.features
          .map((feature) => Feature.fromJson({
                "properties": feature.properties.toJson(),
                "geometry": feature.geometry.toJson(),
              }))
          .toList(),
    );
  }
}

class FeatureResponse {
  PropertiesResponse properties;
  GeometryResponse geometry;
  FeatureResponse({
    required this.properties,
    required this.geometry,
  });

  factory FeatureResponse.fromJson(Map<String, dynamic> json) =>
      FeatureResponse(
        geometry: GeometryResponse.fromJson(json["geometry"]),
        properties: PropertiesResponse.fromJson(json["properties"]),
      );
}

class GeometryResponse {
  List<double> coordinates;
  String type;

  GeometryResponse({
    required this.coordinates,
    required this.type,
  });

  factory GeometryResponse.fromJson(Map<String, dynamic> json) =>
      GeometryResponse(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class PropertiesResponse {
  String? country;
  String? postcode;
  String? name;
  String? district;
  String? county;
  String? state;
  String? city;
  String? houseNumber;
  String? street;

  PropertiesResponse({
    this.country,
    this.postcode,
    this.name,
    this.district,
    this.county,
    this.state,
    this.city,
    this.houseNumber,
    this.street,
  });

  factory PropertiesResponse.fromJson(Map<String, dynamic> json) =>
      PropertiesResponse(
        country: json["country"],
        postcode: json["postcode"],
        name: json["name"],
        county: json["county"],
        houseNumber: json["housenumber"],
        street: json["street"],
        district: json["district"],
        state: json["state"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "postcode": postcode,
        "name": name,
        "street": street,
        "county": county,
        "housenumber": houseNumber,
        "district": district,
        "state": state,
        "city": city,
      };
}
