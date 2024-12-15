import 'package:flutter/material.dart';
import 'package:nav_bar/views/glucometrias/Detalle_glucometrias.dart';
import 'package:nav_bar/views/glucometrias/agregar_glucometria.dart';



class GlucometriasScreen extends StatefulWidget {
  @override
  _GlucometriasScreenState createState() => _GlucometriasScreenState();
}

class _GlucometriasScreenState extends State<GlucometriasScreen> {

  List<Map<String, dynamic>> _glucometrias = [
    {'fecha': 'Sáb 05 ago 2006', 'hora': '10:24:00 a.m', 'glucometria': 120},
    {'fecha': 'Sáb 05 ago 2006', 'hora': '11:24:00 a.m', 'glucometria': 110},
    {'fecha': 'Sáb 05 ago 2006', 'hora': '12:24:00 p.m', 'glucometria': 130},
    {'fecha': 'Sáb 05 ago 2006', 'hora': '01:24:00 p.m', 'glucometria': 140},
    {'fecha': 'Sáb 05 ago 2006', 'hora': '02:24:00 p.m', 'glucometria': 125},
  ];

  List<bool> _selectedCards = List.generate(5, (index) => false);
  bool _isSelectionMode = false;

  void _toggleSelection(int index) {
    setState(() {
      _selectedCards[index] = !_selectedCards[index];
      _isSelectionMode = _selectedCards.contains(true);
    });
  }

  void _deleteSelectedCards() {
    setState(() {
      List<int> selectedIndices = [];
      for (int i = 0; i < _selectedCards.length; i++) {
        if (_selectedCards[i]) {
          selectedIndices.add(i);
        }
      }

      for (int i = selectedIndices.length - 1; i >= 0; i--) {
        _glucometrias.removeAt(selectedIndices[i]);
      }

      _selectedCards = List.generate(_glucometrias.length, (index) => false);
      _isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, spreadRadius: 2),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Próxima toma Glucometría:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Fecha: Sáb 05 ago 2006',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Hora: 12:00:00 p.m',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AgregarGlucometriaScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            if (_isSelectionMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: _deleteSelectedCards,
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                itemCount: _glucometrias.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _toggleSelection(index),
                    child: Card(
                      color: _selectedCards[index] ? Colors.blue.withOpacity(0.2) : Colors.white,
                      child: ListTile(
                        title: Text('${_glucometrias[index]['fecha']} | ${_glucometrias[index]['hora']}'),
                        subtitle: Text('Glucometría: ${_glucometrias[index]['glucometria']} mg/dL'),
                        onTap: () {
                          if (_isSelectionMode) {
                            _toggleSelection(index);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalleGlucometriasScreen(
                                  fecha: _glucometrias[index]['fecha'],
                                  hora: _glucometrias[index]['hora'],
                                  glucometria: _glucometrias[index]['glucometria'],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
