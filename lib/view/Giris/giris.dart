import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pertys_pro/main.dart';
import 'package:pertys_pro/service/service.dart';
import 'package:pertys_pro/view/Bilgisayarlar/secondPC.dart';
import 'package:pertys_pro/view/Bilgisayarlar/thirdPC.dart';
import 'package:pertys_pro/view/Giris/kayit_ol.dart';
import 'package:pertys_pro/view/Telefonlar/secondTLP.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GirisHome());
  }
}

class GirisHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _GirisHome(context);
  }
}

var yaziTipi = GoogleFonts.ubuntu(fontSize: 20, color: Colors.white);
TextEditingController emailText = TextEditingController();
TextEditingController kullaniciadiText = TextEditingController();
TextEditingController parolaText = TextEditingController();
FirabaseServis _authServis = FirabaseServis();

void loginFonksiyon(BuildContext context) {
  _authServis.signIn(emailText.text, parolaText.text).then((value) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ));
  }).catchError((dynamic error) {
    if (error.code.contains('invalid-email')) {
      Fluttertoast.showToast(
          msg: "Geçersiz mail adresi girdiniz. ('örnek@gmail.com')",
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
          fontSize: 20);
    }

    if (error.code.contains('user-not-found')) {
      Fluttertoast.showToast(
          msg: "Böyle bir kullanıcı bulunamadı",
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
          fontSize: 20);
    }

    if (error.code.contains('wrong-password')) {
      Fluttertoast.showToast(
          msg: "Kullanıcı adı veya parola yanlış",
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
          fontSize: 20);
    }
  });
}

Widget _GirisHome(BuildContext context) {
  final emailField = TextField(
    controller: emailText,
    decoration: InputDecoration(
        prefix: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "E-Mail",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final parolaField = TextField(
    controller: parolaText,
    obscureText: true,
    decoration: InputDecoration(
        prefix: const Icon(Icons.password_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Parola",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final girisButon = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Colors.brown,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      onPressed: () {
        loginFonksiyon(context);
      },
      child: const Text(
        "Giriş Yap",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
      ),
    ),
  );

  final kayitolButon = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Colors.brown,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(),
            ));
      },
      child: Text(
        "Kayıt Ol",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
      ),
    ),
  );

  return Scaffold(
    body: SingleChildScrollView(
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/logo.jpg",
                ),
                SizedBox(height: 20),
                emailField,
                SizedBox(height: 10),
                parolaField,
                SizedBox(height: 15),
                girisButon,
                SizedBox(height: 10),
                kayitolButon,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
