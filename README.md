# WeatherScope

WeatherScope es una aplicación móvil desarrollada con Flutter para consultar el clima actual y el pronóstico por hora de ciudades y regiones de todo el mundo. Incluye autenticación con Google, persistencia local de la sesión y manejo de errores de red para ofrecer una experiencia estable incluso cuando el dispositivo no tiene conexión a Internet.

## Evolución del proyecto

El desarrollo se realizó de forma progresiva en tres iteraciones:

| Iteración | Resultado |
| --- | --- |
| [1. Inicio de sesión y pantalla principal](https://youtu.be/GB6bMlAj7-A) | Se incorporaron la identidad visual de WeatherScope, el acceso con Google, la pantalla principal, el avatar y la consulta de los datos básicos del perfil. |
| [2. Consulta y visualización del clima](https://youtu.be/IXDwoxfYM64) | Se habilitó la búsqueda de ciudades mediante la API de geocodificación de Open-Meteo y se creó la pantalla de clima con tarjetas de condiciones actuales y un pronóstico por hora. En esta etapa, el resumen meteorológico aún no estaba terminado. |
| 3. Persistencia y resiliencia | La aplicación ahora recuerda al usuario y abre directamente la pantalla principal después del primer inicio de sesión. También se añadieron estados de carga, control de solicitudes, `try/catch`, tiempos de espera y mensajes comprensibles ante fallos de las APIs o falta de Internet. Esta versión completa la tarjeta de resumen meteorológico. |

## Estado actual

La aplicación permite iniciar sesión con Google, buscar una ubicación y consultar su clima. La pantalla meteorológica presenta:

- Un resumen visual con temperatura, sensación térmica, condición del cielo, momento del día y lluvia.
- Humedad relativa, índice UV, nubosidad y presión atmosférica.
- Velocidad, dirección y ráfagas de viento.
- Precipitación actual.
- Pronóstico por hora del día en un carrusel horizontal.

Los colores, iconos y textos del resumen cambian según el código meteorológico, la nubosidad, la precipitación y si es de día o de noche.

## Funcionalidades

- Inicio de sesión con una cuenta de Google.
- Persistencia local del nombre, correo y URL de la fotografía mediante `shared_preferences`.
- Detección de una sesión guardada al arrancar para evitar solicitar el inicio de sesión cada vez que se abre la aplicación.
- Perfil en una hoja modal con los datos de la cuenta y opción para tomar una fotografía con la cámara.
- Manejo de fotografías de perfil ausentes, inválidas o no disponibles.
- Búsqueda de ciudades y regiones con resultados de nombre, país, región y coordenadas.
- Espera de 500 ms antes de buscar para reducir solicitudes innecesarias mientras el usuario escribe.
- Protección frente a respuestas antiguas para que una búsqueda lenta no reemplace resultados más recientes.
- Manejo de errores de conexión, tiempo de espera, respuestas inválidas y errores del servicio mediante mensajes visibles para el usuario.
- Indicadores de carga durante la búsqueda y la consulta meteorológica.
- Interfaz adaptable basada en Material Design.

## Flujo principal

1. Al iniciar, la aplicación revisa si existen datos de usuario guardados.
2. Si no existe una sesión local, muestra el acceso con Google; si existe, abre directamente la pantalla principal.
3. El usuario escribe una ciudad o región y selecciona uno de los resultados de Open-Meteo.
4. La aplicación utiliza las coordenadas elegidas para obtener las condiciones actuales y el pronóstico del día.
5. Mientras espera la respuesta muestra un indicador de carga. Si la solicitud falla, presenta un estado de error en lugar de cerrar la aplicación.

## Arquitectura principal

| Componente | Responsabilidad |
| --- | --- |
| `MyApp` | Inicializa Google Sign-In, comprueba la sesión local y configura las rutas principales. |
| `GoogleLogin` | Autentica al usuario con Google y guarda sus datos básicos. |
| `PreferencesService` | Centraliza la lectura, escritura y eliminación de los datos locales del usuario. |
| `Home` | Organiza el encabezado, el estado inicial y la búsqueda de ubicaciones. |
| `SearchBarContainer` | Gestiona el debounce, las solicitudes de geocodificación, los resultados y los errores de búsqueda. |
| `SearchBarView` | Renderiza el campo de búsqueda y la lista de ubicaciones. |
| `MostrarClimaContainer` | Obtiene los datos meteorológicos y controla los estados de carga, éxito y error. |
| `MostrarClima` | Compone la pantalla de resultados meteorológicos. |
| `Summary` | Muestra el resumen dinámico de las condiciones actuales. |
| `DetalleGrid` | Presenta las métricas actuales en una cuadrícula de tarjetas. |
| `HourlyForecastCarousel` | Muestra el pronóstico por hora en un carrusel horizontal. |
| `ProfileSheetContainer` | Carga el perfil y gestiona la captura de una fotografía. |

Los modelos `WeatherLocation` y `WeatherData` transportan, respectivamente, la ubicación seleccionada y los datos meteorológicos que consumen los widgets de presentación.

## APIs y dependencias

- [Open-Meteo Geocoding API](https://open-meteo.com/en/docs/geocoding-api) para buscar ubicaciones.
- [Open-Meteo Weather Forecast API](https://open-meteo.com/en/docs) para las condiciones actuales y el pronóstico por hora.
- `google_sign_in` para la autenticación con Google.
- `shared_preferences` para la persistencia local de la sesión.
- `http` para las solicitudes a las APIs.
- `image_picker` para capturar una fotografía de perfil.
- `google_fonts` para la tipografía de la interfaz.

Open-Meteo no requiere una clave de API para este uso. Google Sign-In sí debe configurarse con credenciales válidas para cada plataforma de destino.

## Requisitos

- Flutter con una versión de Dart compatible con `^3.11.5`.
- Un dispositivo físico o emulador configurado.
- Credenciales de Google Sign-In para la plataforma de destino.
- Permiso de cámara para capturar una fotografía de perfil.
- Conexión a Internet para iniciar sesión por primera vez y obtener información meteorológica actualizada.

La sesión local permite volver a abrir la aplicación sin autenticarse de nuevo. Si no hay conexión, las consultas remotas no pueden completarse, pero la interfaz controla el fallo y muestra un mensaje al usuario.

## Ejecución

Instala las dependencias:

```bash
flutter pub get
```

Comprueba la configuración de Flutter y de los dispositivos disponibles:

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
├── models/
│   ├── weather_data.dart
│   └── weather_location.dart
├── services/
│   └── shared_preferences.dart
└── widgets/
    ├── google_login.dart
    ├── header.dart
    ├── home.dart
    ├── hourly_forecast_card.dart
    ├── hourly_forecast_carousel.dart
    ├── mostrar_clima.dart
    ├── mostrar_clima_container.dart
    ├── search_bar.dart
    ├── search_bar_container.dart
    ├── summary.dart
    └── summary_chip.dart
```

## Posibles mejoras

- Añadir una acción explícita para cerrar la sesión.
- Guardar la última consulta meteorológica para mostrar datos recientes sin conexión.
- Permitir reintentar la consulta meteorológica desde el estado de error.
- Incorporar pruebas de los flujos de autenticación, búsqueda y visualización del clima.
