import 'package:firebase_storage/firebase_storage.dart';
import 'package:projet_aald/models/profileUser.dart';

import 'models/Admin.dart';
import 'models/utilisateur.dart';

String userID = 'anonyme@gmail.com';
String profi = 'chemin';
String imageUrl;
String logoUrl;
String networkUrl;
List<String> imgList = [];
List<ProfileUser> profileList = [];
int indexProfile = 1;
List<String> descList = [];
void aaffichageImg(String name) {
  var ref = FirebaseStorage.instance.ref().child(name);
  ref.getDownloadURL().then((loc) {
    if (ref.getDownloadURL() != null) {
      //networkUrl = loc;
    }
  });
  //print("chemin dm : " + global.imageUrl.toString());
}

bool valeurAdmin = false;
String usn = "usn";
String pwd = "pwd";
List<Admin> administrator = [];

List<Utilisateur> userList = [];
