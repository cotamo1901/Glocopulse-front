import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final String title; // Título dinámico para la AppBar
  final bool showBackButton; // Nuevo parámetro para decidir si mostrar el botón de retroceso

  // Constructor con el parámetro showBackButton para controlar si mostrar el botón de atrás
  CustomAppBar({
    required this.onBackPressed,
    required this.title,
    required this.showBackButton, required List actions, // Recibe la variable para mostrar el botón de atrás
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Evita el icono de "atrás" por defecto
      toolbarHeight: 100, // altura del AppBar
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Si showBackButton es verdadero, mostramos el icono de retroceso
          if (showBackButton)
            IconButton(
              icon: Icon(Icons.arrow_back, size: 24),
              onPressed: onBackPressed, // Acción para el botón de atrás
            ),
          SizedBox(width: 8),
          // Usamos Expanded para evitar desbordamientos en el Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  title, // Título dinámico que varía por pantalla
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Espacio entre el título y el avatar
          Padding(
            padding: const EdgeInsets.only(right: 8.0), // Añadir espacio entre el avatar y el borde
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/perfil.png'), // Imagen de perfil
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0, 
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100); // Altura de la AppBar para personalizar
}
