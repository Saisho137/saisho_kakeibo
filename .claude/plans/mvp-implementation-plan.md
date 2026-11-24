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
| 10d–10f | Identidad visual y retroalimentación de uso | RF-01, RF-14, RF-17 |
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
- [x] **Tipografía:** elegir la fuente, empaquetarla como asset y aplicarla en `AppTheme`.
- [x] **Tokens del tema:** colores de ingreso, egreso y transferencia, más lo que pida el diseño (radios, grosores de la dona) en `AppTokens`.

Entregable: utilidades de `core` probadas al 100 % de sus reglas.

## Fase 1 — Monedas y configuración

- [x] Tablas `currencies` y `settings` (fila única tipada: moneda principal, tipo de periodo, día de corte, N días, hora de recordatorios, tema, filtro del Balance, número de respaldos).
- [x] Datos iniciales: COP (0 decimales, `.` miles, `,` decimal) y USD (2 decimales), COP como principal.
- [x] Reglas: decimales inmutables tras crear la moneda; COP y USD no se borran; la moneda principal no se borra. La condición "solo sin cuentas" se conecta en la fase 2 (RF-16).
- [x] `SettingsCubit` global, leído por el tema (`ThemeMode`) y por las demás features.
- [x] Pantalla **Settings** (versión inicial): General, Periods, Currencies (lista, crear con advertencia, editar símbolo y separadores, borrar), Notifications (hora), About. Las secciones Balance y Backup se completan en fases 2 y 11.

## Fase 2 — Cuentas

- [x] Tabla `accounts`: nombre, ícono, color, `type` (`CASH`, `BANK`, `CREDIT_CARD`, `INVESTMENT`, `POCKET`), moneda, saldo de apertura con fecha, `includeInBalance`, `isMain`, `parentAccountId`, cupo, día de pago, orden, archivada.
- [x] Reglas: tipo inmutable; moneda inmutable si hay movimientos; bolsillo hereda moneda e inclusión del padre; una sola cuenta principal; borrar solo sin movimientos; archivar (RF-15).
- [x] Datos iniciales: cuenta `Cash` y una cuenta `BANK` principal, ambas en el Balance.
- [x] Cálculo de saldo en el repositorio: apertura + movimientos (la tabla de movimientos llega en la fase 4; aquí se deja el contrato y la consulta preparada).
- [x] Pantalla **Accounts**: grupos por tipo, orden arrastrando, bolsillos con línea "Free", barra de cupo de TC, archivadas ocultas, selector de moneda, Total balance y Balance.
- [x] Formulario de cuenta con campos según el tipo.
- [x] Settings → Balance: interruptores "Include in Balance".
- [x] Regla de monedas: una moneda personalizada solo se borra si ninguna cuenta la usa (RF-16, pendiente de la fase 1).

## Fase 3 — Pilares y categorías

- [x] Tabla `pillars` (nombre, color, orden) con los 4 pilares iniciales: Survival, Leisure, Culture, Extras. Renombrar y recolorear (RF-02).
- [x] Tabla `categories`: tipo (`INCOME`, `EXPENSE`, `TRANSFER`), `role`, nombre, ícono, color, pilar (solo egresos personalizados), nombre e ícono originales para *Reset to default*, orden, archivada (RT-12).
- [x] Datos iniciales: categorías core de ingreso, egreso y transferencia, y las personalizadas por defecto (nombres de la tabla "Nombres en la app").
- [x] Reglas: core no se borra, no se archiva ni cambia de pilar; borrar una personalizada reasigna sus movimientos a la categoría elegida; color sugerido con variante libre.
- [x] Pantalla **Categories**: pestañas Expense, Income y Transfer; orden arrastrando; archivadas; edición de pilares; formulario con selector de íconos del catálogo.

## Fase 4 — Movimientos, entidades y registro rápido

El núcleo contable. Es la fase más grande: conviene dividirla en dos o tres PRs (modelo y saldos; formulario y teclado; transferencias).

