import 'package:budget_app_starting/responsive_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // SETUP FIREBASE WEB
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setPathUrlStrategy();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBkXY47XXgSyvAlCc0-ikLfqwH6t1gDZ8E",
        authDomain: "budget-app-813d4.firebaseapp.com",
        projectId: "budget-app-813d4",
        storageBucket: "budget-app-813d4.appspot.com",
        messagingSenderId: "877621096994",
        appId: "1:877621096994:web:86d610d6186b71e17dd07b",
        measurementId: "G-44WVFTSR6P",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    ProviderScope(
      child: Myapp(),
    ),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(useMaterial3: true),
      home: ResponsiveHandler(),
    );
  }
}
