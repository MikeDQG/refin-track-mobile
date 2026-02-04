// models/dokument.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Dokument {
  String id; // Add ID for Firestore document reference
  String naziv;
  String opis;
  int stroj_id;
  DateTime createdAt;
  DateTime updatedAt;

  Dokument({
    this.id = '',
    required this.naziv,
    required this.opis,
    required this.stroj_id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    createdAt = createdAt ?? DateTime.now(),
    updatedAt = updatedAt ?? DateTime.now();

  // Factory constructor from Firestore
  factory Dokument.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Dokument(
      id: doc.id,
      naziv: data['naziv'] ?? '',
      opis: data['opis'] ?? '',
      stroj_id: data['stroj_id'] ?? 0,
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to map for Firestore
  Map<String, dynamic> toFirestore() {
    final map = {
      'naziv': naziv,
      'opis': opis,
      'stroj_id': stroj_id,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
    
    return map;
  }

  // For updates (doesn't include created_at)
  Map<String, dynamic> toUpdateFirestore() {
    final map = {
      'naziv': naziv,
      'opis': opis,
      'stroj_id': stroj_id,
      'updated_at': FieldValue.serverTimestamp(),
    };
    
    return map;
  }
}