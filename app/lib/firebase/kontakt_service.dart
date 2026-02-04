// services/firebase_kontakt_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/models/kontakt.dart';

class FirebaseKontaktService {
  static final CollectionReference _kontaktiCollection =
      FirebaseFirestore.instance.collection('kontakti');

  // Create/Save a new kontakt
  static Future<String> saveKontakt(Kontakt kontakt) async {
    try {
      DocumentReference docRef;
      
      if (kontakt.id.isEmpty) {
        // Create new document with auto-generated ID
        docRef = await _kontaktiCollection.add(kontakt.toFirestore());
        kontakt.id = docRef.id;
      } else {
        // Update existing document
        docRef = _kontaktiCollection.doc(kontakt.id);
        await docRef.set(kontakt.toFirestore());
      }
      
      return kontakt.id;
    } catch (e) {
      print('Error saving kontakt: $e');
      rethrow;
    }
  }

  // Get a kontakt by ID
  static Future<Kontakt?> getKontakt(String id) async {
    try {
      final doc = await _kontaktiCollection.doc(id).get();
      
      if (doc.exists) {
        return Kontakt.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting kontakt: $e');
      return null;
    }
  }

  // Get all kontakti
  static Future<List<Kontakt>> getAllKontakti() async {
    try {
      final querySnapshot = await _kontaktiCollection
          .orderBy('created_at', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Kontakt.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting all kontakti: $e');
      return [];
    }
  }

  // Get kontakti by stroj_id
  static Future<List<Kontakt>> getKontaktiByStroj(int strojId) async {
    try {
      final querySnapshot = await _kontaktiCollection
          .where('stroj_id', isEqualTo: strojId)
          .orderBy('naziv')
          .get();
      
      return querySnapshot.docs
          .map((doc) => Kontakt.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting kontakti by stroj: $e');
      return [];
    }
  }

  // Update a kontakt
  static Future<void> updateKontakt(Kontakt kontakt) async {
    try {
      await _kontaktiCollection
          .doc(kontakt.id)
          .update(kontakt.toUpdateFirestore());
    } catch (e) {
      print('Error updating kontakt: $e');
      rethrow;
    }
  }

  // Delete a kontakt
  static Future<void> deleteKontakt(String id) async {
    try {
      await _kontaktiCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting kontakt: $e');
      rethrow;
    }
  }

  // Stream for real-time updates
  static Stream<List<Kontakt>> kontaktiStream() {
    return _kontaktiCollection
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Kontakt.fromFirestore(doc))
            .toList());
  }

  // Stream for kontakti by stroj_id (real-time)
  static Stream<List<Kontakt>> kontaktiByStrojStream(int strojId) {
    return _kontaktiCollection
        .where('stroj_id', isEqualTo: strojId)
        .orderBy('naziv')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Kontakt.fromFirestore(doc))
            .toList());
  }
}