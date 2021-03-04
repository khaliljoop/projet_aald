import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projet_aald/models/Admin.dart';
import 'package:projet_aald/screens/home/apropos.dart';
import 'package:projet_aald/screens/home/homeMember.dart';
import 'package:projet_aald/services/auth.dart';
import 'package:projet_aald/services/databaseUser.dart';
import 'Add_membre.dart';
import 'package:projet_aald/Global.dart' as global;
import 'package:projet_aald/screens/home/home.dart';

import 'lesMembre.dart';

class Accueil extends StatefulWidget {
  final bool b;
  final String userN;
  Accueil(this.b, this.userN);
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final AuthService _auth = AuthService();
  void initState() {
    super.initState();
    for (int i = 0; i < 52; i++) {
      var ref = FirebaseStorage.instance.ref().child("images/a$i.jpg");
      ref.getDownloadURL().then((loc) {
        if (ref.getDownloadURL() != null) {
          setState(() {
            global.imgList.add(loc);
            print("xxxxx image " + i.toString() + loc);
          });
        }
      });
    }
    // affichageImg(fileName);

    var reff = FirebaseStorage.instance.ref().child("images/profileAALD.jpg");
    reff.getDownloadURL().then((loc) => setState(() => global.logoUrl = loc));
    global.administrator.add(new Admin("admin@gmail.com", "admin000123"));
  }

  @override
  Widget build(BuildContext context) {
    String nom = '';
    String prenom = '';
    for (var u in global.userList) {
      int a = u.username.compareTo(widget.userN);
      if (a == 0) {
        nom = u.nom;
        prenom = u.prenom;
      }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Bienvenu " + prenom + " " + nom,
              style: TextStyle(
                  color: Colors.green[300], fontStyle: FontStyle.italic),
            ),
            //backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[menu()],
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                // Tab(icon: Icon(Icons.home), text: "accueil"),
                Tab(text: "accueil"),
                Tab(text: "utilisateurs"),
                Tab(text: "Liste membres"),
                Tab(text: "Ajout membre"),
                Tab(text: "a propos"),
              ],
            ),
          ),
          // drawer: drawer(),
          body: TabBarView(
            children: [
              HomeMember(),
              Home(),
              LesMembres(),
              widget.b ? Addmembre() : restriction(),
              Apropos(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('déconnecter'),
            onPressed: () async {
              for (var d in global.userList) {
                if (d.username.compareTo(widget.userN) == 0) {
                  DatabaseUser(uid: widget.userN).updateUserData(
                      d.username, d.prenom, d.nom, d.contact, d.url, false);
                }
              }
              // DatabaseUser(uid: global.userID).onLine(global.userID, false);
              print("¤¤¤¤¤¤¤¤¤¤¤¤¤¤ deconnecter " + global.userID);
              await _auth.signOut();
            },
          ),
        ),
      ],
    );
  }

  restriction() {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0.0),
            child: Container(
              child: Text(
                "Désolé l'acces est restreint \n seuls les administrateurs sont autorisés",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
            )));
  }

  Widget drawer() {
    return Drawer(
      child: Container(
        color: Colors.cyan,
        // width: 7.0,
        width: MediaQuery.of(context).size.width / 3,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Tiroir'),
              decoration: BoxDecoration(
                color: Colors.blue,
                // backgroundBlendMode: BlendMode.dstOver,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add member'),
              onTap: () {
                /*
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) => Addmembre()));
                */
                print(
                    "######################## correct : global.valeurAdmin : " +
                        global.valeurAdmin.toString());
                if (widget.b) {
                  Navigator.push(this.context,
                      MaterialPageRoute(builder: (context) => Addmembre()));
                } else {
                  /*
                  Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 4),
                      content: Text("Autorisations restreintes")));
                      */
                  // _dialogSimple();
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Liste des membres'),
              onTap: () {
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("A propos de l'AALD"),
              onTap: () {
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) => Apropos()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
   FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('déconnecter'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
*/
