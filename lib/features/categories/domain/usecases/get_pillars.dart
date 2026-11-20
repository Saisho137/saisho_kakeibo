import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

class GetPillars implements UseCase<Future<Result<List<Pillar>>>, NoParams> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<List<Pillar>>> call(NoParams params) =>
      _repository.getPillars();
}
