<div align="center">
  <div>
    <img src="https://img.shields.io/badge/-Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Logo" width="260">
    <h2 align="center">Arquetipo Flutter</h2>
  </div>

  <p align="center">
    Plantilla de aplicación móvil con Flutter 3.50, Clean Architecture y un pipeline de calidad estricto
    <br />
    <a href="https://github.com/Saisho137/Archetype_Flutter"><strong>Explorar Repositorio</strong></a>
  </p>

  <a href="https://github.com/Saisho137/Archetype_Flutter/actions/workflows/ci.yml"><img src="https://github.com/Saisho137/Archetype_Flutter/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
</div>

<details>
  <summary>Tabla de contenidos</summary>
  <ol>
    <li>
      <a href="#sobre-el-proyecto">Sobre el proyecto</a>
      <ul>
        <li><a href="#construido-con">Construido con</a></li>
      </ul>
    </li>
    <li>
      <a href="#cómo-empezar">Cómo empezar</a>
      <ul>
        <li><a href="#prerrequisitos">Prerrequisitos</a></li>
        <li><a href="#instalación">Instalación</a></li>
        <li><a href="#comandos">Comandos</a></li>
      </ul>
    </li>
    <li>
      <a href="#documentación">Documentación</a>
      <ul>
        <li>
          <a href="#estándares">Estándares</a>
          <ul>
            <li><a href="#estructura-de-carpetas">Estructura de carpetas</a></li>
            <li><a href="#capas-y-dependencias">Capas y dependencias</a></li>
            <li><a href="#importaciones">Importaciones</a></li>
            <li><a href="#linters">Linters</a></li>
            <li><a href="#estilos">Estilos</a></li>
            <li><a href="#manejo-de-errores">Manejo de errores</a></li>
            <li><a href="#accesibilidad">Accesibilidad</a></li>
            <li><a href="#testing">Testing</a></li>
            <li><a href="#ambientes">Ambientes</a></li>
            <li><a href="#git-hooks-y-ci">Git hooks y CI</a></li>
          </ul>
        </li>
        <li>
          <a href="#guías-adicionales">Guías adicionales</a>
          <ul>
            <li><a href="#crear-un-proyecto-a-partir-del-arquetipo">Crear un proyecto a partir del arquetipo</a></li>
            <li><a href="#crear-una-feature">Crear una feature</a></li>
            <li><a href="#base-de-datos-y-migraciones">Base de datos y migraciones</a></li>
            <li><a href="#navegación">Navegación</a></li>
            <li><a href="#internacionalización">Internacionalización</a></li>
            <li><a href="#íconos-y-assets">Íconos y assets</a></li>
            <li><a href="#firma-de-release">Firma de release</a></li>
            <li><a href="#notas-de-flutter-350-y-dart-314">Notas de Flutter 3.50 y Dart 3.14</a></li>
            <li><a href="#mantenimiento">Mantenimiento</a></li>
          </ul>
        </li>
      </ul>
    </li>
  </ol>
</details>

<!-- SOBRE EL PROYECTO -->

## Sobre el proyecto

Guía autoexplicativa para construir una app Flutter sólida y mantenible. Define la estructura de carpetas, las tecnologías, las configuraciones de calidad y un ejemplo completo (la feature `tasks`) que muestra cómo se conectan todas las capas, de la base de datos a la UI, con pruebas en cada una.

