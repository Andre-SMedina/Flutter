import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/models/exercice_model.dart';
import 'package:gym/models/sentimento_model.dart';

class ExerciceService {
  String userId;
  ExerciceService() : userId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExercice(ExerciceModel exerciceModel) async {
    await _firestore
        .collection(userId)
        .doc(exerciceModel.id)
        .set(exerciceModel.toMap());
  }

  Future<void> addEmotion(
      String idExercice, SentimentoModel sentimentoModelo) async {
    await _firestore
        .collection(userId)
        .doc(idExercice)
        .collection('sentimentos')
        .doc(sentimentoModelo.id)
        .set(sentimentoModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> connectStreamExercices() {
    return _firestore.collection(userId).snapshots();
  }
}
