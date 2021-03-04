import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projet_aald/Global.dart' as global;
import 'package:flutter/material.dart';
import 'package:projet_aald/design/ui/widgets/responsive_ui.dart';
import 'package:projet_aald/models/utilisateur.dart';

// ignore: must_be_immutable
class UserTile extends StatefulWidget {
  Utilisateur utilisateur;
  String login;
  int index;
  //
  UserTile({this.utilisateur, this.login});

  static File file;
  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool valProfile = false;
  String urlProfile;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    //global.affichageImg("profileUser/path_img.jpg");
    for (var d in global.profileList) {
      if (d.login.compareTo(widget.login) == 0) {
        urlProfile = d.url;
        valProfile = true;
      }
    }
    return global.profileList.length < 1
        ? Container(
            child: SpinKitFadingCircle(
              color: Colors.brown[200],
              // size:10 ,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              margin: EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: ClipOval(
                      child: CircleAvatar(
                        child: valProfile
                            ? Image.network(
                                urlProfile,
                                fit: BoxFit.cover,
                              )
                            : Image.asset("assets/images/logoAALD.jpg"),
                        radius: 25.0,
                        backgroundColor: widget.utilisateur.onLine
                            ? Colors.green[300]
                            : Colors.grey[300], //membre.cotisation
                      ),
                    ),
                    title: Text(widget.utilisateur.prenom +
                        " " +
                        widget.utilisateur.nom.toString()),
                    subtitle: Text('${widget.utilisateur.contact} '),
                    trailing: estIlonLine(widget.utilisateur.onLine),
                  ),
                ],
              ),
            ));
  }

  Widget estIlonLine(bool checkBoxValue) {
    return ClipOval(
      child: Container(
        width: 50,
        height: 50,
        color: widget.utilisateur.onLine ? Colors.green[300] : Colors.grey[300],
        child: checkBoxValue
            ? Center(child: Text("on line"))
            : Center(child: Text("off line")),
      ),
      // title: checkBoxValue ? Text("on line") : Text("out line")
    );
  }
}

/*
    return DataTable(
      columns: [
        DataColumn(label: Text('Prenom')),
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Contact')),
        // DataColumn(label: Text('cotisation')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text(widget.membre.prenom)),
          DataCell(Text(widget.membre.nom)),
          DataCell(Text(widget.membre.contact)),
          // DataCell(Text(widget.membre.cotisation.toString())),
        ]),
      ],
    );
    */
