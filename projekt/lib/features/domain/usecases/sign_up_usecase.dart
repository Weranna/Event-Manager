import 'package:projekt/features/domain/entities/user_entity.dart';
import 'package:projekt/features/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> signUp(UserEntity user) {
    return repository.signUp(user);
  }
}
