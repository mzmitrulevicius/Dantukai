import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'FoodPreferencesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FoodSelectionPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool foodPreferencesCompleted = await isFoodPreferencesCompleted();
  runApp(MyApp(foodPreferencesCompleted: foodPreferencesCompleted));
}

Future<bool> isFoodPreferencesCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('foodPreferencesCompleted') ?? false;
}

class MyApp extends StatelessWidget {
  final bool foodPreferencesCompleted;

  MyApp({required this.foodPreferencesCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      // Priklausomai nuo foodPreferencesCompleted reikšmės, nustatome pradinį maršrutą
     initialRoute: foodPreferencesCompleted ? '/FoodPreferencesPage' : '/',
routes: {
  '/': (context) => HomePage(),
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/FoodPreferencesPage': (context) => FoodPreferencesPage(),
  '/FoodSelectionPage': (context) => FoodSelectionPage(), // Įtraukite šį maršrutą

},

    );
  }
}