- [x] Tabla `payees` (entidades) con `display` y `key` únicos (RT-08).
- [x] Tabla `movements`: `type` (`INCOME`, `EXPENSE`, `TRANSFER`, `ADJUSTMENT`), fecha, cuenta origen o destino, monto de salida y de entrada (transferencias entre monedas), categoría, entidad, nota, `debtId`, `recurringTemplateId`, `isPending`, `startsPeriod` (RT-04, RT-05).
- [x] Saldos por cuenta: apertura + ingresos − egresos ± transferencias ± ajustes; el padre suma sus bolsillos; consultas reactivas.
- [x] Conectar a `movements` el contrato de cuentas que dejó la fase 2: `AccountDao.watchBalances` (hoy solo apertura) y `AccountRepository.hasMovements` (hoy siempre `false`), que bloquean cambiar la moneda y borrar.
- [x] Conectar a `movements` el contrato de categorías que dejó la fase 3: `CategoryDao.countMovements` (hoy siempre 0) y la reasignación de movimientos en `CategoryDao.deleteById`.
- [x] Ajuste de saldo: el usuario escribe el saldo real y se guarda la diferencia (RF-15). Conectar *Adjust balance* / *Update value* en el detalle de cuenta.
- [x] Prellenado por categoría: última cuenta y última entidad usadas; cuenta principal si no hay historial.
- [x] Transferencias: categoría prellenada por última usada con el mismo par de cuentas → regla por tipos de cuenta → *Between accounts* (RF-13).
- [x] **Registro rápido**: grilla de categorías en orden manual con búsqueda de categorías y entidades (al elegir entidad, se prellenan categoría, entidad y último monto); formulario con campos según el rol core; teclado propio con operaciones ÷ × − + y tecla condicional `000` / separador decimal (RF-01).
- [x] Editar y borrar movimientos desde el mismo formulario. Las categorías que necesitan deudas (Loan received, Loan repaid, Loan given, Debt payment) quedan fuera de la grilla hasta la fase 8; el check *Starts period* de Salary ya funciona.
- [x] Detalle de cuenta: movimientos agrupados por día (todos; la fase 5 los limita al periodo actual). La acción *Transfer* llega con las transferencias.

## Fase 5 — Periodos

- [x] Servicio de dominio de periodos: dinámico (inicios por Salary con `startsPeriod` y por inicio manual; respaldo en el día de corte), mensual (día de corte) y anual (calendario) (RF-05, RF-14, RT-06). El respaldo aplica solo antes del primer inicio; el último periodo dinámico queda abierto hasta el siguiente inicio.
- [x] Check *Starts period* en Salary: marcado por defecto solo si pasaron N días desde el último inicio (manuales incluidos).
- [x] Acción *Start new period now* en Settings → Periods → Advanced, con confirmación. Los inicios manuales se listan ahí y se pueden deshacer, también con confirmación.
- [x] Totales del periodo por moneda: Income, Expenses y Transfers (ajustes excluidos; ingresos *Pending* fuera hasta confirmar; transferencias internas excluidas) en `PeriodTotals`, más `WatchPeriodMovements`. La fase 6 los muestra.
- [x] Pruebas exhaustivas de bordes: salario el 23 vs. el 29, sin salario, cambio de tipo de periodo, año bisiesto.
- [x] Detalle de cuenta: solo el periodo actual; deslizar a la derecha muestra los anteriores.

## Fase 6 — Home e historial

