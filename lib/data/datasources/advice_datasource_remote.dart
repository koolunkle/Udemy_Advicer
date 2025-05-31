import 'dart:convert';

import 'package:advicer/data/exceptions/exceptions.dart';
import 'package:advicer/data/models/advice_model.dart';
import 'package:http/http.dart' as http;

mixin AdviceDatasourceRemote {
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceDatasourceRemoteImpl implements AdviceDatasourceRemote {
  final http.Client client = http.Client();

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {'accept': 'application/json'},
    ); // content-type
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = (json.decode(response.body)) as Map<String, dynamic>;
      return AdviceModel.fromJson(responseBody);
    }
  }
}
