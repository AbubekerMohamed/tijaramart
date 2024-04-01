import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/custom_button.dart';
import 'package:tijaramart/common/components/custom_textfield.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/auth/components/social_auths.dart';

import '../../../common/utils/screen_size_config.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenSizeConfig.screenHeight * 0.08),
              const ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            editingController: _emailController,
            hintText: "E - mail",
            textInputType: TextInputType.emailAddress,
            iconPath: "assets/icons/Mail.svg",
            validateField: (val) {
              if (val == null || val.isEmpty) {
                return "email field is required";
              } else if (!emailValidatorRegExp.hasMatch(val)) {
                return "email entered is not a correct email";
              }
              return null;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          CustomButton(
            text: "Continue",
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
          ),
          SizedBox(height: ScreenSizeConfig.screenHeight * 0.4),
          const SocialAuths(),
        ],
      ),
    );
  }
}

// class _ForgotPassFormState extends State<ForgotPassForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> errors = [];
//   String email;
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             onSaved: (newValue) => email = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty && errors.contains(kEmailNullError)) {
//                 setState(() {
//                   errors.remove(kEmailNullError);
//                 });
//               } else if (emailValidatorRegExp.hasMatch(value) &&
//                   errors.contains(kInvalidEmailError)) {
//                 setState(() {
//                   errors.remove(kInvalidEmailError);
//                 });
//               }
//               return null;
//             },
//             validator: (value) {
//               if (value.isEmpty && !errors.contains(kEmailNullError)) {
//                 setState(() {
//                   errors.add(kEmailNullError);
//                 });
//               } else if (!emailValidatorRegExp.hasMatch(value) &&
//                   !errors.contains(kInvalidEmailError)) {
//                 setState(() {
//                   errors.add(kInvalidEmailError);
//                 });
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               labelText: "Email",
//               hintText: "Enter your email",
//               // If  you are using latest version of flutter then lable text and hint text shown like this
//               // if you r using flutter less then 1.20.* then maybe this is not working properly
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
//             ),
//           ),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           FormError(errors: errors),
//           SizedBox(height: SizeConfig.screenHeight * 0.1),
//           DefaultButton(
//             text: "Continue",
//             press: () {
//               if (_formKey.currentState.validate()) {
//                 // Do what you want to do
//               }
//             },
//           ),
//           SizedBox(height: SizeConfig.screenHeight * 0.1),
//           NoAccountText(),
//         ],
//       ),
//     );
//   }
// }
