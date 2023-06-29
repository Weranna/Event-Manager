import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String? eventId;
  final String? title;
  final String? description;
  final String? date;
  final String? localization;
  final String? discipline;
  final String? uid;
  final List<String?>? members;

  EventModel({
    this.eventId,
    this.title,
    this.description,
    this.date,
    this.localization,
    this.discipline,
    this.uid,
    this.members,
  });

  factory EventModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return EventModel(
      eventId: snapshot['eventId'],
      title: snapshot['title'],
      description: snapshot['description'],
      date: snapshot['date'],
      localization: snapshot['localization'],
      discipline: snapshot['discipline'],
      uid: snapshot['uid'],
      members: List<String>.from(snap['members']),
    );
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'title': title,
        'description': description,
        'date': date,
        'localization': localization,
        'discipline': discipline,
        'uid': uid,
        'members': members,
      };

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['eventId'],
      title: map['title'],
      members: List<String>.from(map['members']),
    );
  }
}
