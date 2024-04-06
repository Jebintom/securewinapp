import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuyerProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace these sample values with actual user data
    String username = "John Doe";
    String district = "Calicut, Kerala, 673586";
    String phoneNumber = "1234567890";
    String dateOfBirth =
        "1994-01-01"; // Sample date string in yyyy-mm-dd format

    DateTime dobDate = DateTime.parse(dateOfBirth);
    String formattedDob = DateFormat('dd/MM/yyyy').format(dobDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF04004B), // Deep blue color
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white), // Title color white
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/def.png'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 4,
                  child: Container(
                    width: 300, // Set width to match parent
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileField(
                              Icons.person, "username", username),
                          SizedBox(height: 12), // Added gap between fields
                          _buildProfileField(
                              Icons.location_on, "address", district),
                          SizedBox(height: 12), // Added gap between fields
                          _buildProfileField(
                              Icons.phone, "phone number", phoneNumber),
                          SizedBox(height: 12), // Added gap between fields
                          _buildProfileField(Icons.cake, "date of birth",
                              formattedDob.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showChangePasswordDialog(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF04004B)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  ),
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Color.fromARGB(255, 142, 139, 139),
          size: 20,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 113, 149, 164),
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Implement your logic here to change password
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF04004B)),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: const Color.fromARGB(255, 11, 164, 16),
                size: 50,
              ),
              SizedBox(height: 10),
              Text("Password changed!!!"),
              SizedBox(height: 20), // Added space for better layout
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF04004B)),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
