import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuyerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF04004B),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("View Profile"),
                    value: "View Profile",
                  ),
                  PopupMenuItem(
                    child: Text("Expired Tickets"),
                    value: "Expired Tickets",
                  ),
                ];
              },
              onSelected: (value) {
                if (value == "View Profile") {
                  Navigator.pushNamed(context, '/buyerProfile');
                } else if (value == "Expired Tickets") {
                  Navigator.pushNamed(context, '/expiredTickets');
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  'Results on live',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF04004B), // Deep blue color
                    fontFamily: 'Roboto', // Another font family
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 150, // Set the height of both cards
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildTicketCard('Ticket Name 1', '123456', true,
                          'First Prize', '1000'),
                    ),
                    Expanded(
                      child: _buildTicketCard('Ticket Name 2', '789012', false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF04004B), // Deep blue color
                    fontFamily: 'Roboto', // Another font family
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Display upcoming tickets
            _buildUpcomingTickets(),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCard(String name, String serialNumber, bool won,
      [String prize = '', String amount = '']) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket Name: $name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Serial Number: $serialNumber'),
            SizedBox(height: 8),
            if (won && prize.isNotEmpty && amount.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prize: $prize'),
                  SizedBox(height: 8),
                  Text('Amount: $amount'),
                ],
              )
            else if (won)
              Text('Incomplete prize details')
            else
              Text('Better luck next time...'),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTickets() {
    // Replace with actual upcoming ticket data
    List<Ticket> upcomingTickets = [
      Ticket('Upcoming Ticket 1', '789123', DateTime(2024, 4, 10)),
      Ticket('Upcoming Ticket 2', '456789', DateTime(2024, 4, 15)),
    ];

    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: upcomingTickets.map((ticket) {
          String formattedDate =
              DateFormat('dd/MM/yyyy').format(ticket.resultPublishingDate);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ticket Name: ${ticket.name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Serial Number: ${ticket.serialNumber}'),
                      SizedBox(height: 8),
                      Text('Publishing Date: $formattedDate'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Ticket {
  final String name;
  final String serialNumber;
  final DateTime resultPublishingDate;

  Ticket(this.name, this.serialNumber, this.resultPublishingDate);
}
