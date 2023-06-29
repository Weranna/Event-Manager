import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projekt/features/domain/entities/user_entity.dart';

import 'package:projekt/features/domain/usecases/get_create_current_user_usecase.dart';

import 'package:projekt/features/domain/usecases/sign_in_usecase.dart';
import 'package:projekt/features/domain/usecases/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  CredentialCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCreateCurrentUserUseCase,
  }) : super(CredentialInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      signInUseCase.signIn(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.signUp(user);
      await getCreateCurrentUserUseCase.getCreateCurrentUser(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
