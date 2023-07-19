import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripmo/global/global.dart';
import 'package:tripmo/screens/main_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool _isLoading = false;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final DatabaseReference userRef = FirebaseDatabase.instance.ref();

  bool passwordVisible = false;

  final _formkey = GlobalKey<FormState>();

  //create an async function to login user
  void _loginUser() async {
    //set loading to true
    setState(() {
      _isLoading = true;
    });

    //create a try catch block
    try {
      //use FirebaseAuth instance to signin with email and password
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text);

      //check if user is logged in
      if (firebaseAuth.currentUser != null) {
        //user successfully logged in
        //send user to main page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        Fluttertoast.showToast(msg: "Login Successful");
      } else {
        //error occured - show error to user
        Fluttertoast.showToast(msg: "Login Failed");
      }
    } catch (error) {
      //catch and print error
      print(error.toString());
      //show error to user
      Fluttertoast.showToast(msg: error.toString());
    } finally {
      //set loading back to false
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Column(
            children: [
              SizedBox(
                  height: 200,
                  child: Image.asset(
                    "images/city.png",
                    width: 390,
                    height: 250,
                    alignment: Alignment.center,
                  )),
              SizedBox(height: 20),
              Column(
                children: [
                  //textformfield for email
                  TextFormField(
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: isDarkMode ? Colors.amber.shade400 : Colors.blue,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: isDarkMode ? Colors.amber.shade400 : Colors.blue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      if (!text.contains('@')) {
                        return 'Email is invalid';
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  //textformfield for password
                  TextFormField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: isDarkMode ? Colors.amber.shade400 : Colors.blue,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: isDarkMode ? Colors.amber.shade400 : Colors.blue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (text.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  //login button
                  ElevatedButton(
                    onPressed: () {
                      _loginUser();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isDarkMode ? Colors.amber.shade400 : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(height: 20),
                  //don't have an account? sign up here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //go to register screen
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
