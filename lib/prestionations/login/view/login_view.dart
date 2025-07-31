import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlesignin/prestionations/home/view/home_view.dart';

import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginController controller = Get.put(LoginController());

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Obx(() {
      return Stack(
        children: [
          Container(
            width: Get.width,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          try {
                            final userCredential = await controller.signInWithGoogle();
                            Get.to(() => const HomeView());
                            print('Signed in: ${userCredential.user?.displayName}');
                          } catch (e) {
                            print('Error: $e');
                            Get.snackbar('Login Failed', e.toString(),
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                  child: const Text("Sign in with Google"),
                ),
              ],
            ),
          ),

          if (controller.isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      );
    }),
  );
}

}
