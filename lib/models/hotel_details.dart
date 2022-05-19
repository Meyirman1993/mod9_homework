// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
part 'hotel_details.g.dart';

@JsonSerializable()
class HotelDetails {
  HotelDetails({
    required this.uuid,
    required this.name,
    required this.poster,
    required this.address,
    required this.price,
    required this.rating,
    required this.services,
    required this.photos,
  });
  factory HotelDetails.fromJson(Map<String, dynamic> json) =>
      _$HotelDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$HotelDetailsToJson(this);

  String uuid;
  String name;
  String poster;
  Adress address;
  double price;
  double rating;
  Services services;
  List<String> photos;
}

@JsonSerializable()
class Adress {
  Adress({
    required this.country,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.cordinates,
  });
  factory Adress.fromJson(Map<String, dynamic> json) => _$AdressFromJson(json);
  Map<String, dynamic> toJson() => _$AdressToJson(this);
  String country;
  String street;
  String city;
  @JsonKey(name: 'zip_code')
  int zipCode;
  @JsonKey(name: 'coords')
  Cordinates cordinates;
}

@JsonSerializable()
class Services {
  Services({required this.free, required this.paid});
  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesToJson(this);

  List<String> free;
  List<String> paid;
}

@JsonSerializable()
class Cordinates {
  Cordinates({required this.latitude, required this.longitude});
  factory Cordinates.fromJson(Map<String, dynamic> json) =>
      _$CordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CordinatesToJson(this);

  @JsonKey(name: 'lat')
  double latitude;
  @JsonKey(name: 'lan')
  double longitude;
}
