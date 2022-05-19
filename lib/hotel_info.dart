// import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
// ignore_for_file: public_member_api_docs, avoid_void_async, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:template_project/models/hotel_details.dart';

class HotelInfoWidget extends StatefulWidget {
  const HotelInfoWidget({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<HotelInfoWidget> createState() => _HotelInfoWidgetState();
}

class _HotelInfoWidgetState extends State<HotelInfoWidget> {
  late HotelDetails hotelDetails;
  final Dio _dio = Dio();
  bool _isLoading = false;
  bool _hasError = false;
  late String errorMsg;

  void getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      print(widget.url);
      final response = await _dio.request<Map<String, dynamic>>(widget.url);
      print(response);
      hotelDetails =
          // ignore: cast_nullable_to_non_nullable
          HotelDetails.fromJson(response.data as Map<String, dynamic>);
      print(hotelDetails);
    } on DioError catch (e) {
      // errorMsg = e.error.toString();
      if (e.error.toString().contains('[404]')) {
        errorMsg = 'Данные временно не доступны';
      } else {
        errorMsg = e.error.toString();
      }

      print(e);
      setState(
        () {
          _hasError = true;
        },
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : _hasError
            ? Scaffold(appBar: AppBar(), body: Center(child: Text(errorMsg)))
            : Scaffold(
                appBar: AppBar(
                  title: Text(hotelDetails.name),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      CarouselSlider(
                        items: hotelDetails.photos
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Image.asset('assets/images/$e'),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Страна: '),
                                Text(
                                  hotelDetails.address.country,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text('Город: '),
                                Text(
                                  hotelDetails.address.city,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text('Улица: '),
                                Text(
                                  hotelDetails.address.street,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text('Рейтинг: '),
                                Text(
                                  hotelDetails.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Сервисы',
                              style: TextStyle(
                                fontSize: 25,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            // const SizedBox(
                            // height: 20,
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Платные',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // const SizedBox(height: 10),
                                      ...hotelDetails.services.paid
                                          .map(
                                            (e) => Text(
                                              e,
                                              maxLines: 2,
                                              softWrap: true,
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Бeсплатные',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ...hotelDetails.services.free
                                          .map(
                                            (e) => Text(
                                              e,
                                              maxLines: 2,
                                              softWrap: true,
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}
