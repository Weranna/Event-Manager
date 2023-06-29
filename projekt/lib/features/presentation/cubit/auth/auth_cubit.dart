import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projekt/features/domain/usecases/get_current_user_id_usecase.dart';
import 'package:projekt/features/domain/usecases/is_sign_in_usecase.dart';
import 'package:projekt/features/domain/usecases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUserIdUseCase getCurrentUserIdUseCase;
  final SignOutUseCase signOutUseCase;
  AuthCubit(
      {required this.getCurrentUserIdUseCase,
      required this.isSignInUseCase,
      required this.signOutUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();
      if (isSignIn) {
        final uid = await getCurrentUserIdUseCase.call();
        emit(AuthenticatedState(uid: uid));
      } else {
        emit(UnAuthenticatedState());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUserIdUseCase.call();

      emit(AuthenticatedState(uid: uid));
    } catch (_) {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> loggedOut() async {
    try {
      signOutUseCase.signOut();

      emit(UnAuthenticatedState());
    } catch (_) {
      emit(UnAuthenticatedState());
    }
  }
}
