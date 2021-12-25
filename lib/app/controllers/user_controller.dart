import 'package:alphauser/app/constants/firebase.dart';
import 'package:alphauser/app/models/user.dart';
import 'package:alphauser/app/screens/home/home.dart';
import 'package:alphauser/app/widgets/showLoading.dart';
import 'package:alphauser/app/screens/auth/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  late String verificationId;
  late Rx<User?> firebaseUser;
  Rx<UserModel> userModel = UserModel().obs;
  RxBool isCodeSent = false.obs;

  clearController() {
    phoneController.clear();
    otpController.clear();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Get.offAll(() => PhoneVerification());
      });
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => Home());
      //signout();
    }
  }

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future verifyPhoneNumber() async {
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneController.text.trim(),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60));
  }

  verificationCompleted(PhoneAuthCredential authCredential) async {
    print('success');
  }

  verificationFailed(FirebaseAuthException exception) async {
    if (exception.code == 'invalid-phone-number') {
      return 'The phone number entered is invalid';
    }
  }

  codeSent(String verificationId, int? forceResendingToken) async {
    this.verificationId = verificationId;
    isCodeSent.value = true;
  }

  codeAutoRetrievalTimeout(String timeout) async {
    verificationId = timeout;
  }

  verifyOTP() async {
    showLoading();
    await firebaseAuth
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otpController.text.trim()))
        .then((value) {
      clearController();
    }).catchError((onError) {
      dismissLoadingWidget();
      Get.snackbar('Signin Failed', 'Enter a valid otp');
    }).whenComplete(() async {
      await firebaseFirestore
          .collection('users')
          .doc(getCurrentUser()!.uid)
          .set({'myCart': []});
    });
  }

  void signout() async => await firebaseAuth.signOut();

  updateUserData(Map<String, dynamic> data) async {
    await firebaseFirestore
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection('users')
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
