import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheckScreen extends StatelessWidget {
  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.data == true) {
          // Usuario autenticado, redirigir al home
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacementNamed(context, '/home');
          });
        } else {
          // Usuario no autenticado, redirigir al login
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacementNamed(context, '/login');
          });
        }

        return SizedBox.shrink(); // Pantalla vacía mientras redirige
      },
    );
  }
}
