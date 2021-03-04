/*import 'package:projet_aald/services/auth.dart';
import 'package:projet_aald/shared/constants.dart';
import 'package:projet_aald/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              title: Text("S'inscrire dans AALD"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Se connecter"),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'password'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
*/

import 'dart:io';
import 'package:projet_aald/Global.dart' as global;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_aald/design/ui/widgets/custom_shape.dart';
import 'package:projet_aald/design/ui/widgets/customappbar.dart';
import 'package:projet_aald/design/ui/widgets/responsive_ui.dart';
import 'package:projet_aald/models/utilisateur.dart';
import 'package:projet_aald/services/databaseUser.dart';
import 'package:projet_aald/services/auth.dart';
import 'package:projet_aald/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  // String email = '';
  String password = '';
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  File img;
  final picker = ImagePicker();
  String password2;
  String username = '';
  String prenom = '';
  String nom = '';
  String contact = '';
  String url;
  bool cotisation = false;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return loading
        ? Loading()
        : Material(
            child: Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text("S'inscrire dans AALD"),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text("Se connecter"),
                    onPressed: () => widget.toggleView(),
                  ),
                ],
              ),
              body: Container(
                height: _height,
                width: _width,
                margin: EdgeInsets.only(bottom: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Opacity(opacity: 0.88, child: CustomAppBar()),
                      clipShape(),
                      form(),
                      SizedBox(
                        height: _height / 35,
                      ),
                      button(),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  child: Center(
                    child: ClipOval(
                      child: img != null
                          ? Image.file(img, width: 120, height: 100)
                          : Text("selct img"),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      getImage();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormFieldConfirm(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (val) => val.isEmpty ? 'Entrer un prenom' : null,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.orange[200], size: 20),
          hintText: "prenom",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) => setState(() => prenom = value.toString()),
      ),
    );
  }

  Widget lastNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Entrer un nom' : null,
        keyboardType: TextInputType.text,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.orange[200], size: 20),
          hintText: "nom",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) => setState(() => nom = value.toString()),
      ),
    );
  }

  Widget emailTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Entrer une adresse mail' : null,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.orange[200], size: 20),
          hintText: "e-mail",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) => setState(() => username = value.toString()),
      ),
    );
  }

  Widget phoneTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Entrer votre numero' : null,
        keyboardType: TextInputType.number,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone, color: Colors.orange[200], size: 20),
          hintText: "mobile number",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) => setState(() => contact = value.toString()),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Entrer un mot de passe' : null,
        obscureText: true,
        keyboardType: TextInputType.text,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.orange[200], size: 20),
          hintText: "password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) => setState(() => password = value.toString()),
      ),
    );
  }

  Widget passwordTextFormFieldConfirm() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        validator: (val) => val.compareTo(password) != 0
            ? 'les 2 mot de passe ne correspondent pas'
            : null,
        obscureText: true,
        keyboardType: TextInputType.text,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.orange[200], size: 20),
          hintText: "confirm password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) => setState(() => password2 = value.toString()),
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        // print("Routing to your account");
        if (_formKey.currentState.validate()) {
          if (username.isEmpty ||
              prenom.isEmpty ||
              nom.isEmpty ||
              contact.isEmpty) {
            print("veuillez remplir tous les champs");
          } else {
            if (password.compareTo(password2) == 0) {
              dynamic result =
                  await _auth.registerWithEmailAndPassword(username, password);
              if (result == null) {
                setState(() {
                  loading = false;
                  error =
                      'Veuillez verifier votre connexion ou entrer un email valide';
                });
              } else {
                String user = prenom + "_" + nom + "_" + contact;
                setState(() {
                  global.userID = username;
                  global.indexProfile = global.indexProfile + 1;
                });

                url = "profileUser/a" +
                    global.indexProfile.toString() +
                    "_$user.jpg";
                upLoadProfile(url.trim(), img);
                DatabaseUser(uid: username)
                    .updateUserData(username, prenom, nom, contact, url, true);
                print(" create count : " + username + ":" + prenom + ":" + nom);
                global.userList.add(new Utilisateur(
                    username: username,
                    prenom: prenom,
                    nom: nom,
                    contact: contact,
                    url: url,
                    onLine: true));

                setState(() {
                  global.userID = username;
                  loading = true;
                });
              }
            } else {} //pass!=pass2
          }

          // url = "profileUser/" + prenom + "" + nom + "" + contact;

        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "S'inscrire",
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      img = File(pickedFile.path);
      //url = pickedFile.path.toString();
    });
  }

  upLoadProfile(String name, File file) async {
    StorageReference ref = FirebaseStorage.instance.ref().child("$name");
    StorageUploadTask uploadTask = ref.putFile(file);
    if (uploadTask != null) {
      print("file uploaded");
    }
  }
}
