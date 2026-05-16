import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sections/about_section.dart';
import 'sections/appearance_section.dart';
import 'sections/collections_section.dart';
import 'sections/notifications_section.dart';
import 'sections/wird_sources_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: const [
            WirdSourcesSection(),
            SizedBox(height: 28),
            CollectionsSection(),
            SizedBox(height: 28),
            NotificationsSection(),
            SizedBox(height: 28),
            AppearanceSection(),
            SizedBox(height: 28),
            ComingSoonTile(
              title: 'Tasbih counter',
              subtitle: 'A standalone counter for free-form dhikr',
            ),
            SizedBox(height: 28),
            AboutSection(),
          ],
        ),
      ),
    );
  }
}
