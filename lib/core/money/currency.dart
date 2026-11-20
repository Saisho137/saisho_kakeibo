import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';

part 'currency.freezed.dart';

/// A currency the user works with (RF-16). Its [code] identifies it and
/// never changes; [format] decimals are fixed at creation.
@freezed
abstract class Currency with _$Currency {
  const factory({
    /// ISO-like code of three letters, such as `COP`.
    required String code,
    required String symbol,
    required CurrencyFormat format,

    /// COP and USD come with the app and cannot be deleted.
    @Default(false) bool isBuiltIn,
  }) = _Currency;
}
