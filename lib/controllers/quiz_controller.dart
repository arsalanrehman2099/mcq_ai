import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/controllers/user_controller.dart';
import 'package:mcq_ai/models/quiz.dart';

class QuizController extends GetxController {
  static const COLLECTION_NAME = 'Quiz';

  final UserController _userController = Get.find();

  final _firestore = FirebaseFirestore.instance;

  var loading = false.obs;
  var fetchingQuiz = false.obs;

  var quizes = [].obs;

  createQuiz(Quiz? quiz) async {
    loading.value = true;
    var response = {};

    await _firestore
        .collection(COLLECTION_NAME)
        .doc(quiz!.id)
        .set(quiz.toJson())
        .then((value) {
      loading.value = false;
      response['error'] = 0;
    }).catchError((err) {
      loading.value = false;
      response['error'] = 1;
      response['message'] = err.toString();
    });

    return response;
  }

  fetchQuiz() {
    fetchingQuiz.value = true;
    _firestore
        .collection(COLLECTION_NAME)
        .where('userId', isEqualTo: _userController.myId())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      fetchingQuiz.value = false;
      quizes.value = [];
      event.docs.forEach((element) {
        Quiz quiz = Quiz().fromJson(element.data());
        quizes.add(quiz);
      });
      print(quizes);
    });
  }

  deleteQuiz(id) async {
    loading.value = true;
    var response = {};

    await _firestore.collection(COLLECTION_NAME).doc(id).delete().then((value) {
      loading.value = false;
      response['error'] = 0;
    }).catchError((err) {
      loading.value = false;
      response['error'] = 1;
      response['message'] = err.toString();
    });

    return response;
  }
}
