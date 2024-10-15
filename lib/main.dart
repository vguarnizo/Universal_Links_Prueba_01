import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _linkMessage = 'No URL detected';
  int _sumResult = 0;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  // Manejar los enlaces entrantes
  Future<void> _handleIncomingLinks() async {
    try {
      // Suscribirse a los cambios de enlace entrante
      linkStream.listen((String? link) {
        if (link != null) {
          _parseUrl(link);
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // Parsear la URL y realizar la suma
  void _parseUrl(String link) {
    Uri uri = Uri.parse(link);
    if (uri.scheme == 'universallinksprueba') {
      // Extraer los parámetros
      final num1 = int.tryParse(uri.queryParameters['num1'] ?? '0') ?? 0;
      final num2 = int.tryParse(uri.queryParameters['num2'] ?? '0') ?? 0;
      // Sumar los números
      setState(() {
        _sumResult = num1 + num2;
        _linkMessage = 'Suma de $num1 + $num2 = $_sumResult';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter URL Scheme Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$_linkMessage', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text('Resultado: $_sumResult', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
