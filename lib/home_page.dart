// HomePage.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the shared_preferences package


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagrindinis puslapis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  // Tikriname, ar vartotojas jau užpildė maisto pageidavimus
                  final prefs = await SharedPreferences.getInstance();
                  final foodPreferencesCompleted = prefs.getBool('foodPreferencesCompleted') ?? false;

                  if (!foodPreferencesCompleted) {
                    // Jei maisto pageidavimai nebuvo užpildyti, nukreipiamas į FoodPreferencesPage
                    Navigator.pushNamed(context, '/FoodPreferencesPage');
                  } else {
                    // Jei maisto pageidavimai buvo užpildyti, nukreipiamas į FoodSelectionPage
                    Navigator.pushNamed(context, '/FoodSelectionPage');
                  }
                } else {
                  // Jei vartotojas nėra prisijungęs, nukreipkite jį į prisijungimo puslapį
                  Navigator.pushNamed(context, '/login');
                }
              },
              child: Text('Tęsti'),
            ),
          ],
        ),
      ),
    );
  }
}
