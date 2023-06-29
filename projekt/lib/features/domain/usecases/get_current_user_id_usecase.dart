import 'package:projekt/features/domain/repositories/firebase_repository.dart';

class GetCurrentUserIdUseCase {
  final FirebaseRepository repository;

  GetCurrentUserIdUseCase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUserId();
  }
}
