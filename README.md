# Saisho Kakeibo

[![CI](https://github.com/Saisho137/saisho_kakeibo/actions/workflows/ci.yml/badge.svg)](https://github.com/Saisho137/saisho_kakeibo/actions/workflows/ci.yml)

Personal finance app built with Flutter: an improved take on Monefy's fast expense tracking, with expenses classified into the four Kakeibo pillars (Survival, Leisure, Culture, Extras). Offline-first and Android-first.

## Highlights

- Record an expense in under five seconds: category first, then amount.
- Transfers as a first-class movement type, so paying a credit card or saving into a pocket never inflates income or expenses.
- Accounts of every kind: cash, bank, credit cards (with limit and payment day), investments and pockets.
- Payday-to-payday periods and recurring movements created automatically.
- Debts (owed and receivable), entities with price history, and automatic Google Drive backup.

## Tech stack

Bootstrapped from [Archetype_Flutter](https://github.com/Saisho137/Archetype_Flutter): Flutter 3.50 · `material_ui` · Clean Architecture · `flutter_bloc` + `freezed` · `get_it` · `go_router` · `drift` · `very_good_analysis`.

App-specific packages:

| Concern | Package |
|---|---|
| Charts | Custom `CustomPainter` donut + `fl_chart` |
| Reminders | `flutter_local_notifications` + `timezone` |
| Backup | `google_sign_in`, `googleapis` (Drive `appdata`), `archive`, `workmanager` |

## Getting started

Requirements: Flutter 3.50 (see `.fvmrc`), Android SDK with API 37 and Java 17+.

```sh
make setup   # dependencies + git hooks
make run     # run on a device or emulator
make check   # format, lint, tests with coverage and build (same as CI)
```

`make help` lists every command. Architecture, conventions and guides are documented in the [archetype README](https://github.com/Saisho137/Archetype_Flutter#readme).
