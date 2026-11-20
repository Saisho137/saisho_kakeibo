# Plan de implementación del MVP — Saisho Kakeibo

> Fuente de verdad funcional: notas del vault de Obsidian (*Visión y alcance*, *Requerimientos*, *Movimientos y categorías*, *Pantallas*, *Stack técnico*). Los identificadores RF/RT/FA se refieren a *Requerimientos*.
> Estado: aprobado para iniciar. Actualizar los checkboxes al cerrar cada tarea.

## Reglas de trabajo

- **Una fase = una rama y un PR** (`feat/<fase>`), con la CI en verde antes del merge. Commits en Conventional Commits (el hook `commit-msg` lo valida).
- **Definición de terminado de cada fase:**
  - `make check` en verde (formato, lint, pruebas con cobertura ≥ 80 %, build).
  - Pruebas por capa: casos de uso y reglas de dominio (unitarias), repositorios con drift en memoria, Cubits con `bloc_test`, vistas con widget tests y Cubit simulado.
  - Textos en `app_en.arb`, sin strings fijos en la UI.
  - Colores y medidas desde el tema (`context.colors`, `context.tokens`, `AppSpacing`).
  - Si una decisión cambia, se actualiza la nota correspondiente del vault.
- **Esquema de base de datos:** se mantiene en `schemaVersion = 1` y se puede rehacer libremente **hasta la primera instalación con datos reales** (fase 12). Desde ahí, cada cambio de esquema exige migración y prueba de migración.
- **Orden:** cada fase depende solo de las anteriores. Google Sign-In y el respaldo en Drive van al final (RF-12).

## Mapa de fases

| # | Fase | Requerimientos |
|---|---|---|
| 0 | Fundaciones técnicas | RT-02, RT-03, RT-08, RT-13, RF-07, RF-17 (tema) |
| 1 | Monedas y configuración | RF-16, RF-17 |
| 2 | Cuentas | RF-03, RF-04, RF-15 |
| 3 | Pilares y categorías | RF-02, RF-13, RT-12 |
| 4 | Movimientos, entidades y registro rápido | RF-01, RF-04, RF-07, RF-08 (búsqueda), RT-04, RT-05 |
| 5 | Periodos | RF-05, RF-14, RT-06 |
| 6 | Home e historial | RF-01, RF-02, RF-14, RF-17 |
| 7 | Notificaciones y recurrentes | RF-06, RT-07, RT-11 |
| 8 | Deudas | RF-09 |
| 9 | Entidades | RF-08 |
| 10 | Pulido del MVP | RF-17, accesibilidad, rendimiento |
| 11 | Google Sign-In y respaldo en Drive | RF-12, RT-09 |
| 12 | Release 1.0.0 | RT-01 |

---

## Fase 0 — Fundaciones técnicas

Objetivo: piezas transversales, sin pantallas de negocio.

- [x] **Decisión de fechas en drift:** `build.yaml` con `store_date_time_values_as_text: true` (texto ISO-8601, legible en respaldos y sin ambigüedad de zona horaria). Tipo `LocalDate` propio (año, mes, día) para las fechas de movimientos y periodos, que no tienen hora.
- [x] **Exportar esquemas de drift** (`make db-schema`) y andamiaje de pruebas de migración, aunque hoy solo exista la versión 1.
- [x] **`Money`** en `core/money/`: monto entero en la unidad mínima + código de moneda; suma y resta solo entre la misma moneda (error si se mezclan); nunca `double` (RT-03).
- [x] **`MoneyFormatter`**: separador de miles, separador decimal y número de decimales por moneda (RF-16). Pruebas: `4.250.000` (COP) y `1.250,50` (USD).
- [x] **Normalización de texto** en `core/text/`: `display` (trim, espacios colapsados, capitalización consistente) y `key` (minúsculas, sin tildes) (RF-07, RT-08).
- [x] **Catálogo de íconos** en `core/icons/`: `Map<String, IconData>` constante, agrupado por tema, con color sugerido por ícono (RT-13). Algoritmo de "variante cercana libre" cuando el color ya está en uso (RF-13).
- [ ] **Tipografía:** elegir la fuente, empaquetarla como asset y aplicarla en `AppTheme`.
- [ ] **Tokens del tema:** colores de ingreso, egreso y transferencia, más lo que pida el diseño (radios, grosores de la dona) en `AppTokens`.

