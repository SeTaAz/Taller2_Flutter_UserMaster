import 'package:flutter/material.dart';

import '../../core/utils/form_validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendRecoveryLink() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Se envió el enlace de recuperación a tu correo.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contraseña')),
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
                  const Text(
                    'Ingresa tu correo y te enviaremos un enlace de recuperación.',
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    key: const Key('recovery-email'),
                    controller: _emailController,
                    label: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.email,
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    key: const Key('recovery-submit'),
                    label: 'Enviar enlace de recuperación',
                    onPressed: _sendRecoveryLink,
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
