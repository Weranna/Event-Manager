import 'package:projekt/features/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  Future<void> getCreateCurrentUser(UserEntity user);
  Future<String> getCurrentUserId();
}
