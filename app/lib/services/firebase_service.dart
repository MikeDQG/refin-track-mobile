import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Funkcija, ki poišče stroj glede na ID iz QR kode
  Future<Map<String, dynamic>?> getMachineDetails(String machineId) async {
    try {
      // Predpostavljamo, da imaš kolekcijo 'machines' in da je machineId
      // ID dokumenta (ali polje, npr. 'qr_code_id').
      
      // Iščemo dokument, kjer je polje 'qr_code_id' enako skenirani kodi
      QuerySnapshot querySnapshot = await _firestore
          .collection('machines')
          .where('qr_code_id', isEqualTo: machineId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Našli smo stroj
        return querySnapshot.docs.first.data() as Map<String, dynamic>?;
      } else {
        // Stroj ni najden
        return null;
      }
    } catch (e) {
      print('Napaka pri poizvedbi Firebase: $e');
      return null;
    }
  }
}
