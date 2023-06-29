import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? username;
  final String? email;
  final String? password;
  final String? uid;

  const UserEntity({this.username, this.email, this.password, this.uid});

  @override
  List<Object?> get props => [username, email, password, uid];
}
