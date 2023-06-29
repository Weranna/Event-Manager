import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projekt/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? username,
    final String? email,
    final String? password,
    final String? uid,
  }) : super(
          username: username,
          email: email,
          password: password,
          uid: uid,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      username: snapshot.get('username'),
      email: snapshot.get('email'),
      uid: snapshot.get('uid'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'email': email,
      'uid': uid,
    };
  }
}