Entregable: utilidades de `core` probadas al 100 % de sus reglas.

## Fase 1 — Monedas y configuración

- [ ] Tablas `currencies` y `settings` (fila única tipada: moneda principal, tipo de periodo, día de corte, N días, hora de recordatorios, tema, filtro del Balance, número de respaldos).
- [ ] Datos iniciales: COP (0 decimales, `.` miles, `,` decimal) y USD (2 decimales), COP como principal.
- [ ] Reglas: decimales inmutables tras crear la moneda; COP y USD no se borran; una moneda personalizada solo se borra sin cuentas (RF-16).
- [ ] `SettingsCubit` global, leído por el tema (`ThemeMode`) y por las demás features.
- [ ] Pantalla **Settings** (versión inicial): General, Periods, Currencies (lista, crear con advertencia, editar símbolo y separadores, borrar), Notifications (hora), About. Las secciones Balance y Backup se completan en fases 2 y 11.

## Fase 2 — Cuentas

- [ ] Tabla `accounts`: nombre, ícono, color, `type` (`CASH`, `BANK`, `CREDIT_CARD`, `INVESTMENT`, `POCKET`), moneda, saldo de apertura con fecha, `includeInBalance`, `isMain`, `parentAccountId`, cupo, día de pago, orden, archivada.
- [ ] Reglas: tipo inmutable; moneda inmutable si hay movimientos; bolsillo hereda moneda e inclusión del padre; una sola cuenta principal; borrar solo sin movimientos; archivar (RF-15).
- [ ] Datos iniciales: cuenta `Cash` y una cuenta `BANK` principal, ambas en el Balance.
- [ ] Cálculo de saldo en el repositorio: apertura + movimientos (la tabla de movimientos llega en la fase 4; aquí se deja el contrato y la consulta preparada).
- [ ] Pantalla **Accounts**: grupos por tipo, orden arrastrando, bolsillos con línea "Free", barra de cupo de TC, archivadas ocultas, selector de moneda, Total balance y Balance.
- [ ] Formulario de cuenta con campos según el tipo.
- [ ] Settings → Balance: interruptores "Include in Balance".

## Fase 3 — Pilares y categorías

- [ ] Tabla `pillars` (nombre, color, orden) con los 4 pilares iniciales: Survival, Leisure, Culture, Extras. Renombrar y recolorear (RF-02).
- [ ] Tabla `categories`: tipo (`INCOME`, `EXPENSE`, `TRANSFER`), `role`, nombre, ícono, color, pilar (solo egresos personalizados), nombre e ícono originales para *Reset to default*, orden, archivada (RT-12).
- [ ] Datos iniciales: categorías core de ingreso, egreso y transferencia, y las personalizadas por defecto (nombres de la tabla "Nombres en la app").
- [ ] Reglas: core no se borra, no se archiva ni cambia de pilar; borrar una personalizada reasigna sus movimientos a la categoría elegida; color sugerido con variante libre.
- [ ] Pantalla **Categories**: pestañas Expense, Income y Transfer; orden arrastrando; archivadas; edición de pilares; formulario con selector de íconos del catálogo.

## Fase 4 — Movimientos, entidades y registro rápido

El núcleo contable. Es la fase más grande: conviene dividirla en dos o tres PRs (modelo y saldos; formulario y teclado; transferencias).

