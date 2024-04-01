import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/components/custom_button.dart';
import '../../../common/components/custom_textfield.dart';
import '../../../common/utils/screen_size_config.dart';
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
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      child: Form(
        key: _signUpFormKey,
        child: Column(
          children: [
            CustomTextField(
              validateField: (val) {
                if (val == null || val.isEmpty) {
                  return "your full name is required";
                } else if (val.length < 6) {
                  return "full name field must be at least 4 characters";
                }
                return null;
              },
              editingController: nameController,
              hintText: "Full Name",
              iconPath: "assets/icons/User Icon.svg",
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            CustomTextField(
              validateField: (val) {
                if (val == null || val.isEmpty) {
                  return "email field is required";
                } else if (!emailValidatorRegExp.hasMatch(val)) {
                  return "email entered is not a correct email";
                }
                return null;
              },
              editingController: emailController,
              hintText: "E Mail",
              iconPath: 'assets/icons/Mail.svg',
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            CustomTextField(
              validateField: (val) {
                if (val == null || val.isEmpty) {
                  return "password field is required";
                } else if (val.length < 6) {
                  return "password must be at least 6 characters";
                }
                return null;
              },
              editingController: passwordController,
              hintText: "Password",
              iconPath: 'assets/icons/Lock.svg',
              isObscureText: true,
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            CustomButton(
              text: "Sign Up",
              onPressed: () {
                if (_signUpFormKey.currentState!.validate()) {
                  signUpUser();
                }
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
          ],
        ),
      ),
    );
  }
}
