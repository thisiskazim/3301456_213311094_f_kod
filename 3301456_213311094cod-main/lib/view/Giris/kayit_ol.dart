import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pertys_pro/service/service.dart';
import 'package:pertys_pro/view/Giris/giris.dart';

void main1() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kayıt Ol',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Color.fromARGB(255, 233, 222, 222),
              ),
            ),
            title: Text("Kayıt Ol",
                style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white)),
          ),
          body: RegisterHome()),
    );
    ;
  }
}

class RegisterHome extends StatelessWidget {
  const RegisterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return _RegisterHome(context);
  }
}

TextEditingController emailText = TextEditingController();
TextEditingController kullaniciadiText = TextEditingController();
TextEditingController parolaText = TextEditingController();
TextEditingController tryparolaText = TextEditingController();
FirabaseServis _authServis = FirabaseServis();

Widget _RegisterHome(BuildContext context) {
  final kullaniciadiField = TextField(
    controller: kullaniciadiText,
    decoration: InputDecoration(
        prefix: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Kullanıcı Adı",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );
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
  final tryparolaField = TextField(
    controller: tryparolaText,
    obscureText: true,
    decoration: InputDecoration(
        prefix: const Icon(Icons.password_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Tekrar Parola",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final kayitolButon = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Colors.brown,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      onPressed: () {
        if (parolaText.text == tryparolaText.text) {
          _authServis
              .register(emailText.text, kullaniciadiText.text, parolaText.text)
              .then((value) {
            Fluttertoast.showToast(
                msg: "Kaydedildi..",
                timeInSecForIosWeb: 3,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 20);

            return Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Login())));
          }).catchError((error) {
            if (error.toString().contains('email-already-in-use')) {
              Fluttertoast.showToast(
                  msg: "Zaten böyle bir kullanıcı mevcut",
                  timeInSecForIosWeb: 3,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red[400],
                  textColor: Colors.white,
                  fontSize: 20);
            }
          });
        } else
          Fluttertoast.showToast(
              msg: "Parola Eşleşmiyor",
              timeInSecForIosWeb: 3,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red[400],
              textColor: Colors.white,
              fontSize: 20);
      },
      child: Text(
        "Kayıt Ol",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
      ),
    ),
  );

  return Center(
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            kullaniciadiField,
            SizedBox(height: 10),
            emailField,
            SizedBox(height: 10),
            parolaField,
            SizedBox(height: 10),
            tryparolaField,
            SizedBox(height: 15),
            kayitolButon,
          ],
        ),
      ),
    ),
  );
}
