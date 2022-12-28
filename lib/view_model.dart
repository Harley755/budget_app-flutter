import 'package:budget_app_starting/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final viewModel =
    ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());

class ViewModel extends ChangeNotifier {
  var logger = Logger();

  final _auth = FirebaseAuth.instance;
  bool isSignedIn = false;
  bool isObscure = true;

  List expensesName = [];
  List expensesAmount = [];

  List incomesName = [];
  List incomesAmount = [];

  // 1- CHECK IF SIGNED IN
  Future<void> isLoggedIn() async {
    await _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isSignedIn = false;
      } else {
        isSignedIn = true;
      }
    });
    notifyListeners();
  }

  toogleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // AUTHENTICATION
  Future<void> createUserWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    await _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => logger.d("Registration successful"))
        .onError((error, stackTrace) {
      logger.d("Registration error $error");
      DialogueBox(
        context,
        error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
      );
    });
  }

  // LOGIN
  Future<void> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d('Login successful'))
        .onError(
      (error, stackTrace) {
        logger.d("Login error: $error");
        DialogueBox(
          context,
          error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
        );
      },
    );
  }

  // SIGN IN WITH GOOGLE (WEB)
  Future<void> signInWithGoogleWeb(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    await _auth.signInWithPopup(googleAuthProvider).onError(
        (error, stackTrace) => DialogueBox(
            context, error.toString().replaceAll(RegExp('\\[.*?\\]'), '')));
    logger
        .d("Current user is not empty = ${_auth.currentUser!.uid.isNotEmpty}");
  }

  // SIGN IN WITH GOOGLE (MOBILE)
  Future<void> signInWithGoogleMobile(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn()
        .signIn()
        .onError((error, stackTrace) => DialogueBox(
            context, error.toString().replaceAll(RegExp('\\[.*?\\]'), '')));

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth.signInWithCredential(credential).then((value) {
      logger.d("Google successfully");
    }).onError((error, stackTrace) {
      logger.d("Google Sign in error $error");
      DialogueBox(
          context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // DATABASE
  Future addExpense(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(
        context: context, builder: (BuildContext context) => AlertDialog());
  }
}
