import 'package:flutter/material.dart';
import 'package:projekt/const.dart';
import 'package:projekt/features/data/remote_data_source/firestore_helper.dart';
import 'package:projekt/features/data/remote_data_source/models/event_model.dart';
import 'package:projekt/features/presentation/widgets/header_widget.dart';

class MyEventsPage extends StatefulWidget {
  final String uid;
  const MyEventsPage({super.key, required this.uid});

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const HeaderWidget(title: 'My Events'),
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
                    child: Text("some error occured"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.pink,
        hoverColor: Colors.black,
        tooltip: 'Go Back',
        child: const Icon(
          Icons.arrow_back_rounded,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
        if (!(singleEvent.members.contains(widget.uid))) {
          return const SizedBox(
            width: 0,
            height: 0,
          );
        } else {
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
        }
      },
    ));
  }
}
