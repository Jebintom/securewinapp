import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedUserType = 'Select'; // Default value
  String _username = '';
  String _password = '';

  // Function to authenticate user
  Future<void> _login() async {
    // Validate input fields
    if (_username.isNotEmpty && _password.isNotEmpty) {
      // Perform authentication with backend/database
      // You should implement your authentication logic here
      // For example, calling an API endpoint with the username and password
      // If authentication is successful, navigate to appropriate page
      if (_selectedUserType == 'Seller') {
        // Example: Replace the below line with your navigation logic
        Navigator.pushNamed(context, '/seller');
      } else if (_selectedUserType == 'Buyer') {
        // Example: Replace the below line with your navigation logic
        Navigator.pushNamed(context, '/buyer');
      }
    } else {
      // Show error message if fields are empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF04004B),
        title: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.7,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.7,
                child: DropdownButton<String>(
                  value: _selectedUserType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUserType = newValue!;
                    });
                  },
                  items: <String>['Select', 'Seller', 'Buyer']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.7,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF04004B)),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
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
                        color: Colors.black,
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
    );
  }
}
