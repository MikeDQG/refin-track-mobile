import 'package:app/models/dogodek.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDogodekService {
  static Future<String> saveDogodek({required Dogodek dogodek}) async {
    try {
      // If dogodek doesn't have an ID, generate one
      if (dogodek.id.isEmpty) {
        final docRef = FirebaseFirestore.instance.collection('dogodki').doc();
        dogodek.id = docRef.id;
        
        await docRef.set(dogodek.toFirestore());
        return dogodek.id;
      } else {
        // If it has an ID, use it as document ID
        await FirebaseFirestore.instance
            .collection('dogodki')
            .doc(dogodek.id)
            .set(dogodek.toFirestore());
        return dogodek.id;
      }
    } catch (e) {
      print('Error saving dogodek: $e');
      rethrow;
    }
  }

  static Future<Dogodek?> getDogodekById(String id) async { // Changed to String
    try {
      final doc = await FirebaseFirestore.instance
          .collection('dogodki')
          .doc(id)  // Directly get by document ID
          .get();

      if (doc.exists) {
        return Dogodek.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting dogodek: $e');
      return null;
    }
  }

  static Future<List<Dogodek>> getAllDogodki() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('dogodki')
          .orderBy('created_at', descending: true) // Optional: order by date
          .get();

      return querySnapshot.docs.map((doc) {
        return Dogodek.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error getting all dogodki: $e');
      return [];
    }
  }

  static Future<List<Dogodek>> getDogodkiByStroj(int stroj_id) async {
    // try {
    //   final querySnapshot = await FirebaseFirestore.instance
    //       .collection('dogodki')
    //       .where('stroj_id', isEqualTo: stroj_id)
    //       .orderBy('datum', descending: true) // Order by date
    //       .get();

    //   return querySnapshot.docs.map((doc) {
    //     print("tukajajajjajjaj");
    //     return Dogodek.fromFirestore(doc.data(), doc.id);
    //   }).toList();
    // } catch (e) {
    //   print('Error getting dogodki by stroj: $e');
    //   return [];
    // }

    List<Dogodek> dogodki = await getAllDogodki();
    List<Dogodek> dog = [];
    dogodki.forEach((d) {
      if (d.stroj_id == stroj_id) {
        dog.add(d);
      };
    });
    return dog;
  }

  static Future<String> updateDogodek({required Dogodek dogodek}) async {
    try {
      await FirebaseFirestore.instance
          .collection('dogodki')
          .doc(dogodek.id)
          .update({
            'naziv': dogodek.naziv,
            'opis': dogodek.opis, // Fixed: was passing dogodek object instead of opis
            'datum': Timestamp.fromDate(dogodek.datum),
            'aktiven': dogodek.aktiven,
            'updated_at': FieldValue.serverTimestamp(),
          });
      return dogodek.id;
    } catch (e) {
      print('Error updating dogodek: $e');
      rethrow;
    }
  }

  static Future<void> deleteDogodek(String id) async { // Changed to String
    try {
      await FirebaseFirestore.instance
          .collection('dogodki')
          .doc(id)
          .delete();
    } catch (e) {
      print('Error deleting dogodek: $e');
      rethrow;
    }
  }
}