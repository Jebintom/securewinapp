import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email="";
  TextEditingController _emailController=new TextEditingController();
  final _formKey =GlobalKey<FormState>();
  resetPassword()async{
   try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email:_email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
    Text("password Reset has been send",
    style: TextStyle(fontSize: 18.0),)));
   }on FirebaseAuthException catch(e){
    if(e.code=="user_not_found"){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('no user found for the email," ${_emailController.text}'),
      ),
    );
    }
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock),
            SizedBox(width: 8),
            Text('Forgot Password', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 1, 0, 20),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Image.asset('logo.png'),
            SizedBox(height: 20),
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _emailController,
                 validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter e-mail';
                        }
                        return null;
                      },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendResetPasswordEmail(context);
              },
              child: Text('Send Reset Email'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendResetPasswordEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reset password email sent to ${_emailController.text}'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ForgotPassword(),
  ));
}
