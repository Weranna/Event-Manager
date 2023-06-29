import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:projekt/features/data/remote_data_source/firebase_remote_data_source.dart';
import 'package:projekt/features/data/remote_data_source/firebase_remote_data_source_impl.dart';
import 'package:projekt/features/data/repositories/firebase_repository_impl.dart';
import 'package:projekt/features/domain/repositories/firebase_repository.dart';

import 'package:projekt/features/domain/usecases/get_create_current_user_usecase.dart';
import 'package:projekt/features/domain/usecases/get_current_user_id_usecase.dart';

import 'package:projekt/features/domain/usecases/is_sign_in_usecase.dart';
import 'package:projekt/features/domain/usecases/sign_in_usecase.dart';
import 'package:projekt/features/domain/usecases/sign_out_usecase.dart';
import 'package:projekt/features/domain/usecases/sign_up_usecase.dart';
import 'package:projekt/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:projekt/features/presentation/cubit/credential/credential_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUserIdUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call()));

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
        getCreateCurrentUserUseCase: sl.call(),
      ));

  sl.registerLazySingleton<GetCurrentUserIdUseCase>(
      () => GetCurrentUserIdUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));

  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
