import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';

/// Talks HTTP, enforces the timeout, maps failures to [ApiException].
/// Together with UserRepository this is the only code that imports package:http.
class ApiClient {
  ApiClient(this._client, {this.host = 'jsonplaceholder.typicode.com'});

  /// Production wiring. Lives here so main.dart never imports package:http
  /// and `grep -rn "package:http" lib/` stays at two files.
  factory ApiClient.live({String host = 'jsonplaceholder.typicode.com'}) =>
      ApiClient(http.Client(), host: host);

  final http.Client _client;
  final String host;

  static const _timeout = Duration(seconds: 10);

  // Headers in one place.
  Map<String, String> get _headers => const {'Accept': 'application/json'};

  Future<http.Response> get(Uri uri) async {
    final r = await _send(() => _client.get(uri, headers: _headers));
    _log(uri, r);
    _check(r); // status BEFORE body, every time
    return r;
  }

  Future<http.Response> post(Uri uri, {required String body}) async {
    final r = await _send(
      () => _client.post(
        uri,
        headers: {..._headers, 'Content-Type': 'application/json'},
        body: body,
      ),
    );
    _log(uri, r);
    _check(r);
    return r;
  }

  Future<http.Response> _send(Future<http.Response> Function() call) async {
    try {
      return await call().timeout(_timeout);
    } on SocketException {
      throw const NoConnectionException();
    } on TimeoutException {
      throw const NoConnectionException();
    } on http.ClientException {
      // some platforms wrap the socket failure
      throw const NoConnectionException();
    }
  }

  void _check(http.Response r) {
    final s = r.statusCode;
    if (s == 401) throw const UnauthorizedException();
    if (s == 404) throw const NotFoundException();
    if (s >= 500) throw ServerException(s);
    if (s < 200 || s >= 300) throw BadResponseException('HTTP $s');
  }

  /// Public so the repository can decode after it has checked its own
  /// expectations (e.g. 201 on create).
  dynamic decode(http.Response r) {
    try {
      return jsonDecode(utf8.decode(r.bodyBytes));
    } on FormatException catch (e) {
      throw BadResponseException('not JSON: ${e.message}');
    }
  }

  void _log(Uri uri, http.Response r) {
    if (kDebugMode) {
      developer.log(
        '${r.request?.method} $uri -> ${r.statusCode} (${r.bodyBytes.length} B)',
        name: 'api',
      );
    }
  }
}
