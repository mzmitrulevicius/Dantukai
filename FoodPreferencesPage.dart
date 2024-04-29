import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodPreferencesPage extends StatefulWidget {
  @override
  _FoodPreferencesPageState createState() => _FoodPreferencesPageState();
}

class _FoodPreferencesPageState extends State<FoodPreferencesPage> {
  Future<void> markAsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('foodPreferencesCompleted', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maisto produktų pageidavimai'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Pažiūrėkim kokius dantukams draugiškus produktus tu labiausiai mėgsti valgyti. Juos sudėk į pintines."),
            // Čia galite įdėti logiką su pintinėmis ir maisto produktais
            ElevatedButton(
              onPressed: () async {
                await markAsCompleted();
                Navigator.of(context).pop(); // arba nukreipia į kitą puslapį
              },
              child: Text('Baigta'),
            ),
          ],
        ),
      ),
    );
  }
}
