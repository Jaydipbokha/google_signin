import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlesignin/prestionations/login/view/login_view.dart';

class LoginController extends GetxController {

  RxBool isLoading = false.obs;
  
  Future<UserCredential> signInWithGoogle() async {
    try{
       isLoading.value = true;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    }finally {
      isLoading.value = false;
    }
  }

  Future<void> signOutGoogle() async {
  // Sign out from Firebase
  await FirebaseAuth.instance.signOut();

  // Sign out from Google
  await GoogleSignIn().signOut();

  Get.offAll(()=> const LoginView());
}


}