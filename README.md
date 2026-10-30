# SpiderApp

Aplicación Flutter creada para el taller **UserMaster - App Base con Clean
Architecture**. Incluye una interfaz de autenticación, navegación y un dashboard
con perfil de usuario. La autenticación y la carga de novedades son simuladas
localmente; no se conecta a un backend.

## Objetivos

- Practicar la organización de un proyecto Flutter por capas.
- Construir las pantallas de splash, inicio de sesión, registro, recuperación de
  contraseña, dashboard y perfil.
- Centralizar las rutas y reutilizar widgets de formularios y botones.
- Usar estados locales y `Future.delayed` para simular operaciones asíncronas.
- Publicar la versión web mediante GitHub Pages y GitHub Actions.

## Tech Stack

- Flutter 3.47.7
- Dart 3.13.5
- Material 3
- Flutter Test
- GitHub Actions y GitHub Pages

## Estructura del proyecto

```text
lib/
├── core/
│   ├── constants/       # Colores globales
│   ├── errors/
│   ├── network/
│   ├── themes/          # Tema de la aplicación
│   ├── utils/           # Validación de formularios
│   └── widgets/         # Botón y campo de texto reutilizables
├── data/
│   ├── datasources/
│   ├── mappers/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/        # Perfil de usuario
│   ├── exceptions/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── blocs/
│   ├── pages/           # Splash, autenticación, dashboard y perfil
│   ├── routes/          # Rutas centralizadas
│   ├── themes/
│   └── widgets/
├── app.dart
└── main.dart
test/
assets/
web/

## Requisitos

- Flutter 3.47.7 o una versión compatible.
- Dart incluido con Flutter.
- Un navegador compatible o un dispositivo/emulador para ejecutar la aplicación.

## Ejecutar la aplicación

Instala las dependencias:

```sh
flutter pub get
```

Para ejecutarla en un navegador con el servidor web de Flutter:

```sh
flutter run -d web-server
```

Abre en el navegador la dirección local que indique Flutter y deja la terminal
activa mientras pruebas la aplicación.

## Probar

Ejecuta las pruebas de widgets:

```sh
flutter test
```

Ejecuta el análisis estático:

```sh
flutter analyze
```

## Flujo de la aplicación

1. El splash muestra el logo durante 3 segundos y luego abre el inicio de sesión.
2. El login valida el correo y la contraseña, simula una carga de 2 segundos y
   abre el dashboard. Acepta cualquier correo válido y contraseña no vacía.
3. El registro valida los campos y que ambas contraseñas coincidan; después de
   simular el registro, vuelve al login. No crea una cuenta persistente.
4. La recuperación valida el correo y confirma el envío con un `SnackBar`; no
   envía un correo real.
5. El dashboard muestra Inicio y Perfil. Las novedades se cargan localmente con
   una demora simulada.
6. Cerrar sesión desde Perfil elimina las rutas anteriores y vuelve al login.

## Autor

[SeTaAz](https://github.com/SeTaAz)
