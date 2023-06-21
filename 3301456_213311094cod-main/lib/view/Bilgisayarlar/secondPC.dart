import 'package:flutter/material.dart';
import 'package:pertys_pro/view/Bilgisayarlar/thirdPC.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pertys_pro/model/model_db.dart';

class SecondPagePC extends StatefulWidget {
  const SecondPagePC({super.key});

  @override
  State<SecondPagePC> createState() => _SecondPagePCState();
}

class _SecondPagePCState extends State<SecondPagePC> {
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
            "Bilgisayarlar",
            style: GoogleFonts.ubuntu(
              fontSize: 20,
            ),
          ),
        ),
        body: BilgisayarBody(),
      ),
    );
  }
}

class BilgisayarBody extends StatefulWidget {
  const BilgisayarBody({super.key});

  @override
  State<BilgisayarBody> createState() => _BilgisayarBodyState();
}

class _BilgisayarBodyState extends State<BilgisayarBody> {
  List<Map<String, dynamic>> brands = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    final dbHelper = DatabaseHelper();
    brands = await dbHelper.getPC();

    setState(() {
      searchResults = brands;
    });
  }

  void searchPc(String brand) {
    setState(() {
      searchResults = brands
          .where((phonee) =>
              phonee["pc_name"].toLowerCase().contains(brand.toLowerCase()))
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
                searchPc(value);
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
            final pc = searchResults[index];

            return ListTile(
              subtitle: Text("${pc["pc_fiyat"]} Euro"),
              title: Text(pc['pc_name'],
                  style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPagePCDatas(
                        PCname: pc['pc_name'],
                        pc_donanim: pc['pc_donanim'],
                        PCekran: pc['pc_ekran'],
                        PCsistem: pc['pc_sistem'],
                        PCdepolama: pc['pc_depolama'],
                        pc_ram: pc['pc_ram'],
                        pc_fiyat: pc['pc_fiyat']),
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
