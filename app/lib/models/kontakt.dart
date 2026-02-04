// models/kontakt.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Kontakt {
  String id; // Add ID field
  String naziv;
  String opis;
  String email;
  String telefon;
  int stroj_id;
  DateTime createdAt;
  DateTime updatedAt;

  Kontakt({
    this.id = '',
    required this.naziv,
    this.opis = "",
    this.email = "",
    this.telefon = "",
    required this.stroj_id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    createdAt = createdAt ?? DateTime.now(),
    updatedAt = updatedAt ?? DateTime.now();

  // Factory constructor from Firestore document
  factory Kontakt.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Kontakt(
      id: doc.id,
      naziv: data['naziv'] ?? '',
      opis: data['opis'] ?? '',
      email: data['email'] ?? '',
      telefon: data['telefon'] ?? '',
      stroj_id: data['stroj_id'] ?? 0,
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'naziv': naziv,
      'opis': opis,
      'email': email,
      'telefon': telefon,
      'stroj_id': stroj_id,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
  }

  // Update method
  Map<String, dynamic> toUpdateFirestore() {
    return {
      'naziv': naziv,
      'opis': opis,
      'email': email,
      'telefon': telefon,
      'stroj_id': stroj_id,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}