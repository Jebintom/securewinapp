import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedUserType = 'UserType'; // Default value
  String _agencyNo = ''; // Agency number field value
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _showAgencyField = false; // Whether to show the agency number field

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF04004B),
        title: const Text('Signup', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.7,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
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
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.7,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.7,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'District',
                    ),
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
                        if (_selectedUserType == 'Seller') {
                          _showAgencyField = true;
                        } else {
                          _showAgencyField = false;
                        }
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
                if (_showAgencyField)
                  Container(
                    width: screenWidth * 0.7,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _agencyNo = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Agency Number',
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate input fields
                      if (_email.isNotEmpty &&
                          _password.isNotEmpty &&
                          _confirmPassword.isNotEmpty &&
                          _password == _confirmPassword) {
                        // Proceed with signup
                        if (_selectedUserType == 'Seller') {
                          Navigator.pushNamed(context, '/seller');
                        } else if (_selectedUserType == 'Buyer') {
                          Navigator.pushNamed(context, '/buyer');
                        }
                      } else {
                        // Show error message
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill all fields and ensure passwords match.'),
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
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF04004B)),
                    ),
                    child: Text(
                      'Signup',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
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
