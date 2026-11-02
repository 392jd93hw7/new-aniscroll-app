import 'package:dio/dio.dart';

class KitsuApi {
  KitsuApi({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://kitsu.io/api/edge/',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 30),
                headers: const {'Accept': 'application/vnd.api+json'},
              ),
            );

  final Dio _dio;

  Future<Map<String, dynamic>> getAnimeEpisodes({
    required String kitsuAnimeId,
    int pageLimit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'anime/$kitsuAnimeId/episodes',
      queryParameters: {
        'page[limit]': pageLimit,
        'sort': 'number',
      },
    );
    return response.data ?? <String, dynamic>{};
  }
}
