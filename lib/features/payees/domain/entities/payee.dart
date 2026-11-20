import 'package:freezed_annotation/freezed_annotation.dart';

part 'payee.freezed.dart';

/// Who is paid, or who pays: an entity in the app, such as Peaje Palmas or
/// Pragma (RF-08). Named `Payee` because "entity" already names domain
/// objects.
@freezed
abstract class Payee with _$Payee {
  const factory({
    required int id,

    /// Display text: trimmed, inner spaces collapsed, first letter upper.
    required String name,

    /// Comparison key: no spaces, lowercase, no accents. Unique (RT-08).
    required String key,
  }) = _Payee;
}
