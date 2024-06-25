class AddressSuggestions {
  List<Feature> features;
  AddressSuggestions({
    required this.features,
  });
}

class Feature {
  Properties properties;
  Geometry geometry;
  Feature({
    required this.properties,
    required this.geometry,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );
}

class Geometry {
  List<double> coordinates;
  String type;

  Geometry({
    required this.coordinates,
    required this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  String? country;
  String? postcode;
  String? name;
  String? district;
  String? county;
  String? state;
  String? city;
  String? houseNumber;
  String? street;

  Properties({
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

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
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
        "county": county,
        "housenumber": houseNumber,
        "district": district,
        "state": state,
        "city": city,
      };

  static String getFullLocation(Properties properties) {
    List<String> components = [];

    if (properties.name != null) components.add(properties.name!);
    if (properties.street != null) components.add(properties.street!);
    if (properties.houseNumber != null) components.add(properties.houseNumber!);
    if (properties.district != null) components.add(properties.district!);
    if (properties.city != null) components.add(properties.city!);
    if (properties.state != null) components.add(properties.state!);
    if (properties.country != null) components.add(properties.country!);

    return components.join(', ');
  }
}
