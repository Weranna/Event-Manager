import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projekt/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:projekt/features/presentation/cubit/credential/credential_cubit.dart';

import 'package:projekt/features/presentation/pages/login_page.dart';
import 'package:projekt/features/presentation/pages/main_page.dart';
import 'injection_container.dart' as di;
import 'package:projekt/on_generate_route.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<CredentialCubit>(create: (_) => di.sl<CredentialCubit>()),
      ],
      child: MaterialApp(
          title: 'Event Manager',
          theme: ThemeData(
              primarySwatch: Colors.pink,
              scaffoldBackgroundColor: const Color.fromARGB(255, 56, 56, 56)),
          onGenerateRoute: OnGenerateRoute.route,
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is AuthenticatedState) {
                    return MainPage(uid: authState.uid);
                  } else {
                    return const LoginPage();
                  }
                },
              );
            }
          }),
    );
  }
}
