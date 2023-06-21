import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirabaseServis {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String parola) async {
    var user =
        await _auth.signInWithEmailAndPassword(email: email, password: parola);
    return user.user;
  }

  singOut() async {
    return await _auth.signOut();
  }

  Future<User?> register(
      String email, String kullaniciadi, String parola) async {
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: parola);

    await firestore
        .collection("Kullanıcılar")
        .add({
          'kullaniciAdi': kullaniciadi,
          'email': email,
          'parola': parola,
        })
        .then((value) => print("$value Kullancıı başarıyla kaydedildi"))
        .catchError((error) {
          print("$error hatası");
        });

    return user.user;
  }
}
