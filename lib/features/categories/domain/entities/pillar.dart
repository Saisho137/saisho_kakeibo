import 'package:freezed_annotation/freezed_annotation.dart';

part 'pillar.freezed.dart';

/// A Kakeibo pillar: Survival, Leisure, Culture or Extras (RF-02). It
/// classifies expenses only. In the MVP pillars are renamed and recolored,
/// never added or removed (FA-07).
@freezed
abstract class Pillar with _$Pillar {
  const factory({
    required int id,
    required String name,

    /// ARGB color of the pillar's border in the donut. Unique per pillar.
    required int color,
    @Default(0) int sortOrder,
  }) = _Pillar;
}
