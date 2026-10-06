import 'package:domestic_pal/screens/home_customer/home_customer.dart';
import 'package:domestic_pal/screens/home_employee/home_employee.dart';
import 'package:flutter/material.dart';

class CheckUserType extends StatelessWidget {
  final dynamic user;
  CheckUserType({this.user});
  @override
  Widget build(BuildContext context) {
    if (user.category == 'C') {
      return HomeCustomer();
    }
    return HomeEmployee();
  }
}
