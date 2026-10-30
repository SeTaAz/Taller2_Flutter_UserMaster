import 'package:flutter/material.dart';

import '../../domain/entities/user_profile.dart';
import '../../core/utils/form_validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.dashboard,
      arguments: UserProfile(
        name: 'Usuario',
        email: _emailController.text.trim(),
      ),
    );
  }

  Future<void> _openRegister() async {
    final registered = await Navigator.pushNamed(context, AppRoutes.register);
    if (!mounted || registered != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cuenta creada. Ya puedes iniciar sesión.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.people_alt_rounded, size: 72),
                  const SizedBox(height: 12),
                  Text(
                    'Bienvenido a SpiderApp',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 28),
                  AppTextField(
                    key: const Key('login-email'),
                    controller: _emailController,
                    label: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: FormValidators.email,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    key: const Key('login-password'),
                    controller: _passwordController,
                    label: 'Contraseña',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        FormValidators.requiredValue(value, 'tu contraseña'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.forgotPassword,
                      ),
                      child: const Text('¿Olvidaste tu contraseña?'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppButton(
                    key: const Key('login-submit'),
                    label: 'Ingresar',
                    isLoading: _isLoading,
                    onPressed: _login,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _openRegister,
                    child: const Text('¿No tienes cuenta? Regístrate'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
