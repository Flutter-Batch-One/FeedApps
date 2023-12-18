import 'package:dio/dio.dart';
// import 'package:mini_project_one/repositories/cache_repository.dart';

class ApiRepository {
  final Dio dio;
  // final CacheRepository cacheRepository;
  ApiRepository(
    this.dio,
    // this.cacheRepository,
  );

  Future<List> get(String url, String collection) async {
    try {
      final response = await dio.get(url);
      final result = response.data as List;
      // cacheRepository.save(
      //     collection, result.map((e) => e as Map<String, dynamic>).toList());
      return result;
    } catch (e) {
      // return cacheRepository.get(collection);
      return [];
    }
  }
}
