import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projekt/const.dart';
import 'package:projekt/features/domain/entities/user_entity.dart';
import 'package:projekt/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:projekt/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:projekt/features/presentation/pages/main_page.dart';

import 'package:projekt/features/presentation/widgets/header_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordAgainController.dispose();
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
  static const snackBarUsername = SnackBar(
    content: Text('Invalid username'),
    backgroundColor: Colors.red,
  );
  static const snackBarPasswordMatch = SnackBar(
    content: Text('Password dont match'),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamedAndRemoveUntil(
              context, PageConst.loginPage, (route) => false);
        },
        backgroundColor: Colors.pink,
        hoverColor: Colors.black,
        tooltip: 'Go Back',
        child: const Icon(
          Icons.arrow_back_rounded,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return const CircularProgressIndicator();
          }
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

  void _submitSignUp() {
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarUsername);
      return;
    }
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarEmail);
      return;
    }
    if (_passwordController.text == _passwordAgainController.text) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBarPasswordMatch);
      return;
    }
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarPassword);
      return;
    }
    BlocProvider.of<CredentialCubit>(context).submitSignUp(
        user: UserEntity(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const HeaderWidget(title: 'Register'),
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
                  decoration: const InputDecoration(
                      labelText: "USERNAME",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person)),
                  controller: _usernameController,
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
                      labelText: "PASSWORD (min. 6 characters)",
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
                margin: const EdgeInsets.only(top: 20, bottom: 40),
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
                      labelText: "PASSWORD (AGAIN)",
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
                  controller: _passwordAgainController,
                )),
            ElevatedButton(
                onPressed: () {
                  _submitSignUp();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text("Submit",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                )),
          ],
        ),
      ),
    );
  }
}
