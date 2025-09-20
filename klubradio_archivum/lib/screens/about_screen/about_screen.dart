import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Névjegy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Klubrádió Archívum alkalmazás',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: kDefaultPadding),
            Text(
              'Ez egy közösségi projekt, amely segít a Klubrádió archív tartalmainak '
              'kényelmes elérésében, lejátszásában és RSS formátumba rendezésében.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: kDefaultPadding),
            Text(
              'A tartalmak mindenki számára ingyenesen hozzáférhetők. '
              'Az alkalmazás nem áll kapcsolatban a Klubrádióval, '
              'és nem kér semmilyen fizetést a műsorokért.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: kDefaultPadding),
            Text(
              'Verzió: 0.1.0 (fejlesztés alatt)\nFejlesztő: Klubrádió közösség',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
