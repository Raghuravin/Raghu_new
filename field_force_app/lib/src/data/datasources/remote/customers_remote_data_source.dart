import 'mock_api_service.dart';
import '../../models/customer_model.dart';

class CustomersRemoteDataSource {
  CustomersRemoteDataSource(this._api);

  final MockApiService _api;

  Future<List<CustomerModel>> fetchCustomers() async {
    final response = await _api.getCustomers();
    return response
        .map((json) => CustomerModel.fromJson(_normalize(json)))
        .toList();
  }

  Map<String, dynamic> _normalize(Map<String, dynamic> json) {
    return {...json, 'updatedAt': DateTime.parse(json['updatedAt'] as String)};
  }
}
