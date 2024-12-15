import 'package:flutter/material.dart';
import 'package:nav_bar/widgets/Appbar.dart';
import 'package:nav_bar/widgets/Navbar.dart';

class AgregarGlucometriaScreen extends StatefulWidget {
  @override
  _AgregarGlucometriaScreenState createState() =>
      _AgregarGlucometriaScreenState();
}

class _AgregarGlucometriaScreenState extends State<AgregarGlucometriaScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController glucoseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () => Navigator.pop(context), // Acción de regreso
        title: 'Agregar Glucometría',
        showBackButton: true, actions: [], // Mostrar el botón de retroceso
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Por favor ingrese a continuación el dígito de glucosa en sangre que indica su glucómetro o dispositivo:',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 30),
              Text(
                'Fecha Glucometría',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 8),
              TextField(
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() => selectedDate = date);
                  }
                },
                decoration: InputDecoration(
                  hintText: selectedDate != null
                      ? '${selectedDate!.day} ${_getMonthName(selectedDate!.month)} ${selectedDate!.year}'
                      : '5 agosto 2026',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Hora Glucometría',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 8),
              TextField(
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() => selectedTime = time);
                  }
                },
                decoration: InputDecoration(
                  hintText: selectedTime != null
                      ? '${selectedTime!.hourOfPeriod}:${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.period == DayPeriod.am ? 'a.m' : 'p.m'}'
                      : '10:00:00 a.m',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Glucometría',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 8),
              TextField(
                controller: glucoseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '120 mg/dL',
                  prefixIcon: Icon(Icons.health_and_safety),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí va la lógica para agregar la glucometría
                    final glucoseValue = glucoseController.text;
                    final date = selectedDate != null
                        ? '${selectedDate!.day} ${_getMonthName(selectedDate!.month)} ${selectedDate!.year}'
                        : 'Fecha no seleccionada';
                    final time = selectedTime != null
                        ? '${selectedTime!.hourOfPeriod}:${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.period == DayPeriod.am ? 'a.m' : 'p.m'}'
                        : 'Hora no seleccionada';
                    // Agregar la glucometría aquí, por ejemplo, guardándola en una base de datos o en SharedPreferences
                    print('Glucometría: $glucoseValue, Fecha: $date, Hora: $time');
                  },
                  child: Text('Agregar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 16)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1, 
        onItemTapped: (index) {
          // Lógica de navegación para el BottomNavigationBar
        },
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    return months[month - 1];
  }
}
