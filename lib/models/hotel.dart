// ignore_for_file: public_member_api_docs
import 'package:json_annotation/json_annotation.dart';
part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  Hotel({required this.uuid, required this.name, required this.poster});
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return _$HotelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$HotelToJson(this);
  String uuid;
  String name;
  String poster;
}
