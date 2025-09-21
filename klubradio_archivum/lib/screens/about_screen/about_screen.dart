import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A Klubrádió Archívum alkalmazásról'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          Text(
            'A Klubrádió Archívum célja, hogy könnyen elérhetővé tegye a rádió '
            'műsorait podcast formában. Az alkalmazás a nyilvános archívum '
            'adataira épít, így bárki visszahallgathatja a kedvenc adásait.',
          ),
          SizedBox(height: 24),
          Text(
            'Fő funkciók:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('• műsorok böngészése és keresése'),
          Text('• RSS feedek generálása podcast alkalmazásokhoz'),
          Text('• offline letöltés és automatikus frissítés'),
          Text('• magyar nyelvű hallgatói élmény'),
          SizedBox(height: 24),
          Text(
            'TODO: Egészítsük ki hivatalos jogi nyilatkozattal és a Klubrádió '
            'adományozási információival, amint rendelkezésre állnak.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
