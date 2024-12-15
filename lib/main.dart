import 'package:flutter/material.dart';
import 'package:nav_bar/views/auth/Crear_cuenta.dart';
import 'package:nav_bar/views/auth/Nueva_contrase%C3%B1a.dart';
import 'package:nav_bar/views/auth/Recuperar_cuenta.dart';
import 'package:nav_bar/views/glucometrias/glucometrias_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// IMPORTACIONES PERSONALIZADAS
import 'package:nav_bar/views/home/Home.dart';
import 'package:nav_bar/widgets/Appbar.dart';
import 'package:nav_bar/widgets/Navbar.dart';
import 'package:nav_bar/views/menus/Detalle_recetas.dart';
//importacion de conexion con mongo
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

Future<void> loginUser(String email, String password, BuildContext context) async {
  final url = Uri.parse("http://192.168.0.19:5000/auth");
 
  try {
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "email": email,
        "contraseña": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', token);

      print("Inicio de sesión exitoso. Token: $token");
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => MyHomePage())
      );
    } else { 
      final error = json.decode(response.body)['error'] ?? 'Error desconocido';
      print("Error al iniciar sesión: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  } catch (e) {
    print("Error al intentar iniciar sesión: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error de conexión: $e')),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 244, 248, 252),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Pantalla inicial
      routes: {
        '/crearCuenta': (context) => RegisterPage(),
        '/olvidoContraseña': (context) => CreateNewPasswordPage(),
        '/recuperarCuenta': (context) => RecoverAccountPage(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}

// SplashScreen: Verifica si el usuario está autenticado
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isLoggedIn ? MyHomePage() : LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Indicador de carga
      ),
    );
  }
}

// Pantalla de Login
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(''),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/glybn.png', // Ruta de tu logo
                width: 150,
                height: 150,
              ),
              SizedBox(height: 40),
              Text(
                'Iniciar Sesión:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Correo:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'correo@gmail.com',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        }
                        final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Por favor ingresa un correo electrónico válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Contraseña:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Ingrese Contraseña',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Botón Olvidé mi contraseña
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/olvidoContraseña');
                      },
                      child: Text(
                        'Olvidé mi contraseña',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    // Botón de recuperación de cuenta
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/recuperarCuenta');
                      },
                      child: Text(
                        '¿Recuperar mi cuenta?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginUser(_emailController.text.trim(),
                            _passwordController.text.trim(),
                            context);
                        }
                      },
                      child: Text('Iniciar sesión'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF335FB9),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                      ), 
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/crearCuenta');
                },
                child: Text(
                  'No tienes una cuenta ¡Crea una aquí!',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla principal
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    GlucometriasScreen(),
    RecetasScreen(),
    Center(child: Text('Reportes Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _getAppBarTitle(_selectedIndex),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ], 
        showBackButton: true, 
        onBackPressed: () { },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Glucometrías';
      case 2:
        return 'Recetas';
      case 3:
        return 'Reportes';
      default:
        return 'Inicio';
    }
  }
}
