import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String school = '';
  String grade = '';

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (newUser.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Jūsų registracija sėkminga'),
          ));
          Navigator.of(context).pushReplacementNamed('/login'); // Nukreipimas į prisijungimo puslapį
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registracijos klaida: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registracijos forma'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Vardas'),
                validator: (value) => value!.isEmpty ? 'Įveskite vardą' : null,
                onSaved: (value) => firstName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pavardė'),
                validator: (value) => value!.isEmpty ? 'Įveskite pavardę' : null,
                onSaved: (value) => lastName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'El. paštas'),
                validator: (value) => value!.isEmpty || !value.contains('@') ? 'Neteisingas el. pašto formatas' : null,
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Slaptažodis'),
                obscureText: true,
                validator: (value) => value!.isEmpty || value.length < 6 ? 'Slaptažodis per trumpas' : null,
                onSaved: (value) => password = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mokykla'),
                onSaved: (value) => school = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Klasė'),
                onSaved: (value) => grade = value!,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _register,
                  child: Text('Registruotis'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
