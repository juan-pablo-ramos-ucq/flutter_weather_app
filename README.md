# WeatherScope

WeatherScope es una aplicación móvil desarrollada con Flutter para consultar el clima de ciudades y regiones de todo el mundo. El proyecto incluye autenticación con Google, almacenamiento local de los datos básicos del usuario y una interfaz preparada para buscar ubicaciones mediante la API de geocodificación de Open‑Meteo.

> **Estado actual:** el inicio de sesión y la visualización del perfil están implementados. El buscador de ciudades también está desarrollado, pero permanece desactivado en la pantalla principal. La consulta y presentación de las condiciones meteorológicas y del pronóstico todavía están pendientes de integración.

## Funcionalidades

- Inicio de sesión con una cuenta de Google.
- Almacenamiento local del nombre, correo electrónico y URL de la fotografía del usuario.
- Encabezado con la identidad visual de WeatherScope y acceso al perfil.
- Perfil presentado en una hoja modal con la fotografía y los datos de la cuenta.
- Manejo de imágenes de perfil ausentes, inválidas o no disponibles.
- Buscador de ciudades y regiones mediante la API de geocodificación de Open‑Meteo.
- Resultados de búsqueda con nombre, país, región, latitud y longitud.
- Interfaz adaptable basada en Material Design.

## Widgets principales

| Widget | Archivo | Responsabilidad |
| --- | --- | --- |
| `MyApp` | `lib/main.dart` | Configura el tema, las rutas y la pantalla inicial de la aplicación. |
| `GoogleLogin` | `lib/widgets/google_login.dart` | Muestra la pantalla de acceso, autentica al usuario con Google y guarda sus datos. |
| `Home` | `lib/widgets/home.dart` | Construye la pantalla principal y organiza el encabezado y el estado inicial. |
| `Header` | `lib/widgets/header.dart` | Combina el logotipo de la aplicación con el avatar del usuario. |
| `Logo` | `lib/widgets/logo.dart` | Presenta el icono, el nombre WeatherScope y su descripción breve. |
| `Avatar` | `lib/widgets/avatar.dart` | Carga la fotografía guardada del usuario y abre el panel de perfil al tocarla. |
| `ProfileSheet` | `lib/widgets/profile_sheet.dart` | Muestra el perfil en una hoja modal inferior y carga los datos persistidos. |
| `ProfileInfoTile` | `lib/widgets/profile_info_tile.dart` | Representa cada dato del perfil dentro de una tarjeta reutilizable. |
| `Vacio` | `lib/widgets/vacio.dart` | Muestra el estado inicial que invita al usuario a buscar una ubicación. |
| `SearchBarWidget` | `lib/widgets/search_bar.dart` | Busca ubicaciones en Open‑Meteo y devuelve las coordenadas de la ciudad elegida. Actualmente no está montado en `Home`. |

Además, `PreferencesService`, ubicado en `lib/services/shared_preferences.dart`, centraliza el guardado, la lectura y la eliminación de los datos del usuario mediante `shared_preferences`.

## Tecnologías y dependencias

- Flutter y Dart.
- `google_sign_in` para la autenticación con Google.
- `shared_preferences` para la persistencia local.
- `http` para las solicitudes a la API de Open‑Meteo.
- `google_fonts` para la tipografía de la interfaz.

## Requisitos

- Flutter compatible con Dart `^3.11.5`.
- Un dispositivo o emulador configurado.
- Credenciales de Google Sign-In configuradas para la plataforma de destino.
- Conexión a Internet para iniciar sesión, cargar la fotografía del perfil y buscar ciudades.

## Ejecución

Instala las dependencias:

```bash
flutter pub get
```

Comprueba la configuración del proyecto:

```bash
flutter doctor
```

Ejecuta la aplicación:

```bash
flutter run
```

## Estructura principal

```text
lib/
├── main.dart
├── services/
│   └── shared_preferences.dart
└── widgets/
    ├── avatar.dart
    ├── google_login.dart
    ├── header.dart
    ├── home.dart
    ├── logo.dart
    ├── profile_info_tile.dart
    ├── profile_sheet.dart
    ├── profile_sheet_method.dart
    ├── search_bar.dart
    └── vacio.dart
```

## Próximos pasos

- Activar `SearchBarWidget` en la pantalla principal.
- Consumir una API meteorológica utilizando las coordenadas seleccionadas.
- Mostrar las condiciones actuales y el pronóstico por hora.
- Añadir cierre de sesión y pruebas para los flujos de autenticación, perfil y búsqueda.
