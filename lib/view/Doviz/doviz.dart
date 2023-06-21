import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Doviz extends StatefulWidget {
  @override
  _DovizState createState() => _DovizState();
}

class _DovizState extends State<Doviz> {
  Map<String, dynamic> dovizData = {};

  @override
  void initState() {
    super.initState();
    getDovizData();
  }

  Future<Map<String, dynamic>> getDoviz() async {
    var url = Uri.parse(
        'http://api.exchangeratesapi.io/v1/latest?access_key=7b6c6ff139ab1ee8e05fef85c4813615&format=1&_gl=1*1eyr11*_ga*OTQzMzczNTg1LjE2ODcyNjExNDI.*_ga_HGV43FGGVM*MTY4NzI3NTY5NC4zLjEuMTY4NzI3NTgyOC41LjAuMA..');
    var headers = {'access_key': '7b6c6ff139ab1ee8e05fef85c4813615'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('API isteği başarısız: ${response.statusCode}');
    }
  }

  void getDovizData() async {
    try {
      var data = await getDoviz();
      setState(() {
        dovizData = data;
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          centerTitle: true,
          title: Text(
            "Doviz Kurları",
            style: GoogleFonts.ubuntu(
              fontSize: 20,
            ),
          ),
        ),
        body: DovizBody(dovizData: dovizData),
      ),
    );
  }
}

class DovizBody extends StatelessWidget {
  final Map<String, dynamic> dovizData;

  const DovizBody({Key? key, required this.dovizData}) : super(key: key);

  Widget goster(String paraBirimi) {
    if (dovizData == null || dovizData['rates'] == null) {
      return CircularProgressIndicator();
    } else {
      var data = dovizData['rates'][paraBirimi];
      if (data == null) {
        return Text("Veri bulunamadı.");
      } else {
        return Text("$paraBirimi : $data");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(FontAwesomeIcons.dollarSign),
            title: goster("USD"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.turkishLiraSign),
            title: goster("TRY"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.bitcoin),
            title: goster("BTC"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.kipSign),
            title: goster("PLN"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.rubleSign),
            title: goster("MXN"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.wonSign),
            title: goster("KRW"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.lariSign),
            title: goster("GEL"),
          ),
        ],
      ),
    );
  }
}
