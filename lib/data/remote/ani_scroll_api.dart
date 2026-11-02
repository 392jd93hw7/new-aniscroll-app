import 'package:dio/dio.dart';

class AniScrollApi {
  AniScrollApi({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.aniscroll.in/api/',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 30),
                headers: const {'Accept': 'application/json'},
              ),
            );

  final Dio _dio;

  Future<Map<String, dynamic>> getWatchData({
    required int anilistId,
    required int episode,
    required String type,
    String source = 'anikoto',
  }) async {
    if (type != 'sub' && type != 'dub') {
      throw ArgumentError.value(type, 'type', 'Expected sub or dub');
    }

    final response = await _dio.get<Map<String, dynamic>>(
      'watch/$source/$anilistId/$episode/$type',
    );
    final data = response.data;
    if (data == null || data['hlsProxyUrl'] is! String) {
      throw const FormatException('The watch response has no HLS proxy URL.');
    }
    return data;
  }
}
