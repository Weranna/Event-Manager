import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projekt/const.dart';
import 'package:projekt/features/data/remote_data_source/firestore_helper.dart';
import 'package:projekt/features/data/remote_data_source/models/event_model.dart';
import 'package:projekt/features/presentation/cubit/auth/auth_cubit.dart';

import '../widgets/header_widget.dart';

class MainPage extends StatefulWidget {
  final String uid;
  const MainPage({super.key, required this.uid});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearch = false;
  List searchResult = [];

  Widget _searchResultWidget() {
    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        var image = '';
        switch (searchResult[index]['discipline']) {
          case "other":
            image = 'assets/images/default.jpg';
            break;
          case "football":
            image = 'assets/images/football.jpg';
            break;
          case "basketball":
            image = 'assets/images/basketball.jpg';
            break;
          case "cycling":
            image = 'assets/images/cycling.png';
            break;
          case "fitness":
            image = 'assets/images/fitness.jpg';
            break;
          case "hockey":
            image = 'assets/images/hockey.jpg';
            break;
          case "pool":
            image = 'assets/images/pool.jpg';
            break;
          case "run":
            image = 'assets/images/run.jpg';
            break;
          case "volleyball":
            image = 'assets/images/volleyball.jpg';
            break;
          case "yoga":
            image = 'assets/images/yoga.jpg';
            break;
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageConst.singleEventPage,
                  arguments: {
                    'eventId': searchResult[index]['eventId'],
                    'uid': widget.uid
                  });
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Image.asset(
                        image,
                        height: 200,
                        width: 450,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 450,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.pink,
                            width: 5,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${searchResult[index]['title']}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      const WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Icon(
                                            Icons.calendar_month,
                                            color: Colors.black,
                                            size: 25,
                                          )),
                                      TextSpan(
                                          text:
                                              '  ${searchResult[index]['date']}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchWidget() {
    return Container(
      height: 70,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 0.5)),
      ]),
      child: Container(
          height: 50,
          width: 350,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(221, 221, 221, 1),
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "SEARCH... (give the exact title)",
                border: InputBorder.none,
                prefixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _isSearch = false;
                      });
                    },
                    child: const Icon(Icons.arrow_back, size: 30))),
            onChanged: (query) {
              searchFromFirebase(query);
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _isSearch == true ? Colors.transparent : Colors.pink,
        title: _isSearch == true
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : const Text(''),
        flexibleSpace: _isSearch == true
            ? _buildSearchWidget()
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        actions: _isSearch == true
            ? []
            : [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isSearch = !_isSearch;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Tooltip(
                      message: "Search",
                      child: Icon(
                        Icons.search,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.addEventPage,
                        arguments: {'uid': widget.uid});
                  },
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Tooltip(
                          message: "Add Event",
                          child: Icon(Icons.add, size: 40))),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.myEventsPage,
                        arguments: {'uid': widget.uid});
                  },
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Tooltip(
                          message: "My events",
                          child: Icon(Icons.list, size: 40))),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                  },
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Tooltip(
                          message: "Log out",
                          child: Icon(Icons.logout, size: 40))),
                )
              ],
      ),
      body: _isSearch == true
          ? _searchResultWidget()
          : Center(
              child: Column(children: [
                const HeaderWidget(title: 'Event Manager'),
                StreamBuilder<List<EventModel>>(
                    stream: FirestoreHelper.read(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("some error occured while showing"),
                        );
                      }
                      if (snapshot.hasData) {
                        final eventData = snapshot.data;
                        return _bodyWidget(eventData);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })
              ]),
            ),
    );
  }

  Widget _bodyWidget(eventData) {
    return Expanded(
        child: ListView.builder(
      itemCount: eventData!.length,
      itemBuilder: (context, index) {
        final singleEvent = eventData[index];
        var image = '';
        switch (singleEvent.discipline) {
          case "other":
            image = 'assets/images/default.jpg';
            break;
          case "football":
            image = 'assets/images/football.jpg';
            break;
          case "basketball":
            image = 'assets/images/basketball.jpg';
            break;
          case "cycling":
            image = 'assets/images/cycling.png';
            break;
          case "fitness":
            image = 'assets/images/fitness.jpg';
            break;
          case "hockey":
            image = 'assets/images/hockey.jpg';
            break;
          case "pool":
            image = 'assets/images/pool.jpg';
            break;
          case "run":
            image = 'assets/images/run.jpg';
            break;
          case "volleyball":
            image = 'assets/images/volleyball.jpg';
            break;
          case "yoga":
            image = 'assets/images/yoga.jpg';
            break;
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageConst.singleEventPage,
                  arguments: {
                    'eventId': singleEvent.eventId,
                    'uid': widget.uid
                  });
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Image.asset(
                        image,
                        height: 200,
                        width: 450,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 450,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.pink,
                            width: 5,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${singleEvent.title}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      const WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Icon(
                                            Icons.calendar_month,
                                            color: Colors.black,
                                            size: 25,
                                          )),
                                      TextSpan(
                                          text: '  ${singleEvent.date}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('events')
        .where('title', isEqualTo: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }
}
