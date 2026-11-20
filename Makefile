# Developer workflow. Run `make help` to list targets.
ENV ?= dev
MIN_COVERAGE ?= 80

.DEFAULT_GOAL := help
.PHONY: help setup get gen gen-watch l10n run format format-check lint fix test coverage coverage-check build build-release check clean

help: ## List available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: get ## First-time setup: dependencies and git hooks
	git config core.hooksPath .githooks
	@echo "Git hooks enabled from .githooks/"

get: ## Install dependencies
	flutter pub get

gen: ## Run code generation (drift, freezed)
	dart run build_runner build --delete-conflicting-outputs

gen-watch: ## Run code generation in watch mode
	dart run build_runner watch --delete-conflicting-outputs

l10n: ## Generate localizations from ARB files
	flutter gen-l10n

run: ## Run the app (ENV=dev|prod)
	flutter run --dart-define-from-file=env/$(ENV).json

format: ## Format all Dart code
	dart format lib test tool

format-check: ## Fail if any Dart file is not formatted
	dart format --output=none --set-exit-if-changed lib test tool

lint: ## Static analysis (fails on infos too)
	flutter analyze --fatal-infos

fix: ## Apply automated lint fixes
	dart fix --apply

test: ## Run unit and widget tests
	flutter test

coverage: ## Run tests with coverage (coverage/lcov.info)
	flutter test --coverage

coverage-check: coverage ## Fail if line coverage < MIN_COVERAGE (default 80)
	dart run tool/check_coverage.dart $(MIN_COVERAGE)

build: ## Build a debug APK (ENV=dev|prod)
	flutter build apk --debug --dart-define-from-file=env/$(ENV).json

build-release: ## Build a release App Bundle (ENV=prod by default)
	flutter build appbundle --release --dart-define-from-file=env/$(or $(filter-out dev,$(ENV)),prod).json

check: format-check lint coverage-check build ## Full quality gate (pre-push and CI)

clean: ## Remove build artifacts
	flutter clean
