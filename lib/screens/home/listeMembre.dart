import 'package:flutter/material.dart';
import 'package:projet_aald/models/membre.dart';
import 'package:provider/provider.dart';
//import 'membreTile.dart';

class ListeMembre extends StatefulWidget {
  @override
  _ListeMembreState createState() => _ListeMembreState();
}

class _ListeMembreState extends State<ListeMembre> {
  @override
  Widget build(BuildContext context) {
    final membres = Provider.of<List<Membre>>(context) ?? [];
    return Scaffold(
      body: Container(
          color: Colors.grey[100],
          child: ListView(
            children: <Widget>[
              Center(
                  child: Text(
                'Liste des membres',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              DataTable(
                  columns: [
                    DataColumn(
                        label: Text(
                      'Prenom',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Nom',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Contact',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'cotisation',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ],
                  rows: membres
                      .map((e) => DataRow(cells: [
                            DataCell(Text(e.prenom)),
                            DataCell(Text(e.nom)),
                            DataCell(Text(e.contact)),
                            DataCell(Text(e.cotisation ? "YES" : "NON")),
                          ]))
                      .toList())
            ],
          )),
    );
  }
}
