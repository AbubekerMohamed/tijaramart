import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/custom_button.dart';
import 'package:tijaramart/common/components/custom_textfield.dart';
import 'package:tijaramart/constants/global_variables.dart';

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
              ListTile(
                tileColor: _auth == Auth.signup ? GlobalVariables.greyBackgroundCOlor : Colors.transparent,
                title: const Text("Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: Auth.signup, 
                  groupValue: _auth, 
                  onChanged: (Auth? val){
                    setState(() {
                      _auth = val!;
                    });
                  },
                  activeColor: GlobalVariables.secondaryColor,
                ),
              ),
              if(_auth == Auth.signup) Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.greyBackgroundCOlor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        editingController: _nameController,
                        hintText: "Full Name",
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        editingController: _emailController,
                        hintText: "E Mail",
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        editingController: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(text: "Sign Up", onPressed: (){},)
                    ],
                  )
                  ),
              ),
              ListTile(
                tileColor: _auth == Auth.signin ? GlobalVariables.greyBackgroundCOlor : Colors.transparent,
                title: const Text("Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: Auth.signin, 
                  groupValue: _auth, 
                  onChanged: (Auth? val){
                    setState(() {
                      _auth = val!;
                    });
                  },
                  activeColor: GlobalVariables.secondaryColor,
                ),
              ),
              if(_auth == Auth.signin) Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.greyBackgroundCOlor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        editingController: _emailController,
                        hintText: "E Mail",
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        editingController: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(text: "Sign Up", onPressed: (){},)
                    ],
                  )
                  ),
              ),
            ],
          ),
        )
        ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}