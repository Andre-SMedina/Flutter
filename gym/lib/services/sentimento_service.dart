import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/sentimento_model.dart';

class SentimentoService {
  String userId;
  SentimentoService() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String key = 'sentimentos';

  Future<void> addEmotion(
      {required String idExercice,
      required SentimentoModel sentimentoModelo}) async {
    await _firestore
        .collection(userId)
        .doc(idExercice)
        .collection(key)
        .doc(sentimentoModelo.id)
        .set(sentimentoModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> connectStream(
      {required String idExercice}) {
    return _firestore
        .collection(userId)
        .doc(idExercice)
        .collection(key)
        .orderBy("data", descending: true)
        .snapshots();
  }

  Future<void> removeSentimento(
      {required String exerciceId, required String sentimentoId}) async {
    return _firestore
        .collection(userId)
        .doc(exerciceId)
        .collection(key)
        .doc(sentimentoId)
        .delete();
  }
}
