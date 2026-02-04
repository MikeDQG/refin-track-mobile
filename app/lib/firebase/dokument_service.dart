// services/firebase_dokument_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/models/dokument.dart';

class FirebaseDokumentService {
  static final CollectionReference _dokumentiCollection =
      FirebaseFirestore.instance.collection('dokumenti');

  // Create/Save a dokument
  static Future<String> saveDokument(Dokument dokument) async {
    try {
      DocumentReference docRef;
      
      if (dokument.id.isEmpty) {
        // Create new dokument
        docRef = await _dokumentiCollection.add(dokument.toFirestore());
        dokument.id = docRef.id;
      } else {
        // Update existing dokument
        docRef = _dokumentiCollection.doc(dokument.id);
        await docRef.set(dokument.toFirestore());
      }
      
      return dokument.id;
    } catch (e) {
      print('Error saving dokument: $e');
      rethrow;
    }
  }

  // Get a dokument by ID
  static Future<Dokument?> getDokument(String id) async {
    try {
      final doc = await _dokumentiCollection.doc(id).get();
      
      if (doc.exists) {
        return Dokument.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting dokument: $e');
      return null;
    }
  }

  // Get all dokumenti
  static Future<List<Dokument>> getAllDokumenti() async {
    try {
      final querySnapshot = await _dokumentiCollection
          .orderBy('created_at', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Dokument.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting all dokumenti: $e');
      return [];
    }
  }

  // Get dokumenti by stroj_id
  static Future<List<Dokument>> getDokumentiByStroj(int strojId) async {
    try {
      final querySnapshot = await _dokumentiCollection
          .where('stroj_id', isEqualTo: strojId)
          .orderBy('created_at', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Dokument.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting dokumenti by stroj: $e');
      return [];
    }
  }

  // Update a dokument
  static Future<void> updateDokument(Dokument dokument) async {
    try {
      await _dokumentiCollection
          .doc(dokument.id)
          .update(dokument.toUpdateFirestore());
    } catch (e) {
      print('Error updating dokument: $e');
      rethrow;
    }
  }

  // Delete a dokument
  static Future<void> deleteDokument(String id) async {
    try {
      await _dokumentiCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting dokument: $e');
      rethrow;
    }
  }

  // Search dokumenti by name
  static Future<List<Dokument>> searchDokumenti(String searchTerm) async {
    try {
      final querySnapshot = await _dokumentiCollection
          .where('naziv', isGreaterThanOrEqualTo: searchTerm)
          .where('naziv', isLessThanOrEqualTo: '$searchTerm\uf8ff')
          .limit(20)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Dokument.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error searching dokumenti: $e');
      return [];
    }
  }

}