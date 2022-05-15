
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/model/result.dart';
import 'package:best_beer_ranking/data/local/category_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepositoryImpl(ref.read));

abstract class CategoryRepository {
  Future<Category> postCategory(String title);
  Future<Category> updateCategory({required int id, String? title, bool? isShowThumbnail, bool? isShowPoint});
  Future<void> deleteCategory(int id);
  Future<List<Category>> getCategories();
}

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._reader);

  final Reader _reader;

  late final CategoryDatabase _categoryDatabase = _reader(categoryDatabaseProvider);

  @override
  Future<Category> postCategory(String title) async {
    final category = await _categoryDatabase.insert(title, false, false);
    return category;
  }

  @override
  Future<Category> updateCategory({required int id, String? title, String? hexColor, bool? isShowThumbnail, bool? isShowPoint}) async {
    final category = await _categoryDatabase.update(id, title, hexColor, isShowThumbnail, isShowPoint);
    return category;
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _categoryDatabase.delete(id);
  }

  @override
  Future<List<Category>> getCategories() async {
    final categories = await _categoryDatabase.getCategories();
    return categories;
  }
}
