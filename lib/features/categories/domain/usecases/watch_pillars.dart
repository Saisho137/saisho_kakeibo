import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

class WatchPillars implements UseCase<Stream<List<Pillar>>, NoParams> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Stream<List<Pillar>> call(NoParams params) => _repository.watchPillars();
}
