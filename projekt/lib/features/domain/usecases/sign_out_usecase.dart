import 'package:projekt/features/domain/repositories/firebase_repository.dart';

class SignOutUseCase {
  final FirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> signOut() {
    return repository.signOut();
  }
}
