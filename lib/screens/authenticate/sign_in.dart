import 'package:projet_aald/services/auth.dart';
import 'package:projet_aald/services/databaseUser.dart';
import 'package:projet_aald/shared/constants.dart';
import 'package:projet_aald/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:projet_aald/Global.dart' as global;

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Connexion-->AALD'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("s'inscrire"),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (val) =>
                          val.isEmpty ? 'Entrer un email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'password'),
                      validator: (val) => val.length < 6
                          ? 'Entrer un mot de pass de +6 caracteres'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Se connecter',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              global.userID = email;
                              for (var d in global.administrator) {
                                int a = d.username.compareTo(email);
                                int b = d.pass.compareTo(password);
                                if (a == 0 && b == 0) {
                                  setState(() {
                                    global.valeurAdmin = true;
                                  });
                                } else {
                                  global.valeurAdmin = false;
                                }
                              }
                              for (var d in global.userList) {
                                if (d.username.compareTo(email) == 0) {
                                  DatabaseUser(uid: email).updateUserData(
                                      d.username,
                                      d.prenom,
                                      d.nom,
                                      d.contact,
                                      d.url,
                                      true);
                                }
                              }

                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    "Veuillez verifier votre connexion ou information d'authentification";
                              });
                            } else {
                              setState(() {
                                for (var d in global.userList) {
                                  if (d.username.compareTo(email) == 0) {
                                    DatabaseUser(uid: email).updateUserData(
                                        d.username,
                                        d.prenom,
                                        d.nom,
                                        d.contact,
                                        d.url,
                                        true);
                                  }
                                }
                                global.userID = email;
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
