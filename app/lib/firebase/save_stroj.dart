import 'package:app/models/stroj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStrojService {
  static Future<int> saveStroj({required Stroj stroj}) async {
    final query = await FirebaseFirestore.instance
        .collection('stroji')
        .where('stroj_id', isEqualTo: stroj.id)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return -1;
    }

    final Future<void> response = FirebaseFirestore.instance
        .collection('stroji')
        .doc(stroj.id.toString())
        .set({
          'stroj_id': stroj.id,
          'naziv': stroj.naziv,
          'opis': stroj.opis,
          'timestamp': FieldValue.serverTimestamp(),
        });
    print(response.hashCode);
    return stroj.id;
  }

  static Future<Stroj?> getStrojById(int id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('stroji')
        .where('stroj_id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      print(doc.data());
      return Stroj(id: doc['stroj_id'], naziv: doc['naziv']);
    } else {
      return null;
    }
  }

  static Future<List<Stroj>> getAllStroji() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('stroji')
        .get();

    return querySnapshot.docs.map((doc) {
      print(doc.data());
      return Stroj(id: doc['stroj_id'], naziv: doc['naziv']);
    }).toList();
  }

  static Future<int> updateStroj({required Stroj stroj}) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('stroji')
        .where('stroj_id', isEqualTo: stroj.id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      await doc.reference.update({'naziv': stroj.naziv, 'opis': stroj.opis});
      return stroj.id;
    } else {
      return -1;
    }
  }

  static Future<void> deleteStroj(int id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('stroji')
        .where('stroj_id', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    }
  }
}
