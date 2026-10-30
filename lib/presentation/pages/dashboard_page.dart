import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UserMaster')),
      body: const Center(
        child: Text('Dashboard: se completará en la segunda entrega.'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        ),
        icon: const Icon(Icons.logout),
        label: const Text('Cerrar sesión'),
      ),
    );
  }
}
