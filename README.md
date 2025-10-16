# proyecto1_compu_movil
hola, trabajo 1 de compu movil

**Borra las dependecias y cosas cuando se buggea y no corre a veces**
flutter clean 
**Baja las dependencias, se hace despues del clean o cuando se baja el repo por primera vez**
flutter pub get

🚀 Descripción Rápida

Aplicación móvil desarrollada en Flutter para dispositivos Android. Permite a los usuarios autenticarse mediante Firebase Authentication y consumir la API de votación disponible en https://api.sebastian.cl/vote.

El proyecto debe implementar una arquitectura por capas (Presentación, Dominio, Datos) y garantizar un flujo de inicio de sesión seguro, con soporte obligatorio para la autenticación con Google.

🛠️ Tecnologías Clave

    Framework: Flutter 

Lenguaje: Dart

Autenticación: Firebase Authentication (con Google Sign-In) 

Gestor de Estado (Recomendado): Riverpod o Bloc 

Cliente HTTP (Recomendado): Dio (con uso de interceptores) 

Arquitectura: Limpia (Capa, Dominio, Datos) 

⚙️ Configuración e Instalación

1. Requisitos

Necesitas tener instalado el Flutter SDK  (versión estable) y un editor como VS Code o Android Studio.

2. Clonar el Repositorio

Bash

git clone <https://github.com/bsainzzz/proyecto1_compu_movil.git>

3. Configuración de Firebase

    Crea un proyecto en Firebase y registra una app de Android.

Habilita Google Sign-In como método de autenticación.

Agrega el archivo google-services.json a android/app/.

Importante: Añade las huellas SHA-1 requeridas a tu proyecto de Firebase:

    6C:93:6F:47:18:74:7C:16:F5:1B:9F:62:E5:7A:D0:96:01:8C:EE:19 

D4:FC:F5:44:4E:56:AD:1E:05:50:19:87:5D:78:48:3D:28:BF:5A:B7 

4. Instalar Dependencias

Bash

flutter pub get

5. Ejecutar la App

Con un dispositivo o emulador Android en ejecución:
Bash

flutter run

🛡️ Seguridad y Buenas Prácticas

    Variables de Entorno: No se deben incluir credenciales en el código fuente. Usa una herramienta de gestión de variables de entorno.

Pruebas: Incluir pruebas unitarias y de widgets con cobertura razonable en Dominio y Datos.

Integración Continua (CI): Configurar un flujo que verifique análisis estático, pruebas y compilación.

Se entrega el 21 de Octubre
