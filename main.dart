import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'buyer_page.dart';
import 'expired_tickets_page.dart';
import 'buyer_profile_page.dart';

import 'app_opening_page.dart' as app_opening;
import 'login_page.dart' as login;
import 'signup_page.dart' as signup;
import 'seller_page.dart' as seller;
import 'buyer_page.dart' as buyer;
import 'expired_tickets_page.dart' as expired_tickets;
import 'buyer_profile_page.dart' as buyer_profile;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => app_opening.AppOpeningPage(),
        '/login': (context) => login.LoginPage(),
        '/signup': (context) => signup.SignupPage(),
        '/seller': (context) => seller.SellerPage(),
        '/buyer': (context) => BuyerPage(),
        '/expiredTickets': (context) => ExpiredTicketsPage(),
        '/buyerProfile': (context) => BuyerProfilePage(),
      },
    );
  }
}
