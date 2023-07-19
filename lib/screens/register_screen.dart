import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripmo/global/global.dart';
import 'package:tripmo/screens/main_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  bool passwordVisible = false;

  //declare global key
  final _formKey = GlobalKey<FormState>();

  //create an async function to register user
  void registerUser() async {
    //show progress dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });

    //validate form

    //create firebase user
    UserCredential result = await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text)
        .catchError((error) => Fluttertoast.showToast(msg: error.toString()));

    //create user id
    String userId = result.user!.uid;

    //create a user map in database
    Map userMap = {
      'name': nameTextEditingController.text,
      'email': emailTextEditingController.text,
      'phone': phoneTextEditingController.text,
      'address': addressTextEditingController.text,
      'password': passwordTextEditingController.text,
    };

    //create user in database
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users');
    userRef.child(userId).set(userMap);

    //assign user to current user
    currentUser = result.user;

    //navigate to home page
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));

    //show toast
    Fluttertoast.showToast(msg: 'Registration successful');
  }

  @override
  Widget build(BuildContext context) {
    //write code to detect whether screen is dark or light
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
                  width: 400,
                  child: Image.asset(
                      isDarkMode ? 'images/city.png' : 'images/city.png'),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    TextFormField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        if (text.length < 3) {
                          return 'Name must be at least 3 characters long';
                        }
                      },
                    ),
                    TextFormField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
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

                    TextFormField(
                      controller: phoneTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Phone cannot be empty';
                        }
                        if (text.length < 10) {
                          return 'Phone must be at least 10 characters long';
                        }
                      },
                    ),

                    //textformfield for address
                    TextFormField(
                      controller: addressTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        prefixIcon: Icon(
                          Icons.home,
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Address cannot be empty';
                        }
                        if (text.length < 10) {
                          return 'Address must be at least 10 characters long';
                        }
                      },
                    ),

                    //textformfield for password
                    TextFormField(
                      controller: passwordTextEditingController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color:
                              isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        if (text.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        registerUser();
                      },
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        primary:
                            isDarkMode ? Colors.amber.shade400 : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 130),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.amber.shade400
                                : Colors.blue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //write code to navigate to login screen
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.amber.shade400
                                  : Colors.blue,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        )));
  }
}
