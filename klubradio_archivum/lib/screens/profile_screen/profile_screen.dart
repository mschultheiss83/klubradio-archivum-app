import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_profile.dart';
import '../../services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = context.read<ApiService>().fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: FutureBuilder<UserProfile>(
        future: _profileFuture,
        builder:
            (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Hiba történt: ${snapshot.error}'),
            );
          }

          final UserProfile profile = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  profile.displayName.characters.take(2).toString().toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  profile.displayName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.mail_outline),
                title: const Text('E-mail'),
                subtitle: Text(profile.email),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Preferált nyelv'),
                subtitle: Text(profile.preferredLanguage.toUpperCase()),
              ),
              ListTile(
                leading: const Icon(Icons.library_music),
                title: const Text('Kedvenc műsorok'),
                subtitle: Text(profile.favoritePodcasts.join(', ')),
              ),
              const SizedBox(height: 24),
              const Text(
                'TODO: Integráljuk a profil szerkesztését és a Supabase '
                'felhasználói adatokat.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          );
        },
      ),
    );
  }
}
