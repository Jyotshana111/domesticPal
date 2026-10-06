import 'package:domestic_pal/screens/authenticate/register_customer.dart';
import 'package:domestic_pal/screens/authenticate/signin_customer.dart';
import 'package:flutter/material.dart';

class AuthenticateCustomer extends StatefulWidget {
  @override
  _AuthenticateCustomerState createState() => _AuthenticateCustomerState();
}

class _AuthenticateCustomerState extends State<AuthenticateCustomer> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignInCustomer(
        toggleView: toggleView,
      );
    } else {
      return RegisterCustomer(toggleView: toggleView);
    }
  }
}
