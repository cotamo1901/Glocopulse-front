import 'package:flutter/material.dart';
import 'package:nav_bar/widgets/Appbar.dart';
import 'package:nav_bar/widgets/Navbar.dart';

class DetalleGlucometriasScreen extends StatefulWidget {
  final String fecha;
  final String hora;
  final int glucometria;

  DetalleGlucometriasScreen({
    required this.fecha,
    required this.hora,
    required this.glucometria,
  });

  @override
  _DetalleGlucometriasScreenState createState() =>
      _DetalleGlucometriasScreenState();
}

class _DetalleGlucometriasScreenState extends State<DetalleGlucometriasScreen> {
  int _currentIndex = 1;

  final List<VoidCallback> _navigationActions = [
    () {}, // Acción para Home
    () {}, // Acción para Glucometría
    () {}, // Acción para Chat
    () {}, // Acción para Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () => Navigator.pop(context), // Acción de retroceso
        title: '', // Título vacío
        actions: const [], // Acciones vacías
        showBackButton: true, // Aquí aseguramos que se muestre la flecha de retroceso
      ),
      body: DefaultTabController(
        length: 2, // Número de pestañas
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Recomendaciones'),
                  Tab(text: 'Acudir al Médico'),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: [
                    // Pestaña 1: Recomendaciones
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Un nivel de glucosa en sangre de ${widget.glucometria} mg/dL puede estar dentro del rango adecuado dependiendo del momento del día (ayuno o postprandial). Si el objetivo es ayudar a mantener una glucosa estable, aquí tienes recomendaciones rápidas:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          _buildCard(
                            title: 'Glucometría',
                            value: '${widget.glucometria} mg/dL',
                          ),
                          SizedBox(height: 16),
                          _buildCard(
                            title: 'Estado',
                            value: 'Óptimo postprandial',
                            valueColor: Colors.grey[600],
                          ),
                          SizedBox(height: 16),
                          _buildCard(
                            title: 'Rango',
                            value: 'Normal',
                            valueColor: Colors.green,
                            trailingIcon: Icon(Icons.circle, color: Colors.green, size: 12),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Alimentación recomendada:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• Mantén una dieta balanceada, rica en frutas, verduras, proteínas magras y granos enteros.\n'
                            '• Evita azúcares simples y grasas saturadas.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // Pestaña 2: Acudir al Médico
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Es importante que una persona con diabetes o sospecha de diabetes acuda al médico si presenta alguno de los siguientes síntomas:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Síntomas de descontrol de glucosa alta (hiperglucemia):',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• Sed excesiva (polidipsia).\n'
                            '• Aumento en la frecuencia de orina (poliuria).\n'
                            '• Cansancio extremo o debilidad.\n'
                            '• Visión borrosa.\n'
                            '• Dolor de cabeza persistente.\n'
                            '• Heridas que tardan mucho en sanar.\n'
                            '• Pérdida de peso inesperada.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Señales de alerta que requieren atención inmediata:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• Dolor en el pecho o dificultad para respirar: Puede indicar problemas cardíacos o complicaciones severas.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Ejecutar la acción correspondiente
          _navigationActions[index]();
        },
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    Color? valueColor,
    Widget? trailingIcon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? Colors.black,
                ),
              ),
              if (trailingIcon != null) ...[
                SizedBox(width: 4),
                trailingIcon,
              ],
            ],
          ),
        ],
      ),
    );
  }
}
