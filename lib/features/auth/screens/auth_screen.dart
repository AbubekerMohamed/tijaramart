import 'package:flutter/material.dart';
import 'package:tijaramart/common/utils/screen_size_config.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/auth/components/sign_in_page.dart';
import 'package:tijaramart/features/auth/components/sign_up_page.dart';
import 'package:tijaramart/features/auth/services/auth_service.dart';

import '../components/social_auths.dart';
import '../components/social_icons_card.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: ScreenSizeConfig.screenHeight * 0.06),
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
                SizedBox(height: ScreenSizeConfig.screenHeight * 0.06),
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
                SizedBox(height: ScreenSizeConfig.screenHeight * 0.08),
                const SocialAuths(),
                SizedBox(height: ScreenSizeConfig.screenHeight * 0.08),
                _auth == Auth.signin
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account? ",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                          GestureDetector(
                            onTap: () => setState(
                              () {
                                _auth = Auth.signup;
                              },
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                          GestureDetector(
                            onTap: () => setState(
                              () {
                                _auth = Auth.signin;
                              },
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
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
