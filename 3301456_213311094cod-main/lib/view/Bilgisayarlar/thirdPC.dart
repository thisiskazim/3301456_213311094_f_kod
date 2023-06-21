import 'package:flutter/material.dart';

import 'package:pertys_pro/view/main.dart';
import 'package:pertys_pro/view/Telefonlar/secondTLP.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdPagePCDatas extends StatefulWidget {
  final String PCname;
  final String pc_donanim;
  final String PCekran;
  final String PCsistem;
  final String PCdepolama;
  final String pc_ram;
  final String pc_fiyat;
  dynamic Ttext;

  ThirdPagePCDatas({
    super.key,
    required this.PCname,
    required this.PCekran,
    required this.PCsistem,
    required this.PCdepolama,
    required this.pc_donanim,
    required this.pc_ram,
    dynamic Ttext,
    required this.pc_fiyat,
  });

  @override
  State<ThirdPagePCDatas> createState() => _ThirdPagePCDatasState();
}

class _ThirdPagePCDatasState extends State<ThirdPagePCDatas> {
  cardWidget(String text, String Ttext) {
    widget.Ttext = Ttext;
    return Card(
      color: Colors.brown,
      margin: EdgeInsets.all(20.0),
      elevation: 20,
      child: Column(
        children: [
          ListTile(
            title: Text(text,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.Ttext,
              style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white),
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
    return Scaffold(
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
        centerTitle: true,
        title: Text(widget.PCname,
            style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: Colors.white,
            )),
      ),
      backgroundColor: Colors.white,
      body: Container(
          child: ListWheelScrollView(
              physics: FixedExtentScrollPhysics(),
              itemExtent: 250,
              perspective: 0.005,
              children: [
            cardWidget("Depolama", widget.PCdepolama),
            cardWidget("Ekran", widget.PCekran),
            cardWidget("İşletim Sistemi", widget.PCsistem),
            cardWidget("Donanım Özellikleri", widget.pc_donanim),
            cardWidget("Ram", widget.pc_ram)
          ])),
    );
  }
}
