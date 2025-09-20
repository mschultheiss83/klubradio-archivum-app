import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Az alkalmazásról')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const <Widget>[
            Text(
              'Klubrádió archívum alkalmazás',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Az alkalmazás célja, hogy egyszerű hozzáférést biztosítson a Klubrádió '
              'archív műsoraihoz, és lehetőséget adjon RSS feedek létrehozására '
              'podcast lejátszók számára.',
            ),
            SizedBox(height: 12),
            Text(
              'Ez egy közösségi projekt, amely a Klubrádió támogatását szolgálja. '
              'Minden tartalom szabadon elérhető a rádió hivatalos oldalán.',
            ),
            SizedBox(height: 12),
            Text(
              'Kapcsolat: info@klubradio.hu (tartalom), '
              'TODO: developer@yourdomain.com (fejlesztői elérhetőség)',
            ),
          ],
        ),
      ),
    );
  }
}
