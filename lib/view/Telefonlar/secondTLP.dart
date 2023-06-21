import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pertys_pro/view/Telefonlar/thirdTLP.dart';
import 'package:pertys_pro/model/model_db.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
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
          centerTitle: true,
          title: Text("Telefonlar", style: yaziTipi),
        ),
        body: TelephoneBody(),
      ),
    );
  }
}

class TelephoneBody extends StatefulWidget {
  const TelephoneBody({super.key});

  @override
  State<TelephoneBody> createState() => _TelephoneBodyState();
}

var yaziTipi = GoogleFonts.ubuntu(fontSize: 20, color: Colors.white);

class _TelephoneBodyState extends State<TelephoneBody> {
  List<Map<String, dynamic>> brands = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    final dbHelper = DatabaseHelper();
    brands = await dbHelper.getPhones();

    setState(() {
      searchResults = brands;
    });
  }

  void searchPhone(String brand) {
    setState(() {
      searchResults = brands
          .where((phonee) =>
              phonee["name"].toLowerCase().contains(brand.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: TextField(
          onChanged: (value) {
            setState(
              () {
                searchPhone(value);
              },
            );
          },
          decoration: InputDecoration(
            prefix: const Icon(Icons.search),
            hintText: "Arama Yap...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black54),
            ),
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final phone = searchResults[index];

            return ListTile(
              title: Text(
                phone['name'],
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                ),
              ),
              subtitle: Text("${phone["fiyat"]} Euro"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPageDatas(
                      Tname: phone['name'],
                      Tram: phone['ram'],
                      Tkapasite: phone['kapasite'],
                      Tbatarya: phone['batarya'],
                      Tekran: phone['ekran'],
                      Tsistem: phone['sistem'],
                      Tkamera: phone['kamera'],
                      Tfiyat: phone['fiyat'],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ]));
  }
}
