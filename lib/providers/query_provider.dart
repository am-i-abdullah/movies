import 'package:flutter_riverpod/flutter_riverpod.dart';

final queryProvider =
    StateNotifierProvider<QueryNotifier, Map<String, dynamic>>(
        (ref) => QueryNotifier());

class QueryNotifier extends StateNotifier<Map<String, dynamic>> {
  QueryNotifier()
      : super({
          'query': '',
          'show_results': false,
        });

  void updateQuery(String newQuery) {
    state = {...state, 'query': newQuery};
  }

  void setShowResults(bool show) {
    state = {...state, 'show_results': show};
  }
}
