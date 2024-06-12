import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/models/sentimento_model.dart';
import '../models/exercice_model.dart';

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

  Future<void> delExercice(String idExercice) async {
    await _firestore.collection(userId).doc(idExercice).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> connectStreamExercices(
      bool isDecrescente) {
    //acessar lista de exercícios do usuário
    return _firestore
        .collection(userId)
        .orderBy('treino', descending: isDecrescente)
        .snapshots();
  }
}
