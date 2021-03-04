import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projet_aald/models/utilisateur.dart';

import 'package:projet_aald/models/user.dart';
import 'package:projet_aald/Global.dart' as global;

class DatabaseUser {
  final String uid;
  DatabaseUser({this.uid});
  // collection reference of membre
  final CollectionReference userCollection =
      Firestore.instance.collection('Utilisateur');

  final CollectionReference descriptionCollection =
      Firestore.instance.collection('Information');

// update
  Future<void> updateUserData(String user, String prenom, String nom,
      String contact, String url, bool onLine) async {
    return await userCollection.document(user).setData({
      'username': user,
      'prenom': prenom,
      'nom': nom,
      'contact': contact,
      'url': url,
      'onLine': onLine
    });
  }

  Future<void> onLin(String idm, bool value) async {
    return await userCollection
        .document(idm)
        .setData({'idMembre': idm, 'onLine': value});
  }

  // membre list from snapshot
  List<Utilisateur> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Utilisateur(
        username: doc.data['username'] ?? '',
        prenom: doc.data['prenom'] ?? '',
        nom: doc.data['nom'] ?? '',
        contact: doc.data['contact'] ?? '',
        url: doc.data['url'],
        onLine: doc.data['onLine'] ?? '',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      username: snapshot.data['username'],
      prenom: snapshot.data['prenom'],
      nom: snapshot.data['nom'],
      contact: snapshot.data['contact'],
      url: snapshot.data['url'],
      onLine: snapshot.data['onLine'],
    );
  }

  // get membre stream
  Stream<List<Utilisateur>> get utilisateur {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  // get membre stream

  // get membre doc stream
  Stream<UserData> get persData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  void getFileStor(String name, String defaults) async {
    StorageReference reff =
        FirebaseStorage.instance.ref().child("profileUser/$name");
    String url = (await reff.getDownloadURL()).toString();
    if (reff.getDownloadURL() != null) {
      print("url download:" + url);
      global.profi = url;
    } else
      global.profi = "profileUser/" + defaults;
  }
}
