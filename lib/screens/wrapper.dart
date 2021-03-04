import 'package:projet_aald/models/user.dart';
import 'package:projet_aald/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:projet_aald/Global.dart' as global;
import 'package:projet_aald/screens/home/Accueil.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Accueil(global.valeurAdmin, user.login);
    }
  }
}
