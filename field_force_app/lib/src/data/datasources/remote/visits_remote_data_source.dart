import '../../models/visit_model.dart';
import 'mock_api_service.dart';

class VisitsRemoteDataSource {
  VisitsRemoteDataSource(this._api);

  final MockApiService _api;

  Future<List<VisitModel>> fetchTodayVisits() async {
    final response = await _api.getTodayVisits();
    return response
        .map((json) => VisitModel.fromJson(_normalize(json)))
        .toList();
  }

  Map<String, dynamic> _normalize(Map<String, dynamic> json) {
    return {
      ...json,
      'plannedStart': DateTime.parse(json['plannedStart'] as String),
      'plannedEnd': DateTime.parse(json['plannedEnd'] as String),
      'updatedAt': DateTime.parse(json['updatedAt'] as String),
    };
  }
}