- [x] **Dona** con `CustomPainter`: anillo de categorías con íconos por fuera; borde de pilar por fuera con su color; grupo gris *No pillar* (Loan given y Uncategorized); pilares sin egresos ocultos; umbral del 3 % sin ícono ni porcentaje; anillo gris vacío. Los pagos de deudas como sección de su pilar pasan a la fase 8.
- [x] **Interacción de la dona**: zona táctil ampliada del borde; tocar pilar invierte la dona con animación; tocar categoría abre el formulario de un egreso de esa categoría (como Monefy; el historial filtrado queda en el panel). Detección por ángulo y radio, con pruebas unitarias de la geometría.
- [x] Centro de la dona: Income (verde), Expenses (rojo) y Transfers (gris); tocarlos abre el historial por categoría de ese tipo.
- [x] Alcance: dona y totales usan todas las cuentas de la moneda activa; el Balance usa la vista principal con el filtro Cash / Bank / Both.
- [x] Encabezado con el periodo actual; cambio de periodo deslizando (`PageView`).
- [x] Balance abajo (código de moneda pequeño) y botones Expense, Transfer e Income.
- [x] **Panel de historial** desde abajo: vista por día y vista por categoría con totales; *Pending* marcado (los ingresos *Pending* atenuados y fuera del saldo). Se abre tocando o arrastrando hacia arriba el Balance; en la vista por categoría, tocar una categoría despliega sus movimientos.
- [x] **Menú rápido** (☰, izquierda): tipo de periodo, moneda, filtro del Balance y tema, con botones segmentados anchos. **Navegación** (⋮, derecha): Accounts, Debts, Entities, Categories, Recurring y Settings. Debts, Entities y Recurring se suman a la navegación en sus fases.
- [x] El total de Transferencias excluye las transferencias dentro de una misma cuenta (cuenta ↔ sus bolsillos, `TransferRules.isInternal`). Hecho en la fase 5, en `PeriodTotals`.

## Fase 7 — Notificaciones y recurrentes

- [x] Infraestructura de notificaciones: `flutter_local_notifications` + `timezone`, permiso de notificaciones de Android 13+, canal propio, hora global configurable (RT-11). Servicio que reprograma todo al cambiar datos o la hora. Alarmas inexactas (sin permiso de alarma exacta) y hora en UTC (sin base de husos horarios); se agendan los próximos dos meses y se reprograman al abrir la app y al cambiar ajustes, plantillas o cuentas. El permiso se pide la primera vez que hay algo que recordar.
- [x] Tabla `recurring_templates`: tipo (egreso, transferencia, ingreso), categoría, cuenta(s), entidad, monto, día opcional, recordatorio, activa. Con frecuencia por plantilla: cada inicio dinámico o cada periodo mensual (día de corte).
- [x] Materialización idempotente al iniciar un periodo: egresos y transferencias con la fecha de inicio; ingresos en su día previsto; monto del último confirmado (RF-06, RT-07). Una vez por periodo y plantilla (tabla `recurring_occurrences`), aunque el *Pending* se cancele; nunca en el periodo en que se creó la plantilla. Se ejecuta al abrir el Home y al cambiar los inicios de periodo.
- [x] *Pending*: egresos y transferencias afectan el saldo; ingresos no hasta confirmar; cancelar = borrar; *Confirm* en el formulario. Confirmar copia el monto a la plantilla.
- [x] Recordatorios del día de pago de cada plantilla (activados por defecto si hay día).
- [x] Pantalla **Recurring** y acción *Make recurring* desde un movimiento.
- [x] Recordatorio del día de pago de las tarjetas de crédito (RF-03).

## Fase 8 — Deudas

- [x] Tabla `debts`: tipo (I owe / Owed to me), nombre (que es también su entidad), ícono, moneda, pendiente inicial, pilar (I owe), cuota, día de pago o fecha límite.
- [x] Pendiente = inicial − pagos que la referencian; *Edit pending* corrige sin mover dinero; negativo en rojo; *Paid off* automático al llegar a 0. La corrección se guarda aparte (`adjustment`); el inicial se sigue mostrando. Una deuda solo se borra sin movimientos.
- [x] Integración con categorías core: Loan received crea deuda por pagar; Loan given crea por cobrar o suma a la existente de esa entidad; Debt payment y Loan repaid exigen elegir la deuda; el pilar de un pago sale de su deuda. La deuda es su propia entidad (su nombre), así que la búsqueda del registro rápido la encuentra y abre su pago; renombrarla mueve sus movimientos y plantillas. El pago toma la entidad de la deuda; borrar el préstamo que creó una deuda sin otros movimientos borra la deuda. Las plantillas recurrentes pueden pagar o cobrar una deuda (no prestar) y dejan de materializarse al saldarla.
- [x] Pantalla **Debts**: pestañas, sección de tarjetas de solo lectura, *Paid off* colapsado; detalle con sus movimientos y *Pay* / *Collect* (con la cuota precargada).
- [x] Recordatorios de deudas: día de pago de las que debo (con la cuota) y fecha límite de las que me deben (con el pendiente), mientras no estén saldadas.
- [x] Mostrar en el registro rápido las categorías de deudas (`CategoryRole.needsDebt`) con sus campos: elegir o crear la deuda.
- [x] En la dona, los pagos de Debt payment como sección dentro del pilar de su deuda, con el nombre de la deuda.

