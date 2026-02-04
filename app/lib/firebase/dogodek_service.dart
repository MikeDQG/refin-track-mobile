import 'package:app/models/dogodek.dart';
import 'package:app/models/dogodek.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDogodekService {
  static Future<int> saveDogodek({required Dogodek dogodek}) async {
    final query = await FirebaseFirestore.instance
        .collection('dogodki')
        .where('dogodek_id', isEqualTo: dogodek.id)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return -1;
    }

    final Future<void> response = FirebaseFirestore.instance
        .collection('dogodki')
        .doc(dogodek.id.toString())
        .set({
          'dogodek_id': dogodek.id,
          'naziv': dogodek.naziv,
          'opis': dogodek.opis,
          'datum': dogodek.datum,
          'aktiven': dogodek.aktiven,
          'stroj_id': dogodek.stroj_id,
        });
    print(response.hashCode);
    return dogodek.id;
  }

  static Future<Dogodek?> getDogodekById(int id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('dogodki')
        .where('dogodek_id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      print(doc.data());
      return Dogodek(
        id: doc['dogodek_id'], 
        naziv: doc['naziv'], 
        opis: doc['opis'], 
        aktiven: doc['aktiven'], 
        stroj_id: doc['stroj_id'], 
        datum: doc['datum']);
    } else {
      return null;
    }
  }

  static Future<List<Dogodek>> getAllDogodki() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('dogodki')
        .get();

    return querySnapshot.docs.map((doc) {
      print(doc.data());
      return Dogodek(
        id: doc['dogodek_id'], 
        naziv: doc['naziv'], 
        opis: doc['opis'], 
        aktiven: doc['aktiven'], 
        stroj_id: doc['stroj_id'], 
        datum: doc['datum']);
    }).toList();
  }

  static Future<List<Dogodek>> getDogodkiByStroj(int stroj_id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('dogodki')
        .where('stroj_id', isEqualTo: stroj_id)
        .get();

    return querySnapshot.docs.map((doc) {
      print(doc.data());
      return Dogodek(
        id: doc['dogodek_id'], 
        naziv: doc['naziv'], 
        opis: doc['opis'], 
        aktiven: doc['aktiven'], 
        stroj_id: doc['stroj_id'], 
        datum: doc['datum']);
    }).toList();
  }

  static Future<int> updateDogodek({required Dogodek dogodek}) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('dogodki')
        .where('dogodek_id', isEqualTo: dogodek.id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      await doc.reference.update({
        'naziv': dogodek.naziv, 
        'opis': dogodek,
        'datum': dogodek.datum,
        'aktiven': dogodek.aktiven,
        });
      return dogodek.id;
    } else {
      return -1;
    }
  }

  static Future<void> deleteDogodek(int id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('dogodki')
        .where('dogodek_id', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    }
  }
}
