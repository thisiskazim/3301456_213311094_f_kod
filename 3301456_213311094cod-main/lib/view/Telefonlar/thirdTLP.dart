import 'package:flutter/material.dart';

import 'package:pertys_pro/view/main.dart';
import 'package:pertys_pro/view/Telefonlar/secondTLP.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdPageDatas extends StatefulWidget {
  final String Tname;
  final String Tram;
  final String Tkapasite;
  final String Tbatarya;
  final String Tekran;
  final String Tsistem;
  final String Tkamera;
  final String Tfiyat;
  var Ttext;

  ThirdPageDatas({
    super.key,
    required this.Tname,
    required this.Tram,
    required this.Tkapasite,
    required this.Tbatarya,
    required this.Tekran,
    required this.Tsistem,
    required this.Tkamera,
    required this.Tfiyat,
    dynamic Ttext,
  });

  @override
  State<ThirdPageDatas> createState() => _ThirdPageDatasState();
}

var yaziTipi = GoogleFonts.ubuntu(fontSize: 20, color: Colors.white);

class _ThirdPageDatasState extends State<ThirdPageDatas> {
  cardWidget(String text, String Ttext) {
    widget.Ttext = Ttext;
    return Card(
      color: Colors.brown,
      margin: EdgeInsets.all(20.0),
      elevation: 20,
      child: Column(
        children: [
          ListTile(
            title: Text(text, textAlign: TextAlign.center, style: yaziTipi),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.Ttext,
              style: yaziTipi,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
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
              color: Color.fromARGB(255, 255, 252, 251),
            ),
          ),
          centerTitle: true,
          title: Text(widget.Tname, style: yaziTipi),
        ),
        body: Container(
            child: ListWheelScrollView(
                physics: FixedExtentScrollPhysics(),
                itemExtent: 220,
                perspective: 0.005,
                children: [
              cardWidget("Ram", widget.Tram),
              cardWidget("Depolama", widget.Tkapasite),
              cardWidget("Batarya Gücü", widget.Tbatarya),
              cardWidget("Ekran", widget.Tekran),
              cardWidget("Sistem", widget.Tsistem),
              cardWidget("Kamera", widget.Tkamera),
              cardWidget("Fiyat", "${widget.Tfiyat} TL"),
            ])),
      ),
    );
  }
}
