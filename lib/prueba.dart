import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void>RegisterPage(String nombre,String apellido, String email, String numero, String genero,
    String password) async {
  var url = Uri.parse('http://192.168.0.19:5000/XD');
  var data = {
    "nombre": nombre,
    "apellido": apellido,
    'email': email,
    "genero": genero,
    'password': password,
  };

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      print('Usuario registrado');
    } else {
      print('Error al registrar usuario: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al hacer la solicitud: $e');
  }
}