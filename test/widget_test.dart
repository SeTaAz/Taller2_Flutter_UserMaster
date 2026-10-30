import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taller_2_usermaster/app.dart';

void main() {
  testWidgets('splash opens login after three seconds', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('SpiderApp'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Iniciar sesión'), findsNothing);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });

  testWidgets('login validates and simulates loading before dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pumpAndSettle();
    expect(find.text('Ingresa tu correo electrónico'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('login-email')),
      'usuario@example.com',
    );
    await tester.enterText(find.byKey(const Key('login-password')), 'password');
    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const Key('dashboard-loading')), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Hola, Usuario'), findsOneWidget);
    expect(find.text('Perfil actualizado'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();
    expect(find.text('Consejo del día'), findsOneWidget);
  });

  testWidgets('dashboard switches to profile and logs out', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('login-email')),
      'usuario@example.com',
    );
    await tester.enterText(find.byKey(const Key('login-password')), 'password');
    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Usuario'), findsOneWidget);
    expect(find.text('Perfil actualizado'), findsOneWidget);

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    expect(find.text('usuario@example.com'), findsOneWidget);
    expect(find.text('Usuario'), findsOneWidget);
    expect(find.byKey(const Key('logout-button')), findsOneWidget);

    await tester.tap(find.byKey(const Key('logout-button')));
    await tester.pumpAndSettle();
    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(find.text('SpiderApp'), findsNothing);
  });

  testWidgets('registration rejects passwords that do not match', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    await tester.tap(find.text('¿No tienes cuenta? Regístrate'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('register-name')), 'Usuario');
    await tester.enterText(
      find.byKey(const Key('register-email')),
      'usuario@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('register-password')),
      'password1',
    );
    await tester.enterText(
      find.byKey(const Key('register-confirm-password')),
      'password2',
    );
    await tester.tap(find.byKey(const Key('register-submit')));
    await tester.pumpAndSettle();

    expect(find.text('Las contraseñas no coinciden'), findsOneWidget);
    expect(find.byKey(const Key('register-submit')), findsOneWidget);
  });

  testWidgets('registration returns to login after simulated creation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    await tester.tap(find.text('¿No tienes cuenta? Regístrate'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('register-name')), 'Usuario');
    await tester.enterText(
      find.byKey(const Key('register-email')),
      'usuario@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('register-password')),
      'password',
    );
    await tester.enterText(
      find.byKey(const Key('register-confirm-password')),
      'password',
    );
    await tester.tap(find.byKey(const Key('register-submit')));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(
      find.text('Cuenta creada. Ya puedes iniciar sesión.'),
      findsOneWidget,
    );
  });

  testWidgets('forgot password confirms sending recovery link', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    await tester.tap(find.text('¿Olvidaste tu contraseña?'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('recovery-email')),
      'usuario@example.com',
    );
    await tester.tap(find.byKey(const Key('recovery-submit')));
    await tester.pump();
    expect(
      find.text('Se envió el enlace de recuperación a tu correo.'),
      findsOneWidget,
    );
  });
}
