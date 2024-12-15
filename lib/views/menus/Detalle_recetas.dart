import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF4F8FC),
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.blueGrey,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue,
          ),
        ),
      ),
      home: RecetasScreen(),
    );
  }
}

class RecetasScreen extends StatefulWidget {
  @override
  _RecetasScreenState createState() => _RecetasScreenState();
}

class _RecetasScreenState extends State<RecetasScreen> {
  Set<String> favoritos = {};

  final List<Map<String, String>> recetas = [
    {
      "title": "Chocolate",
      "image": "assets/Recursos recetas/chocolate.png",  // Cambiado a Image.asset
      "ingredientes": """4 ½ tazas de agua
1 raja de canela
120 gramos de avena""",
      "preparacion": "1. Hierve el agua con la canela.\n2. Añade la avena y cocina por 5 minutos.",
    },
    {
      "title": "Arroz con leche",
      "image": "assets/Recursos recetas/arrozLeche.png",  // Cambiado a Image.asset
      "ingredientes": """1 taza de arroz, remojado en agua caliente por 20 minutos y escurrido
1 lata de leche evaporada sin azúcar (puedes elegir una versión baja en grasa)
½ taza de pasas (preferiblemente sin azúcar añadida)
1 cucharada de canela molida
1-2 cucharaditas de edulcorante sin calorías (como stevia, sucralosa o eritritol), o al gusto""",
      "preparacion": "1. Cocina el arroz con la leche.\n2. Agrega el azúcar al gusto.",
    },
    {
      "title": "Cheesecake de mora",
      "image": "assets/Recursos recetas/mora.png",  // Cambiado a Image.asset
      "ingredientes": """250g de queso crema
1 taza de azúcar
Moras al gusto""",
      "preparacion": "1. Mezcla el queso crema con el azúcar.\n2. Coloca las moras sobre la mezcla.",
    },
    {
      "title": "Arroz con camarones",
      "image": "assets/Recursos recetas/camarones.png",  // Cambiado a Image.asset
      "ingredientes": """1 taza de arroz
1 taza de macarrones
2 tazas de caldo de pollo
Ajo, cebolla, y pimienta al gusto""",
      "preparacion": "1. Cocina el arroz y los macarrones por separado.\n2. Mezcla con el caldo de pollo y los condimentos.",
    },
    {
      "title": "Pasta Alfredo",
      "image": "assets/Recursos recetas/pasta.png",  // Cambiado a Image.asset
      "ingredientes": """250g de pasta
1 taza de crema de leche
1/2 taza de queso parmesano rallado
Ajo al gusto
Sal y pimienta""",
      "preparacion": "1. Cocina la pasta al dente.\n2. Mezcla con la crema, el queso parmesano y el ajo. Cocina hasta que espese.",
    },
  ];

  void toggleFavorito(String receta) {
    setState(() {
      if (favoritos.contains(receta)) {
        favoritos.remove(receta);
      } else {
        favoritos.add(receta);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(00.0),
            child: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.blueGrey,
              tabs: [
                Tab(text: 'Favoritos'),
                Tab(text: 'Populares'),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: TabBarView(
            children: [
              // Pestaña Favoritos
              _buildRecetasList(
                recetas.where((receta) => favoritos.contains(receta['title'])).toList(),
              ),
              // Pestaña Populares
              _buildRecetasList(recetas),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecetasList(List<Map<String, String>> recetas) {
    return ListView.builder(
      itemCount: recetas.length,
      itemBuilder: (context, index) {
        final recetaTitle = recetas[index]['title']!;
        final isFavorito = favoritos.contains(recetaTitle);

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(  // Cambiado a Image.asset
                recetas[index]['image']!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              recetas[index]['title']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleRecetaScreen(
                    title: recetas[index]['title']!,
                    image: recetas[index]['image']!,
                    ingredientes: recetas[index]['ingredientes']!,
                    preparacion: recetas[index]['preparacion']!,
                    toggleFavorito: toggleFavorito, // Pasamos la función toggle
                    isFavorito: isFavorito, // Pasamos si es favorito o no
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class DetalleRecetaScreen extends StatefulWidget {
  final String title;
  final String image;
  final String ingredientes;
  final String preparacion;
  final bool isFavorito;
  final Function(String) toggleFavorito;

  DetalleRecetaScreen({
    required this.title,
    required this.image,
    required this.ingredientes,
    required this.preparacion,
    required this.toggleFavorito,
    required this.isFavorito,
  });

  @override
  _DetalleRecetaScreenState createState() => _DetalleRecetaScreenState();
}

class _DetalleRecetaScreenState extends State<DetalleRecetaScreen> {
  late bool isFavorito;

  @override
  void initState() {
    super.initState();
    isFavorito = widget.isFavorito;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorito ? Icons.favorite : Icons.favorite_border,
              color: isFavorito ? Colors.red : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                isFavorito = !isFavorito;
              });
              widget.toggleFavorito(widget.title);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(  // Cambiado a Image.asset
            widget.image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Ingredientes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.ingredientes,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Preparación",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.preparacion,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
