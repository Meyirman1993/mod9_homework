// ignore: duplicate_ignore
// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:template_project/hotel_info.dart';
import 'package:template_project/models/hotel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = Dio();
  bool _isLoading = false;
  bool _hasError = false;
  bool _listView = true;
  List<Hotel> hotels = [];
  GlobalKey greedView = GlobalKey();
  GlobalKey listView = GlobalKey();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void changeView() {
    setState(() {
      _listView ? _listView = false : _listView = true;
    });
  }

  // ignore: avoid_void_async
  void getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await dio.get<List>(
        'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301',
      );
      hotels = response.data!
          .map<Hotel>(
            (dynamic hotel) => Hotel.fromJson(hotel as Map<String, dynamic>),
          )
          .toList();

      // ignore: avoid_print
      print(hotels[1].name);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      setState(() {
        _hasError = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel list'),
        actions: [
          IconButton(
            onPressed: changeView,
            icon: !_listView
                ? const Icon(Icons.list_rounded)
                : _listView
                    ? const Icon(Icons.grid_view_rounded)
                    : const HomePage(),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _hasError
              ? const Center(
                  child: Text('Error'),
                )
              : _listView
                  ? ListViewWidget(
                      hotels: hotels,
                      lKey: listView,
                    )
                  : GridViewWidget(
                      hotels: hotels,
                      gKey: greedView,
                    ),
    );
  }
}

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    Key? key,
    required this.hotels,
    required this.gKey,
  }) : super(key: key);
  final List<Hotel> hotels;
  final GlobalKey gKey;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // key: gKey,
      itemCount: hotels.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/${hotels[index].poster}',
                    // height: 180,
                    // fit: BoxFit.fitHeight,
                  ),
                ),
                Text(hotels[index].name),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) {
                            return HotelInfoWidget(
                              url:
                                  'https://run.mocky.io/v3/${hotels[index].uuid}',
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Подробнее'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
    required this.hotels,
    required this.lKey,
  }) : super(key: key);

  final List<Hotel> hotels;
  final GlobalKey lKey;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // key: lKey,
      itemCount: hotels.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/images/${hotels[index].poster}',
                    // height: 350,
                    // width: double.infinity,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(child: Text(hotels[index].name)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute(
                              builder: (context) {
                                return HotelInfoWidget(
                                  url:
                                      'https://run.mocky.io/v3/${hotels[index].uuid}',
                                );
                              },
                            ),
                          );
                        },
                        child: const Text('Подробнее'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        //  ListTile(
        //   subtitle: Text(hotels[index].name),
        //   title: Image.asset('assets/images/${hotels[index].poster}'),
        //   onTap: () {
        //     Navigator.of(context).push<void>(
        //       MaterialPageRoute(
        //         builder: (BuildContext context) => HotelInfoWidget(
        //           url: 'https://run.mocky.io/v3/${hotels[index].uuid}',
        //         ),
        //       ),
        //     );
        //   },
        // );
      },
    );
  }
}
