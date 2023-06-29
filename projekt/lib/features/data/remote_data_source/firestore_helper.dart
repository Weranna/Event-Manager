import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projekt/features/data/remote_data_source/models/event_model.dart';

class FirestoreHelper {
  static Future deleteEvent(eventId) async {
    final eventCollectionRef = FirebaseFirestore.instance.collection("events");

    eventCollectionRef.doc(eventId).get().then((event) {
      if (event.exists) {
        eventCollectionRef.doc(eventId).delete();
      }
      return;
    });
  }

  static Future addMemberToEvent(String eventId, String uid) async {
    final eventCollection = FirebaseFirestore.instance.collection("events");
    final eventDoc = await eventCollection.doc(eventId).get();

    if (eventDoc.exists) {
      final List<dynamic> members = eventDoc.data()!['members'] ?? [];
      members.add(uid);

      await eventCollection.doc(eventId).update({'members': members});
    } else {}
  }

  static Future removeMemberFromEvent(String eventId, String uid) async {
    final eventCollection = FirebaseFirestore.instance.collection("events");
    final eventDoc = await eventCollection.doc(eventId).get();

    if (eventDoc.exists) {
      final List<dynamic> members = eventDoc.data()!['members'] ?? [];
      members.remove(uid);

      await eventCollection.doc(eventId).update({'members': members});
    } else {}
  }

  static Stream<List<EventModel>> readSingle(String eventId) {
    final eventCollection = FirebaseFirestore.instance
        .collection("events")
        .where("eventId", isEqualTo: eventId);
    return eventCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => EventModel.fromSnapshot(e)).toList());
  }

  static Stream<List<EventModel>> read() {
    final eventCollection = FirebaseFirestore.instance.collection("events");
    return eventCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => EventModel.fromSnapshot(e)).toList());
  }

  static Future create(EventModel event) async {
    final eventCollection = FirebaseFirestore.instance.collection("events");

    final eventId = eventCollection.doc().id;
    final docRef = eventCollection.doc(eventId);

    final newEvent = EventModel(
      eventId: eventId,
      title: event.title,
      description: event.description,
      date: event.date,
      localization: event.localization,
      discipline: event.discipline,
      uid: event.uid,
      members: [event.uid],
    ).toJson();

    try {
      await docRef.set(newEvent);
    } catch (e) {
      print("some error occured while sending data$e");
    }
  }
}
