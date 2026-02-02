import 'package:app/models/stroj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStrojService {
  static Future<DocumentReference> saveStroj({required Stroj stroj}) async {
    final Future<DocumentReference> response = FirebaseFirestore.instance.collection('stroji').add({
      'stroj_id': stroj.id,
      'naziv': stroj.naziv,
      'timestamp': FieldValue.serverTimestamp(),
    });
    print(response.hashCode);
    return response;
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
}
