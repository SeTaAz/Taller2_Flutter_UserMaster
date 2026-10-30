import 'package:flutter/material.dart';

import '../../domain/entities/user_profile.dart';
import '../routes/app_routes.dart';
import 'profile_page.dart';

class _RecentItem {
  const _RecentItem(this.title, this.description, this.icon);

  final String title;
  final String description;
  final IconData icon;
}

const _recentItems = [
  _RecentItem(
    'Perfil actualizado',
    'Tu información de usuario está al día.',
    Icons.person_outline,
  ),
  _RecentItem(
    'Bienvenido a SpiderApp',
    'Explora las herramientas de tu cuenta.',
    Icons.waving_hand_outlined,
  ),
  _RecentItem(
    'Seguridad de la cuenta',
    'Recuerda mantener segura tu contraseña.',
    Icons.shield_outlined,
  ),
  _RecentItem(
    'Nueva actividad',
    'Tu espacio personal ya está listo.',
    Icons.notifications_none,
  ),
  _RecentItem(
    'Consejo del día',
    'Completa tu perfil para tener tus datos a mano.',
    Icons.lightbulb_outline,
  ),
];

class DashboardPage extends StatefulWidget {
  const DashboardPage({required this.profile, super.key});

  final UserProfile profile;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeTab(name: widget.profile.name),
      ProfilePage(profile: widget.profile, onLogout: _logout),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('SpiderApp'), centerTitle: false),
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatefulWidget {
  const _HomeTab({required this.name});

  final String name;

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentItems();
  }

  Future<void> _loadRecentItems() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(key: Key('dashboard-loading')),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Hola, ${widget.name}',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Aquí tienes tus novedades recientes.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        for (final item in _recentItems)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(child: Icon(item.icon)),
              title: Text(item.title),
              subtitle: Text(item.description),
            ),
          ),
      ],
    );
  }
}
