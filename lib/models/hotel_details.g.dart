// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelDetails _$HotelDetailsFromJson(Map<String, dynamic> json) => HotelDetails(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      poster: json['poster'] as String,
      address: Adress.fromJson(json['address'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      services: Services.fromJson(json['services'] as Map<String, dynamic>),
      photos: (json['photos'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$HotelDetailsToJson(HotelDetails instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'poster': instance.poster,
      'address': instance.address,
      'price': instance.price,
      'rating': instance.rating,
      'services': instance.services,
      'photos': instance.photos,
    };

Adress _$AdressFromJson(Map<String, dynamic> json) => Adress(
      country: json['country'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      zipCode: json['zip_code'] as int,
      cordinates: Cordinates.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdressToJson(Adress instance) => <String, dynamic>{
      'country': instance.country,
      'street': instance.street,
      'city': instance.city,
      'zip_code': instance.zipCode,
      'coords': instance.cordinates,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) => Services(
      free: (json['free'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      paid: (json['paid'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'free': instance.free,
      'paid': instance.paid,
    };

Cordinates _$CordinatesFromJson(Map<String, dynamic> json) => Cordinates(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lan'] as num).toDouble(),
    );

Map<String, dynamic> _$CordinatesToJson(Cordinates instance) =>
    <String, dynamic>{
      'lat': instance.latitude,
      'lan': instance.longitude,
    };
