import 'package:flutter/material.dart';
import 'package:tijaramart/features/auth/components/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot_password";
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Forgot Password"),
      ),
      body: const ForgotPasswordBody(),
    );
  }
}
