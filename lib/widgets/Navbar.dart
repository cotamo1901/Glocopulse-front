import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      selectedItemColor: Colors.white, // Color para el ítem seleccionado
      unselectedItemColor: Colors.white70, // Color para los ítems no seleccionados
      backgroundColor: Color(0xFF103B93), // Color de fondo del BottomNavigationBar
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fingerprint),
          label: 'Glucometrías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Receta',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report),
          label: 'Reportes',
        ),
      ],
    );
  }
}
