import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_aald/Global.dart' as global;
import 'package:projet_aald/screens/home/apropos.dart';
import 'package:projet_aald/screens/home/home.dart';
import 'Add_membre.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeMember extends StatefulWidget {
  @override
  _HomeMemberState createState() => _HomeMemberState();
}

class _HomeMemberState extends State<HomeMember> {
  // File _image = File("assets/images/a4.jpg");
  // final AuthService _auth = AuthService();
  final picker = ImagePicker();

  List img = [
    "assets/aaldIMG/a1.jpg",
    "assets/aaldIMG/a2.jpg",
    "assets/aaldIMG/a3.jpg",
    "assets/aaldIMG/a4.jpg",
    "assets/aaldIMG/a5.jpg",
    "assets/aaldIMG/a6.jpg",
    "assets/aaldIMG/a7.jpg",
    "assets/aaldIMG/a8.jpg",
    "assets/aaldIMG/a9.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 1,
        children: <Widget>[
          /*
          Container(
            //color: Colors.green[200],
            child: Text("AALD: Association And Liguey Darou Khoudoss"),
          ),*/
          Container(
            margin: EdgeInsets.only(top: 10),
            child: global.imgList.length >= 1
                ? listIMG(global.imgList)
                : chargement(),
          ),
          Card(
           // margin: EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0.0),
            child: Center(
              child: description(),
            ),
          ),
        ],
      ),

      //Text('home'),
    );
  }

  Widget listIMG(List img) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: img.length,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          //height: (MediaQuery.of(context).size.width * 3) / 4,
          margin: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(
                color: Colors.white12,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: EdgeInsets.all(5),
          child: Image.network(global.imgList[position]),
        );
      },
    );
  }

  Widget chargement() {
    return Card(
      color: Colors.white,
      child: Center(
        child: CircleAvatar(
            // backgroundColor: Colors.amber,
            child: Center(
          child: SpinKitFadingCircle(
            color: Colors.brown[200],
            // size:10 ,
          ),
        )),
      ),
    );
  }

  Widget description() {
    return Text("AALD vous souhaite la bienvenue !");
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
                if (global.valeurAdmin) {
                  Navigator.push(this.context,
                      MaterialPageRoute(builder: (context) => Addmembre()));
                } else {
                  /*
                  Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 4),
                      content: Text("Autorisations restreintes")));
                      */
                  _dialogSimple();
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

  _dialogSimple() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Autorisation restreinte'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(this.context,
                      MaterialPageRoute(builder: (context) => HomeMember()));
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }
}
