import 'package:rick_and_morty/domain/repository/app_repository.dart';

class GetFavoriteStatus {
  final AppRepository repository;

  GetFavoriteStatus({required this.repository});

  Future<bool> execute(int id) => repository.isAddedToFavorite(id);
}
