import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //create a global key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //create a boolean variable to toggle the password visibility
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    //dark them
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        //hide keyboard when user clicks on the screen
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Text(
            'Forget Password Screen',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
