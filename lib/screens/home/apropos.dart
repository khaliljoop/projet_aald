import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projet_aald/Global.dart' as global;
import 'package:url_launcher/url_launcher.dart';

class Apropos extends StatefulWidget {
  @override
  _AproposState createState() => _AproposState();
}

class _AproposState extends State<Apropos> {
  // final List<String> sugars = ['0', '1', '2', '3', '4'];
  // final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(top: 5, bottom: 5),
                /* width: 120,
                height: 120,
                child: ClipOval(
                  child: logo(),
                  ),*/
                child: FlatButton(
                    color: Colors.blue,
                    onPressed: () =>
                        siteweb("whatsapp://send?phone=+221773398655"),
                    child: Text("whatsapp")),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: description(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: new IconButton(
              icon: Icon(Icons.phone),
              onPressed: () => appel("tel:+221773398655")),
          title: new Text("773398655"),
        ),
        new BottomNavigationBarItem(
          icon: new IconButton(
              icon: Icon(Icons.message),
              onPressed: () => message("sms:+221773398655")),
          title: new Text("sms"),
        ),
        new BottomNavigationBarItem(
          icon: new IconButton(
              icon: Icon(Icons.email),
              onPressed: () => email("mailto:diop25156@gmail.com")),
          title: new Text("diop25156@gmail.com"),
        ),
      ]),
    );
  }

  Widget description() {
    return Text(" AALD:Association And Liguey Darou Khoudoss. " +
        "Créer en Aout 2014 ,AALD a pour vocation de réunir la jeunesse de Darou khoudoss " +
        ".Nous voulons montrer à la population qu'à partir de 0 on peut se relever et aller de l'avant " +
        ".Le monde est en phase d'innovation et de concurrence c'est pourquoi avec les jeunes engagés et persévérants AALD sonne la cloche " +
        ". Ceci est un appel pour tout le monde de serrer la ceinture car le chemin est trop long et plein d'obstable mais qui tient le coup s'en sortira " +
        ". AALD est une structure d'entraide et de solidarité. Elle organise des seances de ''set_setal'' au sein du village,faire la cuisine aux baptemes, mariages ... " +
        "apporte de l'aide financière ou matérielle aux individus en cas de besoin " +
        ". Ce mouvement recompense les eleves qui ont très bien travaillé aux cours de l'année et organise une journée annuelle de prières dédiée aux mort au lendemain tabaski");
  }

  Widget logo() {
    return CircleAvatar(
        backgroundColor: Colors.amber,
        child: global.logoUrl == null
            ? Center(
                child: SpinKitFadingCircle(
                  color: Colors.brown[200],
                  // size:10 ,
                ),
              )
            : Image.network(
                global.logoUrl,
                fit: BoxFit.fill,
              ));
  }

  Future<void> appel(String url) async {
    //const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> siteweb(String url) async {
    //const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> message(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> email(String url) async {
    //const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
