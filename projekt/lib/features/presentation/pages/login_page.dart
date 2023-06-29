// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projekt/const.dart';
import 'package:projekt/features/domain/entities/user_entity.dart';
import 'package:projekt/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:projekt/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:projekt/features/presentation/pages/main_page.dart';

import 'package:projekt/features/presentation/widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldGlobalKey =
      GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isObscureText = true;
  static const snackBarEmail = SnackBar(
    content: Text('Invalid email'),
    backgroundColor: Colors.red,
  );
  static const snackBarPassword = SnackBar(
    content: Text('Invalid password'),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        builder: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is AuthenticatedState) {
                return MainPage(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            });
          }
          return _bodyWidget();
        },
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            return;
          }
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const HeaderWidget(title: 'Login'),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "EMAIL",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email)),
                  controller: _emailController,
                )),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: isObscureText,
                  decoration: InputDecoration(
                      labelText: "PASSWORD",
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          child: Icon(isObscureText == false
                              ? Icons.visibility
                              : Icons.visibility_off))),
                  controller: _passwordController,
                )),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: () {
                    _submitSignIn();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Text("Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  )),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Register ",
                        style: TextStyle(color: Colors.white)),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, PageConst.registerPage, (route) => false);
                      },
                      child: const Text(
                        "here!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.pink),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _submitSignIn() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarEmail);
      return;
    }
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarPassword);
      return;
    }
    BlocProvider.of<CredentialCubit>(context).submitSignIn(
        user: UserEntity(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}
