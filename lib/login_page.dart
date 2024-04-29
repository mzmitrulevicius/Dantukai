import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (user.user != null) {
          // Tikriname, ar vartotojas jau užpildė maisto pageidavimus
          final prefs = await SharedPreferences.getInstance();
          final foodPreferencesCompleted = prefs.getBool('foodPreferencesCompleted') ?? false;

          if (!foodPreferencesCompleted) {
            // Jei maisto pageidavimai nebuvo užpildyti, nukreipiamas į FoodPreferencesPage
            Navigator.pushReplacementNamed(context, '/FoodPreferencesPage');
          } else {
            // Jei maisto pageidavimai buvo užpildyti, nukreipiamas į pagrindinį puslapį
            Navigator.pushReplacementNamed(context, '/');
          }
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Prisijungimo duomenys neteisingi, prašome patikrinti duomenis'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prisijungimo forma'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'El. paštas'),
                validator: (value) => value!.isEmpty || !value.contains('@') ? 'Įveskite teisingą el. paštą' : null,
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Slaptažodis'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Įveskite slaptažodį' : null,
                onSaved: (value) => password = value!,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Prisijungti'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Neturite paskyros? Registruokitės čia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
