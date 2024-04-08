import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/buyer_page.dart';
import 'package:flutter_application_1/seller_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _usernameController=TextEditingController();
    TextEditingController _emailController=TextEditingController();
   //    TextEditingController _nameController=TextEditingController();

  TextEditingController _passwordController=TextEditingController();

final _formkey=GlobalKey<FormState>();
registration() async{
if(_password!=null&& _usernameController.text!=""&&_emailController.text!=""){
try{
  UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(
      "Registered Successfully!!!",
      style: TextStyle(fontSize: 20.0),
      )
      )
      );
    if(_selectedUserType=='Buyer'){
      Navigator.push(
    context, MaterialPageRoute(builder: (context)=>BuyerPage()
    )
    );
    }else if(_selectedUserType=='Seller'){
      Navigator.push(
    context, MaterialPageRoute(builder: (context)=>SellerPage()
    )
    );
    }
  
}on FirebaseAuthException catch(e){
 if(e.code=='weak-password'){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor:Colors.orangeAccent,
    content:  Text("Password is too weak!!",
    style: TextStyle(fontSize: 20.0))
  ),
  );

 }else if(e.code=="email-alread exist"){
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor:Colors.orangeAccent,
    content:  Text("account already exist",
    style: TextStyle(fontSize: 20.0))));
 }
 
}
}
}
@override
void dispose(){
  _usernameController.dispose();
  _emailController.dispose();
  _passwordController.dispose();
  //_usernameController.dispose();
  super.dispose();
}
  String _selectedUserType = 'Select'; // Default value
  String _agencyNo = ''; // Agency number field value
  String _email = '';
  String _password = '';
  String _name='';
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
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.7,
                    child: TextFormField(
                     validator:(value){
                      if(value==null||value.isEmpty){
                        return 'please enter a email';
                      }
                      return null;
                     },
                      controller: _emailController,
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
                       validator:(value){
                      if(value==null||value.isEmpty){
                        return 'please enter a name';
                      }
                      return null;
                       },
                      controller: _usernameController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: screenWidth * 0.7,
                    child: TextFormField(
                        validator:(value){
                      if(value==null||value.isEmpty){
                        return 'please enter a password';
                      }
                      return null;
                       },
                      controller: _passwordController,
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
                        validator:(value){
                      if(value==null||value.isEmpty){
                        return 'please confirm your password';
                      }
                      return null;
                       },
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
                        validator:(value){
                      if(value==null||value.isEmpty){
                        return 'please enter your age';
                      }
                      return null;
                       },
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
                        validator:(value){
                      if(value==null||value.isEmpty){
                        return 'please your District';
                      }
                      return null;
                       },
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
                          // if (_selectedUserType == 'Seller') {
                          //   Navigator.pushNamed(context, '/seller');
                          // } else if (_selectedUserType == 'Buyer') {
                          //   Navigator.pushNamed(context, '/buyer');
                          // }
                          registration();
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
                  GestureDetector(
                  child: SizedBox(height: 10)),
                  GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          _email=_emailController.text;
                          _name=_usernameController.text;
                          _password=_passwordController.text;
                        });
                      }
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
      ),
    );
  }
}