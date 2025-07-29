import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_bank/models/donor.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDonor(Donor donor) async {
    try {
      await _db.collection('donors').add(donor.toMap());
    } catch (e) {
      print('Error adding donor: $e');
    }
  }

  Future<List<Donor>> getDonors() async {
    QuerySnapshot snapshot = await _db.collection('donors').get();
    return snapshot.docs.map((doc) => Donor.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