- [ ] Tabla `payees` (entidades) con `display` y `key` únicos (RT-08).
- [ ] Tabla `movements`: `type` (`INCOME`, `EXPENSE`, `TRANSFER`, `ADJUSTMENT`), fecha, cuenta origen o destino, monto de salida y de entrada (transferencias entre monedas), categoría, entidad, nota, `debtId`, `recurringTemplateId`, `isPending`, `startsPeriod` (RT-04, RT-05).
- [ ] Saldos por cuenta: apertura + ingresos − egresos ± transferencias ± ajustes; el padre suma sus bolsillos; consultas reactivas.
- [ ] Ajuste de saldo: el usuario escribe el saldo real y se guarda la diferencia (RF-15). Conectar *Adjust balance* / *Update value* en el detalle de cuenta.
- [ ] Prellenado por categoría: última cuenta y última entidad usadas; cuenta principal si no hay historial.
- [ ] Transferencias: categoría prellenada por última usada con el mismo par de cuentas → regla por tipos de cuenta → *Between accounts* (RF-13).
- [ ] **Registro rápido**: grilla de categorías en orden manual con búsqueda de categorías y entidades (al elegir entidad, se prellenan categoría, entidad y último monto); formulario con campos según el rol core; teclado propio con operaciones ÷ × − + y tecla condicional `000` / separador decimal (RF-01).
- [ ] Editar y borrar movimientos desde el mismo formulario.
- [ ] Detalle de cuenta: movimientos agrupados por día.

## Fase 5 — Periodos

- [ ] Servicio de dominio de periodos: dinámico (inicios por Salary con `startsPeriod` y por inicio manual; respaldo en el día de corte), mensual (día de corte) y anual (calendario) (RF-05, RF-14, RT-06).
- [ ] Check *Starts period* en Salary: marcado por defecto solo si pasaron N días desde el último inicio.
- [ ] Acción *Start new period now* en Settings → Periods → Advanced, con confirmación.
- [ ] Totales del periodo por moneda: Income, Expenses y Transfers (ajustes excluidos).
- [ ] Pruebas exhaustivas de bordes: salario el 23 vs. el 29, sin salario, cambio de tipo de periodo, año bisiesto.

## Fase 6 — Home e historial

- [ ] **Dona** con `CustomPainter`: anillo de categorías con íconos por fuera; borde de pilar por fuera con su color; grupo gris *No pillar* (Loan given y Uncategorized); pilares sin egresos ocultos; umbral del 3 % sin ícono ni porcentaje; anillo gris vacío; pagos de deudas como sección con el nombre de la deuda dentro de su pilar.
- [ ] **Interacción de la dona**: zona táctil ampliada del borde; tocar pilar invierte la dona con animación; tocar categoría abre el historial filtrado. Detección por ángulo y radio, con pruebas unitarias de la geometría.
- [ ] Centro de la dona: Income (verde), Expenses (rojo) y Transfers (gris); tocarlos abre el historial por categoría de ese tipo.
- [ ] Alcance: dona y totales usan todas las cuentas de la moneda activa; el Balance usa la vista principal con el filtro Cash / Bank / Both.
- [ ] Encabezado con el periodo actual; cambio de periodo deslizando (`PageView`).
- [ ] Balance abajo (código de moneda pequeño) y botones Expense, Transfer e Income.
- [ ] **Panel de historial** desde abajo: vista por día y vista por categoría con totales; *Pending* marcado (los ingresos *Pending* atenuados y fuera del saldo).
- [ ] **Menú rápido** (☰, izquierda): tipo de periodo, moneda, filtro del Balance y tema, con botones segmentados anchos. **Navegación** (⋮, derecha): Accounts, Debts, Entities, Categories, Recurring y Settings.

## Fase 7 — Notificaciones y recurrentes

- [ ] Infraestructura de notificaciones: `flutter_local_notifications` + `timezone`, permiso de notificaciones de Android 13+, canal propio, hora global configurable (RT-11). Servicio que reprograma todo al cambiar datos o la hora.
- [ ] Tabla `recurring_templates`: tipo (egreso, transferencia, ingreso), categoría, cuenta(s), entidad, monto, día opcional, recordatorio, activa.
- [ ] Materialización idempotente al iniciar un periodo: egresos y transferencias con la fecha de inicio; ingresos en su día previsto; monto del último confirmado (RF-06, RT-07).
- [ ] *Pending*: egresos y transferencias afectan el saldo; ingresos no hasta confirmar; cancelar = borrar; *Confirm* en el formulario.
- [ ] Recordatorios del día de pago de cada plantilla (activados por defecto si hay día).
- [ ] Pantalla **Recurring** y acción *Make recurring* desde un movimiento.
- [ ] Recordatorio del día de pago de las tarjetas de crédito (RF-03).

## Fase 8 — Deudas