## Fase 9 — Entidades

- [x] Pantalla **Entities**: periodo actual o histórico, orden (más gastado, más usado, A-Z), búsqueda. Total neto (ingresos − egresos), en verde si es positivo; *All time* incluye las entidades sin movimientos.
- [x] Detalle: totales, promedio, último precio y gráfico de evolución del precio con `fl_chart` (no necesita `MaterialUiCompatibilityBridge`).
- [x] *Rename*, *Merge into…* (mueve movimientos y borra la origen) y *Delete* (bloqueado si una deuda la usa). Renombrar o fusionar la entidad de una deuda renombra la deuda.

## Fase 10 — Pulido del MVP

- [x] Revisión de accesibilidad: tooltips, etiquetas semánticas en la dona, escalado de texto, contraste en tema oscuro. (10a: pruebas `meetsGuideline` y de texto al 150/200 %, glifo oscuro sobre colores claros.)
- [x] Rendimiento: consultas agregadas con índices (fecha, cuenta, categoría), pruebas con unos 5.000 movimientos. (10b: índices de entidad, deuda y plantilla; `test/performance/large_data_test.dart` con presupuestos.)
- [x] Estados vacíos y mensajes de error en todas las pantallas. (10a: revisadas; faltaba el detalle de una entidad sin movimientos.)
- [x] Ícono de la app y pantalla de inicio (splash). (10c: ícono provisional en vectores, adaptativo y temático; splash del sistema en Android 12+.)
- [x] Revisión de cobertura por capa y deuda técnica acumulada. (10c: 99,5 %; se quitó código y textos sin uso y comentarios de fases viejas.)

## Fases 10d–10f — Identidad visual y retroalimentación de uso

Fase intermedia larga, antes de OAuth, a partir del uso real en el teléfono y con Monefy como referencia de estética (no de identidad): mismos contrastes, color sólido e iconografía de línea, pero con un **amarillo** propio en lugar de verde. Cada sub-fase es su rama y su PR; la lista crece con cada ronda de retroalimentación.

### 10d — Errores y paleta

- [x] El filtro *Cash / Bank / Both* del menú rápido filtra todo el Home, no solo el Balance: dona, totales del centro e historial (antes el diseño decía "afecta solo al Balance"). Una transferencia cuenta si alguno de sus dos lados pasa el filtro.
- [x] Paleta nueva en `AppTokens` y `ColorScheme`: primario amarillo entre ámbar y mostaza (cálido, que no canse la vista) con tinta oscura encima (el blanco sobre amarillo no pasa WCAG), fondo crema en el tema claro para descansar la vista, ingreso verde y gasto rojo más vivos (tipo Monefy), y un tema oscuro coherente (superficies cálidas y amarillo como acento). Las pruebas de contraste de 10a se mantienen en verde. (Marca `#E5A93B` con tinta `#34260A`, crema `#FFF8EC`; los roles de Material salen de la misma semilla, así que botones de texto y switches usan un ámbar profundo que sí se lee. Ingreso y gasto quedan en `#127033` y `#BF2626`, lo más vivo que pasa 4,5:1 sobre la crema; los aros y puntos de 10e pueden ser más vivos porque son gráficos, 3:1.)
- [x] Barra superior de color sólido amarillo, con el nombre de la app en una fuente manuscrita incluida en la app (sin depender de internet) a la derecha del botón ☰ y, debajo y más pequeño, el filtro del Balance activo (*All accounts*, *Cash*, *Bank*), para que se vea qué filtro se está usando. (Fuente Courgette, OFL, en `assets/fonts/courgette`.)
- [x] Ícono provisional y splash con la nueva paleta.

