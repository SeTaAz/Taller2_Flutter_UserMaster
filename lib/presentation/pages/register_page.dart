import 'package:flutter/material.dart';

import '../../core/utils/form_validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
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
                  AppTextField(
                    key: const Key('register-name'),
                    controller: _nameController,
                    label: 'Nombre completo',
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        FormValidators.requiredValue(value, 'tu nombre'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    key: const Key('register-email'),
                    controller: _emailController,
                    label: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: FormValidators.email,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    key: const Key('register-password'),
                    controller: _passwordController,
                    label: 'Contraseña',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        FormValidators.requiredValue(value, 'una contraseña'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    key: const Key('register-confirm-password'),
                    controller: _confirmationController,
                    label: 'Confirmar contraseña',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      final requiredError = FormValidators.requiredValue(
                        value,
                        'la contraseña',
                      );
                      if (requiredError != null) return requiredError;
                      if (value != _passwordController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    key: const Key('register-submit'),
                    label: 'Crear cuenta',
                    isLoading: _isLoading,
                    onPressed: _register,
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
