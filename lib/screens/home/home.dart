import 'package:projet_aald/models/utilisateur.dart';
import 'package:projet_aald/screens/home/listeUser.dart';
import 'package:flutter/material.dart';
import 'package:projet_aald/services/databaseUser.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Utilisateur>>.value(
      value: DatabaseUser().utilisateur,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          body: Container(
            child: ListeUser(),
          )),
    );
  }
}
/*
 Center(
                child: Text(
              'Liste utilisateur',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
*/
/*
            Container(
               decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            ),*/
