import 'package:dio/dio.dart';

class ApiRepository {
  final Dio dio;
  ApiRepository(this.dio);

  Future<List> get(String url) async {
    try {
      final response = await dio.get(url);
      return response.data as List;
    } catch (e) {
      return [];
    }
  }
}
