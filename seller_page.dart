// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginPage.dart';


class SellerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 234), // Set colorful background
      appBar: AppBar(
        title: Text('Seller Page'),
        shadowColor: Color.fromRGBO(225, 225, 225, 0.936),
        actions: [TextButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()), (route) => false);
        }, child: Text('Log Out'))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewBox(),
            SizedBox(height: 20.0),
            _buildLotteryCategory(context, 'Kerala Weekly Lotteries', [
              LotteryTicket('WIN-WIN', '40', '₹75 Lakhs'),
              LotteryTicket('STHREE SAKTHI', '40', '₹75 Lakhs'),
              LotteryTicket('FIFTY-FIFTY', '40', '₹1 Crore'),
              LotteryTicket('KARUNYA PLUS', '40', '₹80 Lakhs'),
              LotteryTicket('NIRMAL', '40', '₹70 Lakhs'),
              LotteryTicket('KARUNYA', '40', '₹80 Lakhs'),
              LotteryTicket('AKSHAYA', '40', '₹70 Lakhs'),
            ]),
            SizedBox(height: 20.0),
            _buildLotteryCategory(context, 'Bumper Lotteries', [
              LotteryTicket('Xmas New Year Lottery', '200', '₹10 Crores', drawMonth: 'January'),
              LotteryTicket('Summer Bumper Lottery', '150', '₹5 Crores', drawMonth: 'March'),
              LotteryTicket('Vishu Bumper Lottery', '150', '₹5 Crores', drawMonth: 'May'),
              LotteryTicket('Monsoon Bumper Lottery', '150', '₹5 Crores', drawMonth: 'July'),
              LotteryTicket('Onam Bumper Lottery', '200', '₹10 Crores', drawMonth: 'September'),
              LotteryTicket('Pooja Bumper Lottery', '200', '₹10 Crores', drawMonth: 'November'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildLotteryCategory(BuildContext context, String categoryTitle, List<LotteryTicket> tickets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryTitle,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: tickets.map((ticket) => _buildLotteryTicket(context, ticket)).toList(),
        ),
      ],
    );
  }

  Widget _buildLotteryTicket(BuildContext context, LotteryTicket ticket) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 24.0,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Ticket Price (Rs): ${ticket.price}'),
              Text('Top Prize: ${ticket.topPrize}'),
              if (ticket.drawMonth != null) ...[
                SizedBox(height: 8.0),
                Text('Draw Month: ${ticket.drawMonth}'),
              ],
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the available ticket counter page for selling tickets
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AvailableTicketNumbersPage()),
                  );
                },
                child: Text('Sell'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 218, 217, 191).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color.fromARGB(255, 246, 244, 248), width: 1.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Result',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Discover your fate: View results for sold lottery tickets',
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SellerResultsPage()),
              );
            },
            child: Text('View Results'),
          ),
        ],
      ),
    );
  }
}


class LotteryTicket {
  final String name;
  final String price;
  final String topPrize;
  final String? drawMonth;

  LotteryTicket(this.name, this.price, this.topPrize, {this.drawMonth});
}

// Define other classes as before...
class AvailableTicketNumbersPage extends StatefulWidget {
  @override
  _AvailableTicketNumbersPageState createState() =>
      _AvailableTicketNumbersPageState();
}

class _AvailableTicketNumbersPageState
    extends State<AvailableTicketNumbersPage> {
  List<String> selectedNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Ticket Numbers'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of available ticket numbers
        itemBuilder: (context, index) {
          final ticketNumber = 'Ticket ${index + 1}';
          final isChecked = selectedNumbers.contains(ticketNumber);
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isChecked) {
                  selectedNumbers.remove(ticketNumber);
                } else {
                  selectedNumbers.add(ticketNumber);
                }
              });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: isChecked ? Colors.blue.withOpacity(0.1) : Colors.white,
                child: Container(
                  width: 40.0, // 2cm
                  height: 80.0, // 4cm
                  child: ListTile(
                    title: Text(
                      ticketNumber,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    trailing: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            selectedNumbers.add(ticketNumber);
                          } else {
                            selectedNumbers.remove(ticketNumber);
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: selectedNumbers.isNotEmpty
        ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuyerDetailsPage()),
           );
          },
         child: Icon(Icons.check),
        )
      : null,
    );


  }
}

class BuyerDetailsPage extends StatefulWidget {
  @override
  _BuyerDetailsPageState createState() => _BuyerDetailsPageState();
}

class _BuyerDetailsPageState extends State<BuyerDetailsPage> {
  // ignore: unused_field
  String _name = '';
  String _phoneNumber = '';
  String _otp = '';
  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Details'),
      ),
      body: _isVerified
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to the home page
                      Navigator.pop(context);
                    },
                    child: Text('Return to Home'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'Enter OTP'),
                    onChanged: (value) {
                      setState(() {
                        _otp = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Dummy logic for OTP verification, replace with actual implementation
                      _verifyOTP();
                    },
                    child: Text('Verify OTP'),
                  ),
                ],
              ),
            ),
    );
  }

  void _verifyOTP() {
    // Verify OTP logic here
    // For now, assume OTP is verified successfully
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Do you want to sell the ticket(s)?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to the tick icon page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TickIconPage()),
                );
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class TickIconPage extends StatefulWidget {
  @override
  _TickIconPageState createState() => _TickIconPageState();
}

class _TickIconPageState extends State<TickIconPage> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    // Start the animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Status'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: _isAnimated ? MediaQuery.of(context).size.height : 0,
          width: _isAnimated ? MediaQuery.of(context).size.width : 0,
          color: Colors.green.withOpacity(0.8), // Adjust the opacity and color
          child: Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _isAnimated ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ticket Sold!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to the seller page
                      Navigator.pop(context);
                    },
                    child: Text('Return to Home'),
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

class SoldTicketsResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement logic to fetch and display sold tickets' results based on their draw date
    return Scaffold(
      appBar: AppBar(
        title: Text('Sold Tickets Results'),
      ),
      body: Center(
        child: Text('Results of sold tickets based on their draw date'),
      ),
    );
  }
}


class SellerResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sold Ticket Results'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by Type or Draw Date',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Replace this with your sold ticket result items
                ListTile(
                  title: Text('Sample Ticket Result 1'),
                  subtitle: Text('Draw Date: January 1, 2024'),
                  onTap: () {
                    // Handle tapping on the sold ticket result item
                  },
                ),
                ListTile(
                  title: Text('Sample Ticket Result 2'),
                  subtitle: Text('Draw Date: January 2, 2024'),
                  onTap: () {
                    // Handle tapping on the sold ticket result item
                  },
                ),
                // Add more sold ticket result items as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
