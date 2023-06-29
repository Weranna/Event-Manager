import 'package:flutter/material.dart';
import 'package:projekt/const.dart';
import 'package:projekt/features/data/remote_data_source/firestore_helper.dart';
import 'package:projekt/features/data/remote_data_source/models/event_model.dart';

import 'package:projekt/features/presentation/widgets/header_widget.dart';

class SingleEventPage extends StatefulWidget {
  final String eventId;
  final String uid;

  const SingleEventPage({super.key, required this.eventId, required this.uid});

  @override
  State<SingleEventPage> createState() => _SingleEventPageState();
}

class _SingleEventPageState extends State<SingleEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const HeaderWidget(
          title: 'Event Details',
        ),
        StreamBuilder<List<EventModel>>(
          stream: FirestoreHelper.readSingle(widget.eventId),
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
          },
        )
      ])),
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

        return Container(
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
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text('${singleEvent.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
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
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PageConst.googleMapPage,
                        arguments: {
                          'coordinates': singleEvent.localization,
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Text("Localization",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                '${singleEvent.description}',
                style: const TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            checkIfUserIsMember(singleEvent.members, widget.uid) == true
                ? checkIfUserIsOwner(singleEvent.uid, widget.uid) == true
                    ? Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 30),
                        child: ElevatedButton(
                            onPressed: () {
                              FirestoreHelper.deleteEvent(singleEvent.eventId);
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Text("Delete",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            )),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 30),
                        child: ElevatedButton(
                            onPressed: () {
                              FirestoreHelper.removeMemberFromEvent(
                                  singleEvent.eventId, widget.uid);
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Text("Leave",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            )),
                      )
                : Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    child: ElevatedButton(
                        onPressed: () {
                          FirestoreHelper.addMemberToEvent(
                              singleEvent.eventId, widget.uid);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text("Join",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        )),
                  ),
          ]),
        );
      },
    ));
  }

  bool checkIfUserIsMember(List<dynamic> members, String uid) {
    if ((members.contains(uid))) {
      return true;
    } else {
      return false;
    }
  }

  bool checkIfUserIsOwner(String eventUid, String uid) {
    if (eventUid == uid) {
      return true;
    } else {
      return false;
    }
  }
}
