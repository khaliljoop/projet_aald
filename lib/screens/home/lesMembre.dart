import 'package:projet_aald/models/membre.dart';
import 'package:projet_aald/screens/home/listeMembre.dart';
import 'package:flutter/material.dart';
import 'package:projet_aald/services/databaserMember.dart';
import 'package:provider/provider.dart';

class LesMembres extends StatefulWidget {
  @override
  _LesMembresState createState() => _LesMembresState();
}

class _LesMembresState extends State<LesMembres> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Membre>>.value(
      value: DatabaseMember().membre,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          body: Container(
            child: ListeMembre(),
          )),
    );
  }
}
