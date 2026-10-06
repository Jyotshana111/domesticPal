import 'package:domestic_pal/models/user.dart';
import 'package:domestic_pal/screens/hire/hire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'check_user_type.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    return (user == null)
        ? Hire()
        : CheckUserType(
            user: user,
          );
  }
}
