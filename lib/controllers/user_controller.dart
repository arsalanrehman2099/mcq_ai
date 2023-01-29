import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:get/get.dart';
import 'package:mcq_ai/utils/constant_manager.dart';

import '../models/user.dart';
import '../views/auth/login_screen.dart';

class UserController extends GetxController {
  static const COLLECTION_NAME = 'Users';

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  var loading = false.obs;

  String myId() => _auth.currentUser!.uid.toString();

  bool isLoggedIn() {
    return _auth.currentUser == null ? false : true;
  }

  userSignup(User? user) async {
    var response = {};

    loading.value = true;

    await _auth
        .createUserWithEmailAndPassword(
            email: user!.email!, password: user.password!)
        .then((value) {
      loading.value = false;
      response['error'] = 0;
      user.id = _auth.currentUser?.uid.toString();
      _firestore.collection(COLLECTION_NAME).doc(user.id).set(user.toJson());
    }).catchError((err) {
      loading.value = false;
      response['error'] = 1;
      response['message'] = err.toString();
    });

    return response;
  }

  userLogin(User? user) async {
    loading.value = true;
    var response = {};
    await _auth
        .signInWithEmailAndPassword(
        email: user!.email!, password: user.password!)
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

  userLogout() async {
    await _auth.signOut().whenComplete(() {
      Get.offAll(() => LoginScreen());
    }).catchError((err) {
      ConstantManager.showtoast('Error: $err');
    });
  }
}
