import 'package:flutter/material.dart';
import 'package:pertys_pro/view/Bilgisayarlar/secondPC.dart';
import 'package:pertys_pro/view/Giris/giris.dart';
import 'package:pertys_pro/view/Telefonlar/secondTLP.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Doviz/döviz.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      title: "PertyPro",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          icon: Icon(
            Icons.logout_outlined,
            size: 30,
            color: Color.fromARGB(255, 240, 240, 227),
          ),
        ),
        centerTitle: true,
        title: Text(
          'PertysPro',
        ),
      ),
      body: Apps(),
    );
  }
}

class Apps extends StatefulWidget {
  const Apps({super.key});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.jpg",
          ),
          SizedBox(height: 20),
          newButon(context, "Telefonlar", const SecondPage(),
              Icons.phone_android_outlined),
          SizedBox(
            height: 10,
          ),
          newButon(context, "Bilgisayarlar", const SecondPagePC(),
              Icons.computer_outlined),
          SizedBox(
            height: 10,
          ),
          newButon(context, "Döviz", Doviz(), Icons.money),
        ],
      ),
    );
  }
}

Widget newButon(
    BuildContext context, String name, dynamic go, IconData iconlar) {
  return Center(
    child: ElevatedButton.icon(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => go)),
      icon: Icon(iconlar),
      label: Text(name,
          style: GoogleFonts.ubuntu(
            fontSize: 20,
            color: Colors.white,
          )),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(400, 30)),
        overlayColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
    ),
  );
}
