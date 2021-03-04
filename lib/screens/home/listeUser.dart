import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projet_aald/models/profileUser.dart';
import 'package:projet_aald/models/utilisateur.dart';
import 'package:provider/provider.dart';
import 'package:projet_aald/Global.dart' as global;
import 'UserTile.dart';

class ListeUser extends StatefulWidget {
  @override
  _ListeUserState createState() => _ListeUserState();
}

class _ListeUserState extends State<ListeUser> {
  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<List<Utilisateur>>(context) ?? [];
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          itemCount: utilisateur.length,
          itemBuilder: (context, index) {
            affichageImg(utilisateur[index].url, utilisateur[index].username);
            return UserTile(
              utilisateur: utilisateur[index],
              login: utilisateur[index].username,
            );
          },
        ),
      ),
    );
  }

  affichageImg(String name, String log) {
    //var ch;
    var ref = FirebaseStorage.instance.ref().child(name);
    ref.getDownloadURL().then((loc) {
      if (ref.getDownloadURL() != null) {
        //networkUrl = loc;
        global.profileList.add(new ProfileUser(loc, log));

        print("chemin WWWWWWWWWWWWWWWWWWWWW:" + loc);
        //  ch = loc;
      }
    });
    //return ch;
  }
}
