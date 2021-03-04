import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_aald/design/ui/widgets/custom_shape.dart';
import 'package:projet_aald/design/ui/widgets/customappbar.dart';
import 'package:projet_aald/design/ui/widgets/responsive_ui.dart';
import 'package:projet_aald/services/databaserMember.dart';
//import 'package:projet_aald/services/databaseUser.dart';

class Addmembre extends StatefulWidget {
  @override
  _AddmembreState createState() => _AddmembreState();
}

class _AddmembreState extends State<Addmembre> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  //ùùùùùùùùùùùùùùùù
  final _formKey = GlobalKey<FormState>();
  String error = '';
  //bool loading = false;
  // text field state
  File img;
  final picker = ImagePicker();
  String password;
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

    return Material(
      child: Scaffold(
        /*
        appBar: AppBar(
          centerTitle: true,
          title: Text("Enregistrer de nouveaux membres"),
        ),
        */
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                // clipShape(),
                form(),

                SizedBox(
                  height: _height / 35,
                ),
                button(),
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
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: Container(
                    child: img != null
                        ? Image.file(
                            img,
                            width: 120,
                            height: 120,
                          )
                        : Text("selct img"),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      //  getImage();
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
            Text("Formulaire d'ajout de nouveau membre"),
            SizedBox(height: _height / 60.0),
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
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
          hintText: "firstName",
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
          hintText: "lastName",
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

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        // print("Routing to your account");
        if (_formKey.currentState.validate()) {
          if (prenom.isEmpty || nom.isEmpty || contact.isEmpty) {
            print("veuillez remplir tous les champs");
          } else {
            String idm = prenom + "_" + nom + "_" + contact;
            DatabaseMember(uid: idm)
                .updateMembreData(idm, prenom, nom, contact, false);
            print(" create count : " + username + ":" + prenom + ":" + nom);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addmembre()));
          }
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
          'Enregistrer',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }
}
