import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedUserType = 'Select'; // Default value
  String _agencyNo = ''; // Agency number field value
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
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
                      setState(() {
                        if (_selectedUserType == 'Seller') {
                           Navigator.pushNamed(context, '/seller');
                        } else if (_selectedUserType == 'Buyer') {
                           Navigator.pushNamed(context, '/buyer');
                          }
                        });
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
    );
  }
}
