import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioManagerProvider = Provider<DioManager>((ref) {
  return DioManager();
});

class DioManager {
  final dio = Dio();
}
