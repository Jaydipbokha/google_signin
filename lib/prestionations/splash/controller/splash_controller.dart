import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:googlesignin/prestionations/login/view/login_view.dart';

import '../../home/view/home_view.dart';

class SplashController extends GetxController {

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Get.offAll(()=> const HomeView());
    } else {
       Get.offAll(()=> const LoginView());
    }
  }


@override
  void onInit() {
    _checkLoginStatus();
    super.onInit();
}

}