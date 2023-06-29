import 'package:projekt/features/domain/entities/user_entity.dart';
import 'package:projekt/features/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> getCreateCurrentUser(UserEntity user) {
    return repository.getCreateCurrentUser(user);
  }
}
