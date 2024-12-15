import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Borra el estado de autenticación
    Navigator.pushReplacementNamed(context, '/login'); // Redirige al login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context), // Cierra sesión
          ),
        ],
      ),
      body: Center(
        child: Text('Bienvenido, estás autenticado!'),
      ),
    );
  }
}
