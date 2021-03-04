class User {
  final String uid;
  final String login;

  User({this.uid, this.login});
}

class UserData {
  final String username;
  final String prenom;
  final String nom;
  final String contact;
  final String url;
  final bool onLine;

  UserData(
      {this.username,
      this.prenom,
      this.nom,
      this.contact,
      this.url,
      this.onLine});
}
