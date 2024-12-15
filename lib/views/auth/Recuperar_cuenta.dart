import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecoverAccountPage(),
      theme: ThemeData(
        fontFamily: 'OpenSans', // Establecer Open Sans como fuente por defecto
      ),
    );
  }
}

class RecoverAccountPage extends StatefulWidget {
  @override
  _RecoverAccountPageState createState() => _RecoverAccountPageState();
}

class _RecoverAccountPageState extends State<RecoverAccountPage> {
  final _emailController = TextEditingController();

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
              // Título "Recupera tu cuenta"
              Text(
                'Recupera tu cuenta',
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
                'Introduce tu correo electrónico o número de móvil para buscar tu cuenta.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'OpenSans',
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // Campo de correo
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico o móvil',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
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
                      // Acción para buscar cuenta (puedes definir la acción según sea necesario)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Buscando cuenta...')),
                      );
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