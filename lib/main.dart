import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(PiedraPapelTijerasLagartoSpock());
}

class PiedraPapelTijerasLagartoSpock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PiedraPapelTijerasLagartoSpockPage(),
      ),
    );
  }
}

class PiedraPapelTijerasLagartoSpockPage extends StatefulWidget {
  @override
  _PiedraPapelTijerasLagartoSpockPageState createState() =>
      _PiedraPapelTijerasLagartoSpockPageState();
}

class _PiedraPapelTijerasLagartoSpockPageState
    extends State<PiedraPapelTijerasLagartoSpockPage> {
  final Map<String, List<String>> resultados = {
    'piedra': ['tijeras', 'lagarto'],
    'papel': ['piedra', 'spock'],
    'tijeras': ['papel', 'lagarto'],
    'lagarto': ['papel', 'spock'],
    'spock': ['piedra', 'tijeras'],
  };

  final Map<String, String> frasesResultado = {
    'piedra-tijeras': 'Piedra aplasta Tijeras',
    'piedra-lagarto': 'Piedra aplasta Lagarto',
    'papel-piedra': 'Papel cubre Piedra',
    'papel-spock': 'Papel desaprueba a Spock',
    'tijeras-papel': 'Tijeras cortan Papel',
    'tijeras-lagarto': 'Tijeras decapitan Lagarto',
    'lagarto-papel': 'Lagarto se come el Papel',
    'lagarto-spock': 'Lagarto envenena Spock',
    'spock-piedra': 'Spock vaporiza la Piedra',
    'spock-tijeras': 'Spock destroza Tijeras',
  };

  String eleccionJugador = '';
  String eleccionComputadora = '';
  String resultado = '';

  void jugar(String eleccion) {
    final List<String> opciones = ['piedra', 'papel', 'tijeras', 'lagarto', 'spock'];
    final Random random = Random();
    final int indice = random.nextInt(5);
    final String eleccionComputadora = opciones[indice];

    setState(() {
      this.eleccionJugador = eleccion;
      this.eleccionComputadora = eleccionComputadora;

      if (eleccionJugador == eleccionComputadora) {
        resultado = '¡Es un empate! 🤝';
      } else if (resultados[eleccionJugador]?.contains(eleccionComputadora) ?? false) {
        resultado = '¡Ganaste! 🏆 \n(${frasesResultado["$eleccionJugador-$eleccionComputadora"]})';
      } else {
        resultado = '¡La computadora gana! 🤖 \n(${frasesResultado["$eleccionComputadora-$eleccionJugador"]})';
      }
    });
  }

  void mostrarInstrucciones() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Instrucciones"),
          content: Text(
            "Bienvenido a Piedra, Papel, Tijeras, Lagarto, Spock!\n\n"
                "Aquí están las reglas:\n"
                " - Tijeras cortan Papel\n"
                " - Papel cubre Piedra\n"
                " - Piedra aplasta Lagarto\n"
                " - Lagarto envenena Spock\n"
                " - Spock destroza Tijeras\n"
                " - Tijeras decapitan Lagarto\n"
                " - Lagarto se come el Papel\n"
                " - Papel desaprueba a Spock\n"
                " - Spock vaporiza la Piedra\n"
                " - Piedra aplasta Tijeras\n\n"
                "Toca OK para cerrar.",
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/ia.gif',
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text(
                  'Elige tu jugada:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => jugar('piedra'),
                      child: Text('🪨 Piedra'),
                    ),
                    ElevatedButton(
                      onPressed: () => jugar('papel'),
                      child: Text('📄 Papel'),
                    ),
                    ElevatedButton(
                      onPressed: () => jugar('tijeras'),
                      child: Text('✂️ Tijeras'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => jugar('lagarto'),
                      child: Text('🦎 Lagarto'),
                    ),
                    ElevatedButton(
                      onPressed: () => jugar('spock'),
                      child: Text('🖖 Spock'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Jugador: $eleccionJugador',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Computadora: $eleccionComputadora',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  '$resultado',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FloatingActionButton(
                onPressed: mostrarInstrucciones,
                tooltip: 'Instrucciones 📜',
                child: Icon(Icons.info),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
