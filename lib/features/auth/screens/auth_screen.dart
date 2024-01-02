import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/custom_button.dart';
import 'package:tijaramart/common/components/custom_textfield.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/auth/services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _auth = Auth.signup;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: _auth == Auth.signup
                            ? GlobalVariables.greyBackgroundCOlor
                            : Colors.white,
                      ),
                      child: const Text("Sign Up"),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _auth = Auth.signin;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: _auth == Auth.signin
                            ? GlobalVariables.greyBackgroundCOlor
                            : Colors.white,
                      ),
                      child: const Text("Sign In"),
                    ),
                  ),
                ],
              ),
              if (_auth == Auth.signup)
                Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.greyBackgroundCOlor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.all(8),
                  //color: GlobalVariables.greyBackgroundCOlor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            editingController: _nameController,
                            hintText: "Full Name",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            editingController: _emailController,
                            hintText: "E Mail",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            editingController: _passwordController,
                            hintText: "Password",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: "Sign Up",
                            onPressed: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.greyBackgroundCOlor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          editingController: _emailController,
                          hintText: "E Mail",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          editingController: _passwordController,
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "Sign In",
                          onPressed: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
