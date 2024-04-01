import 'package:flutter/material.dart';
import 'package:tijaramart/common/utils/screen_size_config.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/auth/components/sign_in_page.dart';
import 'package:tijaramart/features/auth/components/sign_up_page.dart';
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
  Auth _auth = Auth.signin;

  final AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(50)),
          child: Column(
            children: [
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.04),
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              Text(
                "Sign in with your email and password  \nor continue with social media",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getProportionateScreenWidth(10)),
              ),
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.08),
              if (_auth == Auth.signup)
                SignUpPage(
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  signUpUser: signUpUser,
                ),
              if (_auth == Auth.signin)
                SignInPage(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  signInUser: signInUser,
                  rememberMe: rememberMe,
                  updateRememberMe: updateRememberMe,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateRememberMe(bool? rememberValue) {
    setState(() {
      rememberMe = rememberValue ?? false;
    });
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
