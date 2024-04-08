import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Forgotpassword.dart';
import 'package:flutter_application_1/seller_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String _email="",_password="";
  String _selectedUserType = 'Select'; // Default value
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function for user login
  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => SellerPage())); // Navigate to SellerPage
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Account not found",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // Handle wrong password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong password",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF04004B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF04004B),
        title: const Text('Login', style: TextStyle(color: Color.fromARGB(255, 248, 244, 244))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter e-mail';
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedUserType,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUserType = newValue!;
                        });
                      },
                      items: <String>['Select', 'Seller', 'Buyer'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: value == 'Select' ? const Color.fromARGB(255, 0, 0, 0) : null,
                            ),
                          ),
                        );
                      }).toList(),
                      underline: Container(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    width: screenWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // setState(() {
                          //   _email = _emailController.text;
                          //   _password = _passwordController.text;
                          // });
                         // Navigator.push(context, MaterialPageRoute(builder: ((context) => SellerPage())));
                          if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          // Proceed with signup
                          // if (_selectedUserType == 'Seller') {
                          //   Navigator.pushNamed(context, '/seller');
                          // } else if (_selectedUserType == 'Buyer') {
                          //   Navigator.pushNamed(context, '/buyer');
                          // }
                          userLogin();
                        } else {
                          // Show error message
                        }
                      }},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black,
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 236, 236, 237),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "Signup",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/signup');
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
