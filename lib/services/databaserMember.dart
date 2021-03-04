import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_aald/models/membre.dart';

class DatabaseMember {
  final String uid;
  DatabaseMember({this.uid});
  // collection reference of membre
  final CollectionReference membreCollection =
      Firestore.instance.collection('Membres');

// update
  Future<void> updateMembreData(String idm, String prenom, String nom,
      String contact, bool cotisation) async {
    return await membreCollection.document(idm).setData({
      'idMembre': idm,
      'prenom': prenom,
      'nom': nom,
      'contact': contact,
      'cotisation': cotisation
    });
  }

  Future<void> estCotiser(String idm, bool value) async {
    return await membreCollection
        .document(idm)
        .setData({'idMembre': idm, 'cotisation': value});
  }

  // membre list from snapshot
  List<Membre> _membreListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Membre(
        doc.data['idMembre'] ?? '',
        doc.data['prenom'] ?? '',
        doc.data['nom'] ?? '',
        doc.data['contact'] ?? '',
        doc.data['cotisation'] ?? '',
      );
    }).toList();
  }

  Membre _membreDataFromSnapshot(DocumentSnapshot snapshot) {
    return Membre(
      snapshot.data['idMembre'],
      snapshot.data['prenom'],
      snapshot.data['nom'],
      snapshot.data['contact'],
      snapshot.data['cotisation'],
    );
  }

  // get membre stream
  Stream<List<Membre>> get membre {
    return membreCollection.snapshots().map(_membreListFromSnapshot);
  }

  // get user doc stream
  Stream<Membre> get membreData {
    return membreCollection
        .document(uid)
        .snapshots()
        .map(_membreDataFromSnapshot);
  }
}
