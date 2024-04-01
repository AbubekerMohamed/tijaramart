import 'package:flutter/material.dart';
import 'package:tijaramart/common/utils/screen_size_config.dart';
import 'package:tijaramart/constants/global_variables.dart';

import '../../../common/components/custom_button.dart';
import '../../../common/components/custom_textfield.dart';

class SignInPage extends StatelessWidget {
  SignInPage({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.signInUser,
    required this.rememberMe,
    required this.updateRememberMe,
  });
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback signInUser;
  final Function(bool?) updateRememberMe;
  final bool rememberMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      child: Form(
        key: _signInFormKey,
        child: Column(
          children: [
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
              text: "Sign In",
              onPressed: () {
                if (_signInFormKey.currentState!.validate()) {
                  signInUser();
                }
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  activeColor: kPrimaryColor,
                  onChanged: (value) => updateRememberMe(value),
                ),
                const Text("Remember me"),
                const Spacer(),
                GestureDetector(
                  onTap: () => {
                    // Navigator.pushNamed(
                    //   context, ForgotPasswordScreen.routeName);
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
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
