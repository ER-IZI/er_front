class HospitalModel {
  final String name, latitude, longitude;
  final List<String> treatmentTypes;

  HospitalModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        treatmentTypes = List<String>.from(json['treatmentTypes'] ?? []);

  Map<String, dynamic> toJson() => {
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'treatmentTypes': treatmentTypes,
      };
}