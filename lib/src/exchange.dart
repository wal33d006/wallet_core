library exchange;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:wallet_core/models/api.dart';

class Exchange extends Api {
  String? _base;
  late Client _client;

  Exchange({String base = 'https://api.totle.com'}) {
    _base = base;
    _client = new Client();
  }

  Future<Map<String, dynamic>?> _get(String endpoint) async {
    print('Exchange - GET $_base/$endpoint');
    Uri uri = Uri.parse('$_base/$endpoint');
    Response response = await _client.get(uri);
    return responseHandler(response);
  }

  Future<Map<String, dynamic>?> _post(String endpoint, {Map? body}) async {
    print('Exchange - POST $_base/$endpoint');
    Uri uri = Uri.parse('$_base/$endpoint');
    Response response = await _client.post(uri,
        headers: {"Content-Type": 'application/json'}, body: json.encode(body));
    return responseHandler(response);
  }

  Future<Map<String, dynamic>?> swap(String walletAddress, {required Map options}) async {
    Map body = Map.from({
      'address': walletAddress,
      ...options,
    });

    Map<String, dynamic>? response = await _post('swap', body: body);
    return response;
  }
}
