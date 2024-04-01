import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/components/custom_button.dart';
import '../../../common/components/custom_textfield.dart';
import '../../../constants/global_variables.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.signUpUser,
  });

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback signUpUser;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                editingController: nameController,
                hintText: "Full Name",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                editingController: emailController,
                hintText: "E Mail",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                editingController: passwordController,
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
    );
  }
}