### 10e — Home

- [x] Totales del centro de la dona con un ancho máximo y **un solo tamaño de letra para los tres**, calculado por el más largo: totales con los mismos dígitos se ven del mismo tamaño. (Los tres en `titleLarge`, escalados juntos dentro de un rectángulo más alto que ancho en el hueco de la dona, que conserva los 48 dp de cada total en un celular de 411 dp.)
- [x] Botones de acción más grandes y sin texto, de aro (tipo Monefy): tres en lugar de dos, **−** gasto (rojo), **⇄** transferencia (más pequeño, en el medio) y **+** ingreso (verde). Con tooltips y etiquetas semánticas, porque pierden el texto. (Aros de 96 y 56 dp con `incomeAccent` y `expenseAccent`, colores más vivos que pasan 3:1 como gráficos; respetan la barra de gestos.)
- [x] Barra del Balance como separador visual: píldora de color sólido (amarillo) con el texto en tinta de contraste, y las líneas de agarre a los lados que indican que sube el historial.
- [x] Íconos de línea, del color de la categoría y sin círculo de relleno (estilo minimalista de Monefy), en la dona, la cuadrícula de categorías y las listas, con los íconos que ya tenemos (Material *outlined*). (Un color claro se oscurece lo justo para 3:1 sobre la crema, `AppTokens.readable`; los íconos de la dona crecieron y su porcentaje va en el color de la categoría.) Si no alcanza la identidad buscada, más adelante se evalúa una colección de íconos externa.
- [x] Panel de ajustes de la derecha (`NavigationMenu`) con el ancho de sus opciones, no el ancho fijo del `Drawer`.

### 10f — Historial

- [ ] Rediseño del panel del historial con la paleta y el estilo del Home, aprovechando mejor el espacio (filas más compactas, sin tarjetas).
- [ ] Separador de día con la fecha completa (*23 November*), un contador de movimientos en una insignia y el balance del día a la derecha (verde si es positivo, rojo si es negativo). Los días se pueden plegar.
- [ ] Filas: punto de color del tipo (verde ingreso, rojo gasto, neutro transferencia), categoría arriba y entidad o nota debajo, y el monto a la derecha.
- [ ] El selector *By day / By category* pasa a ser un ícono a la derecha de la barra del Balance, visible solo con el historial abierto.

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
- [ ] Reemplazar el ícono provisional por uno diseñado (y su PNG de 512 × 512 si se publica).
- [ ] Congelar `schemaVersion = 1`, exportar el esquema y activar las pruebas de migración.
- [ ] `make build-release` (APK firmado) e instalación en el teléfono.
- [ ] Prueba de punta a punta con datos reales del primer mes, incluido un respaldo y una restauración.
- [ ] Versión `1.0.0+1`, tag `v1.0.0` y notas de la versión.

---

## Pendientes técnicos transversales

Seguimiento detallado en la nota *Stack técnico* del vault, sección "Pendientes y revisiones técnicas".

- [x] Proteger `main` en GitHub exigiendo la CI.
- [ ] Revisar `workmanager` (fase 11).
- [x] Validar `fl_chart` con `material_ui` (fase 9).
- [ ] Sincronizar mejoras útiles con el arquetipo (remoto `archetype`).

## Fuera del MVP (no planificado aquí)

FA-01 extractos de Bancolombia · FA-02 sincronizar con Google Sheets · FA-03 importar CSV de Monefy · FA-04 bloqueo con biometría · FA-05 internacionalización · FA-06 comprobantes adjuntos · FA-07 agregar o quitar pilares.
