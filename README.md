# taller_2_usermaster

Proyecto Flutter organizado en capas para separar la presentación, la lógica de
negocio y el acceso a datos.

## Estructura

```text
lib/
├── core/          # Recursos compartidos: temas, constantes, red y utilidades
├── data/          # Fuentes de datos, modelos, repositorios y mapeadores
├── domain/        # Entidades, contratos, casos de uso y excepciones
├── presentation/  # Páginas, widgets, rutas y gestión de estado
├── app.dart       # Configuración principal de la aplicación
└── main.dart      # Punto de entrada
test/
├── data/
├── domain/
├── presentation/
└── utils/
assets/            # Recursos estáticos
```

La primera entrega incluye el splash, inicio de sesión, registro y recuperación
de contraseña. La autenticación es simulada y el dashboard actual es provisional;
el contenido final de Inicio y Perfil se agregará en la segunda entrega.

El tema global y la paleta de colores están en `lib/core/themes/` y
`lib/core/constants/app_colors.dart`. Las rutas se centralizan en
`lib/presentation/routes/app_routes.dart`.

## Ejecutar

```sh
flutter pub get
flutter run
```

## Pruebas

```sh
flutter test
```

## Primer commit sugerido

```text
feat: add authentication flow and app structure
```