La feature `tasks` y sus pruebas son solo de ejemplo: se espera que se borren al construir una nueva aplicación (ver [Crear un proyecto a partir del arquetipo](#crear-un-proyecto-a-partir-del-arquetipo)).

### Construido con

- [![Flutter]][flutter-url]
- [![Dart]][dart-url]
- [![Bloc]][bloc-url]
- [![Drift]][drift-url]
- [![GoRouter]][gorouter-url]
- [![GitHubActions]][githubactions-url]

| Necesidad | Librería |
|---|---|
| UI | `material_ui` (Material 3 oficial) con tema propio |
| Estado | `flutter_bloc` (Bloc/Cubit) + `freezed` para estados inmutables |
| Inyección de dependencias | `get_it` |
| Navegación | `go_router` |
| Persistencia local | `drift` (SQLite tipado y reactivo) |
| Internacionalización | `flutter_localizations` + `intl` (`gen-l10n` con ARB) |
| Calidad | `very_good_analysis`, `bloc_test`, `mocktail` |

## Cómo empezar

Para ejecutar este proyecto localmente, siga las instrucciones a continuación.

### Prerrequisitos

- Flutter 3.50 (canal stable)
  - Si usa [FVM](https://fvm.app), ejecute `fvm use`: la versión está fijada en `.fvmrc`.
  - Si no usa FVM, instale la versión indicada en `.fvmrc`.
- Android SDK con Java 17 o superior (incluido en Android Studio).
- `make` (incluido en macOS y Linux; en Windows, use Git Bash o WSL).

### Instalación

1. Clonar el repositorio
   ```sh
   git clone https://github.com/Saisho137/Archetype_Flutter.git
   ```
2. Instalar las dependencias y activar los git hooks
   ```sh
   cd Archetype_Flutter && make setup
   ```
3. Validar las variables de ambiente
   ```sh
   env/dev.json
   ```
4. Ejecutar la app
   ```sh
   make run            # ambiente dev
   make run ENV=prod   # ambiente prod
   ```
5. Construir un APK de debug
   ```sh
   make build
   ```

> Pub no permite scripts de instalación (no hay un equivalente a `npm prepare`), por eso los git hooks se activan una sola vez con `make setup`.

### Comandos

`make help` lista todos los comandos. Los principales:

| Comando | Qué hace |
|---|---|
| `make setup` | Instala dependencias y activa los git hooks |
| `make run` | Ejecuta la app (`ENV=dev` por defecto) |
| `make format` | Formatea el código (equivalente a Prettier) |
| `make lint` | Análisis estático estricto (equivalente a ESLint) |
| `make test` | Pruebas unitarias y de widgets |
| `make coverage-check` | Pruebas con cobertura; falla si baja de `MIN_COVERAGE` (80%) |
| `make gen` | Generación de código (drift, freezed) |
| `make l10n` | Regenera las traducciones |
| `make build` | APK de debug |
| `make build-release` | App Bundle de release (`ENV=prod`) |
| `make check` | Formato + lint + pruebas con cobertura + build |

## Documentación

Esta sección enumera y explica los estándares y guías del arquetipo.

### Estándares

#### Estructura de carpetas

El siguiente diagrama muestra la estructura principal del proyecto:

    .
    ├── .githooks/                      # pre-commit, commit-msg, pre-push
    ├── .github/                        # CI, Dependabot, plantilla de PR
    ├── .vscode/                        # Ajustes, extensiones y launch configs compartidos
    ├── android/
    ├── env/
    │   ├── dev.json
    │   └── prod.json
    ├── lib/
    │   ├── main.dart                   # Punto de entrada
    │   ├── bootstrap.dart              # Errores globales, Bloc observer, DI, runApp
    │   ├── app/
    │   │   ├── di/injector.dart        # get_it: registra core y features
    │   │   ├── observers/
    │   │   ├── router/                 # go_router y nombres de rutas
    │   │   └── view/app.dart           # MaterialApp: tema, l10n, router
    │   ├── core/                       # Transversal, sin lógica de negocio
    │   │   ├── config/env.dart
    │   │   ├── database/app_database.dart
    │   │   ├── error/                  # Failure y Result
    │   │   ├── extensions/
    │   │   ├── theme/                  # ThemeData, tokens y espaciados
    │   │   └── usecase/
    │   ├── features/
    │   │   └── tasks/                  # Feature de ejemplo
    │   │       ├── data/
    │   │       │   ├── datasources/    # Tablas y DAOs de drift
    │   │       │   ├── models/         # Mappers fila → entidad
    │   │       │   └── repositories/   # Implementación del repositorio
    │   │       ├── domain/
    │   │       │   ├── entities/
    │   │       │   ├── repositories/   # Contratos
    │   │       │   └── usecases/
    │   │       ├── presentation/
    │   │       │   ├── cubit/
    │   │       │   ├── pages/
    │   │       │   └── widgets/
    │   │       └── tasks_injection.dart
    │   └── l10n/
    │       ├── arb/                    # Fuentes de traducción
    │       └── gen/                    # Generado
    ├── test/                           # Refleja la estructura de lib/
    │   └── helpers/                    # pumpApp, fakes
    ├── tool/                           # Scripts en Dart (renombrar, cobertura)
    ├── .editorconfig
    ├── .fvmrc
    ├── analysis_options.yaml
    ├── l10n.yaml
    ├── Makefile
    └── pubspec.yaml

- Carpeta `app`: composición de la aplicación. Es el único lugar que conoce todas las features.
- Carpeta `core`: código transversal y reutilizable, sin reglas de negocio.
- Carpeta `features`: una carpeta por funcionalidad, cada una con sus tres capas. Una feature no importa archivos internos de otra; si necesitan compartir algo, se sube a `core`.
- Carpeta `test`: refleja `lib/` archivo por archivo, para encontrar cada prueba sin buscarla.
- Carpeta `tool`: scripts de mantenimiento escritos en Dart, sin dependencias externas.

#### Capas y dependencias

```
presentation ──▶ domain ◀── data
```

- **domain:** entidades, contratos de repositorio y casos de uso. Dart puro: no importa Flutter, drift ni ningún framework.
- **data:** implementa los contratos. Traduce las filas de la base de datos a entidades y las excepciones a `Failure`.
- **presentation:** Cubits/Blocs, páginas y widgets. Solo conoce los casos de uso.

Cada página se divide en `XPage`, que inyecta dependencias con `BlocProvider`, y `XView`, que solo dibuja; así la vista se prueba con un Cubit simulado.

#### Importaciones

- Siempre imports de paquete (`package:flutter_archetype/...`), nunca relativos dentro de `lib/`. El linter lo valida con `always_use_package_imports`.
- Material se importa desde `package:material_ui/material_ui.dart` (ver [Notas de Flutter 3.50](#notas-de-flutter-350-y-dart-314)).
- Orden: `dart:`, paquetes y luego imports del proyecto, cada grupo en orden alfabético. El linter valida el orden (`directives_ordering`) y VS Code lo corrige al guardar.

```dart
import 'dart:async';

import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
```

#### Linters

- Reglas: [`very_good_analysis`](https://pub.dev/packages/very_good_analysis), en `analysis_options.yaml`. Se desactiva `public_member_api_docs` porque es una app, no un paquete publicado.
- `make lint` falla incluso con *infos* (`--fatal-infos`).
- Formato: `dart format`, con 80 columnas. No requiere configuración.
- Propiedades del editor: `.editorconfig`. Ajustes de VS Code: `.vscode/settings.json` (formato y *fix all* al guardar).
- El código generado (`*.g.dart`, `*.freezed.dart`, `lib/l10n/gen`) se excluye del análisis.

#### Estilos

Flutter no tiene CSS: el equivalente es el **tema**.

- `core/theme/app_theme.dart`: `ThemeData` claro y oscuro a partir de un `ColorScheme`. La app sigue el modo del sistema.
- `core/theme/app_tokens.dart`: tokens propios con `ThemeExtension` (colores semánticos, radios), con variante clara y oscura. Es el equivalente a las variables de CSS.
- `core/theme/app_spacing.dart`: escala de espaciados.
- Ningún widget usa colores o tamaños fijos: se leen con `context.colors`, `context.textTheme` y `context.tokens` (`core/extensions/build_context_x.dart`).

#### Manejo de errores

- `core/error/failure.dart`: errores esperados (`DatabaseFailure`, `ValidationFailure`, `UnexpectedFailure`) como `sealed class`.
- `core/error/result.dart`: `Result<T>` con `Ok` y `Err`. Los repositorios y casos de uso devuelven `Result` en lugar de lanzar excepciones, y se maneja con *pattern matching*:

```dart
switch (await addTask(title)) {
  case Ok(:final value): ...
  case Err(:final failure): ...
}
```

- Los errores no controlados se registran en `bootstrap.dart` (`FlutterError.onError` y `PlatformDispatcher.onError`); ahí se conecta Crashlytics o Sentry si el proyecto lo necesita.

#### Accesibilidad

- Todo `IconButton` lleva `tooltip`, que también funciona como etiqueta para lectores de pantalla.
- Los textos vienen del tema, así que respetan el tamaño de fuente del sistema.
- Se recomienda revisar cada pantalla con TalkBack y con el escalado de texto al máximo.

#### Testing

- Pruebas unitarias y de widgets con `flutter_test`, Cubits con `bloc_test` y dobles con `mocktail`.
- La base de datos se prueba en memoria (`NativeDatabase.memory()`), sin simular drift.
- `test/helpers/` contiene `pumpApp` (envuelve un widget con tema y traducciones) y `fakes.dart` (constructores de datos de prueba).
- Cobertura mínima: 80% de las líneas escritas a mano (`tool/check_coverage.dart` ignora el código generado).

```sh
make test
make coverage-check
```

#### Ambientes

Equivalente a los archivos `.env`: cada ambiente es un JSON en `env/` que se inyecta en compilación con `--dart-define-from-file` y se lee en `core/config/env.dart` con `String.fromEnvironment`.

- `make run ENV=prod` o los *launch configs* de VS Code eligen el archivo.
- Los archivos `env/*.local.json` se ignoran en git, para overrides locales.
- **No guarde secretos ahí:** todo lo que se compila en la app se puede extraer del binario. Los secretos van en un backend.

#### Git hooks y CI

Los hooks viven en `.githooks/` y se activan con `make setup` (`git config core.hooksPath .githooks`). Son scripts de shell versionados con el repo, sin dependencias externas.

| Hook | Qué valida |
|---|---|
| `pre-commit` | Formato de los archivos `.dart` en *staging* y análisis estático |
| `commit-msg` | [Conventional Commits](https://www.conventionalcommits.org): `feat(scope): descripción` |
| `pre-push` | `make check` completo |

La CI (`.github/workflows/ci.yml`) corre `make check` en cada push a `main` y en cada pull request, en una máquina limpia. Atrapa lo que se salta con `--no-verify` y permite proteger `main` exigiendo que pase. Dependabot propone actualizaciones semanales de dependencias y mensuales de las acciones de GitHub.

### Guías adicionales

#### Crear un proyecto a partir del arquetipo

1. Clonar el arquetipo en la carpeta del nuevo proyecto y apuntar `origin` al repo nuevo.
2. Renombrar el paquete, el `applicationId` y el nombre visible:
   ```sh
   dart run tool/rename_app.dart --package my_app --org com.mycompany --name "My App"
   flutter pub get && make gen && make l10n
   ```
3. Actualizar `description` en `pubspec.yaml` y este README.
4. Borrar la feature de ejemplo: `lib/features/tasks/`, `test/features/tasks/`, su registro en `app/di/injector.dart`, su ruta en `app/router/`, su tabla y DAO en `core/database/app_database.dart`, y sus textos `tasks*` en los ARB.
5. `make setup` y `make check`.

#### Crear una feature

1. `domain`: entidad (`freezed`), contrato del repositorio y un caso de uso por acción.
2. `data`: tabla y DAO de drift en `datasources/`, mapper en `models/` y la implementación del repositorio en `repositories/`.
3. Registrar la tabla y el DAO en `core/database/app_database.dart` y correr `make gen`.
4. `presentation`: Cubit con estado `freezed`, `XPage` + `XView` y widgets.
5. Crear `<feature>_injection.dart` y llamarlo desde `app/di/injector.dart`.
6. Agregar la ruta en `app/router/`.
7. Pruebas en `test/features/<feature>/`, con la misma estructura.

#### Base de datos y migraciones

- Cada cambio de esquema sube `schemaVersion` en `AppDatabase` y agrega un paso en `migration.onUpgrade`.
- drift puede exportar el esquema de cada versión y generar pruebas de migración: ver [la documentación de migraciones de drift](https://drift.simonbinder.eu/migrations/).
- Las llaves foráneas se activan al abrir la base (`PRAGMA foreign_keys = ON`).

#### Navegación

Rutas con `go_router` en `app/router/app_router.dart`. Los paths viven como constantes en `AppRoutes`, para no repetir textos. Se navega con `context.go(AppRoutes.x)` o `context.push(...)`.

#### Internacionalización

- Los textos viven en `lib/l10n/arb/app_<locale>.arb` (incluye `en` y `es`); `app_en.arb` es la plantilla.
- `make l10n` regenera `lib/l10n/gen/`; en código se usa `context.l10n.miTexto`.
- Para un idioma nuevo basta con agregar su ARB: se registra solo.

#### Íconos y assets

- Íconos: `Icons` de Material. Si un ícono se elige en tiempo de ejecución (por ejemplo, guardado en la base), use un catálogo de constantes `IconData`: un `IconData` no constante rompe el *tree-shaking* de íconos del build de release.
- Imágenes y fuentes: cree `assets/images/` o `assets/fonts/` y declárelas en `pubspec.yaml` bajo `flutter: assets:` o `fonts:`. Empaquete las fuentes como asset para que funcionen offline.

#### Firma de release

La firma se lee de `android/key.properties`, que nunca se sube al repo:

```properties
storeFile=/ruta/absoluta/upload-keystore.jks
storePassword=...
keyAlias=upload
keyPassword=...
```

Sin ese archivo, el build de release usa la llave de debug. Guarde el keystore fuera del repo y con respaldo: si se pierde, no se pueden publicar actualizaciones con la misma firma.

#### Notas de Flutter 3.50 y Dart 3.14

- **Material es un paquete aparte.** En Flutter 3.50, Material y Cupertino ya no vienen dentro del SDK: son los paquetes oficiales `material_ui` y `cupertino_ui`. Se importa `package:material_ui/material_ui.dart`, y las traducciones de Material vienen de `GlobalMaterialLocalizations.delegates` de ese paquete.
- **Paquetes que aún usan `package:flutter/material.dart`** pueden necesitar `MaterialUiCompatibilityBridge` en `MaterialApp.builder` para heredar el tema. Es una utilidad temporal, ya marcada como obsoleta.
- **Constructores sin el nombre de la clase:** `very_good_analysis` exige la sintaxis nueva, `const new({super.key})` y `const factory({...})`, que `freezed` soporta. `make fix` la aplica.
- **Android:** algunos plugins piden un `compileSdk` mayor que el de Flutter por defecto. Se ajusta en `android/app/build.gradle.kts` con `compileSdk = maxOf(flutter.compileSdkVersion, N)`.

#### Mantenimiento

Mantenga este README actualizado para que siga siendo útil. Al actualizar Flutter, cambie la versión en `.fvmrc`, en `pubspec.yaml` (`environment.flutter`) y en `.github/workflows/ci.yml`.

<!-- MARKDOWN LINKS & IMAGES -->

[Flutter]: https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white
[flutter-url]: https://flutter.dev/
[Dart]: https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white
[dart-url]: https://dart.dev/
[Bloc]: https://img.shields.io/badge/Bloc-1E88E5?style=for-the-badge&logoColor=white
[bloc-url]: https://bloclibrary.dev/
[Drift]: https://img.shields.io/badge/Drift_(SQLite)-003B57?style=for-the-badge&logo=sqlite&logoColor=white
[drift-url]: https://drift.simonbinder.eu/
[GoRouter]: https://img.shields.io/badge/go__router-0175C2?style=for-the-badge&logoColor=white
[gorouter-url]: https://pub.dev/packages/go_router
[GitHubActions]: https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white
[githubactions-url]: https://docs.github.com/actions
