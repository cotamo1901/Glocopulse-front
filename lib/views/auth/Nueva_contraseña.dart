import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateNewPasswordPage(),
      theme: ThemeData(
        fontFamily: 'OpenSans', // Establecer Open Sans como fuente por defecto
      ),
    );
  }
}

class CreateNewPasswordPage extends StatefulWidget {
  @override
  _CreateNewPasswordPageState createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Título "Crea una contraseña nueva"
              Text(
                'Crea una contraseña nueva',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans', // Usando Open Sans
                  color: Color(0xFF0D1B34),
                ),
              ),
              SizedBox(height: 20),

              // Texto explicativo
              Text(
                'Crea una contraseña nueva y segura que no uses en otros sitios web.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'OpenSans',
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // Campo de Contraseña
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),

              // Campo de Repetir Contraseña
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Repetir Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),

              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón Cancelar (gris claro)
                  ElevatedButton(
                    onPressed: () {
                      // Acción para cancelar (puedes definir la acción según sea necesario)
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300], // Gris claro
                      foregroundColor: Colors.black,
                      minimumSize: Size(140, 50),
                    ),
                  ),
                  // Botón Buscar (azul)
                  ElevatedButton(
                    onPressed: () {
                      // Verifica si las contraseñas coinciden
                      if (_passwordController.text ==
                          _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Contraseña actualizada')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Las contraseñas no coinciden')),
                        );
                      }
                    },
                    child: Text('Confirmar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF335FB9), // Azul
                      foregroundColor: Colors.white,
                      minimumSize: Size(140, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