- [ ] Tabla `debts`: tipo (I owe / Owed to me), nombre, ícono, entidad, moneda, pendiente inicial, pilar (I owe), cuota, día de pago o fecha límite.
- [ ] Pendiente = inicial − pagos que la referencian; *Edit pending* corrige sin mover dinero; negativo en rojo; *Paid off* automático al llegar a 0.
- [ ] Integración con categorías core: Loan received crea deuda por pagar; Loan given crea por cobrar o suma a la existente de esa entidad; Debt payment y Loan repaid exigen elegir la deuda; el pilar de un pago sale de su deuda.
- [ ] Pantalla **Debts**: pestañas, sección de tarjetas de solo lectura, *Paid off* colapsado; detalle con pagos y *Pay*.
- [ ] Recordatorios de deudas.

## Fase 9 — Entidades

- [ ] Pantalla **Entities**: periodo actual o histórico, orden (más gastado, más usado, A-Z), búsqueda.
- [ ] Detalle: totales, promedio, último precio y gráfico de evolución del precio con `fl_chart` (validar si necesita `MaterialUiCompatibilityBridge`).
- [ ] *Rename*, *Merge into…* (mueve movimientos y borra la origen) y *Delete* (bloqueado si una deuda la usa).

## Fase 10 — Pulido del MVP

- [ ] Revisión de accesibilidad: tooltips, etiquetas semánticas en la dona, escalado de texto, contraste en tema oscuro.
- [ ] Rendimiento: consultas agregadas con índices (fecha, cuenta, categoría), pruebas con unos 5.000 movimientos.
- [ ] Estados vacíos y mensajes de error en todas las pantallas.
- [ ] Ícono de la app y pantalla de inicio (splash).
- [ ] Revisión de cobertura por capa y deuda técnica acumulada.

## Fase 11 — Google Sign-In y respaldo en Drive

Lo último del MVP (RF-12, RT-09).

- [ ] Prerrequisitos fuera del código: keystore de release (fuera del repo, con respaldo), SHA-1 de debug y release, proyecto en Google Cloud con la Drive API, pantalla de consentimiento en modo *Testing*, clientes OAuth de Android.
- [ ] Inicio de sesión con `google_sign_in` 7 (autenticación y autorización separadas) y alcance `drive.appdata`.
- [ ] Respaldo: snapshot con `VACUUM INTO`, zip con `archive`, subida a la carpeta `appdata`, retención de los últimos N (3 por defecto).
- [ ] Respaldo automático una vez al día si hubo cambios, al pasar a segundo plano (`AppLifecycleListener`). **Decidir aquí** si se usa `workmanager` como red de seguridad o se descarta por el aviso de Kotlin Gradle Plugin.
- [ ] Restauración: listar respaldos, descargar, reemplazar la base y migrar si es vieja; reprogramar notificaciones.
- [ ] Settings → Backup: cuenta, último respaldo, *Keep last N*, *Backup now*, *Restore*.

## Fase 12 — Release 1.0.0

- [ ] Firma de release con `android/key.properties`.
- [ ] Congelar `schemaVersion = 1`, exportar el esquema y activar las pruebas de migración.
- [ ] `make build-release` (APK firmado) e instalación en el teléfono.
- [ ] Prueba de punta a punta con datos reales del primer mes, incluido un respaldo y una restauración.
- [ ] Versión `1.0.0+1`, tag `v1.0.0` y notas de la versión.

---

## Pendientes técnicos transversales

Seguimiento detallado en la nota *Stack técnico* del vault, sección "Pendientes y revisiones técnicas".

- [ ] Proteger `main` en GitHub exigiendo la CI.
- [ ] Revisar `workmanager` (fase 11).
- [ ] Validar `fl_chart` con `material_ui` (fase 9).
- [ ] Sincronizar mejoras útiles con el arquetipo (remoto `archetype`).

## Fuera del MVP (no planificado aquí)

FA-01 extractos de Bancolombia · FA-02 sincronizar con Google Sheets · FA-03 importar CSV de Monefy · FA-04 bloqueo con biometría · FA-05 internacionalización · FA-06 comprobantes adjuntos · FA-07 agregar o quitar pilares.
