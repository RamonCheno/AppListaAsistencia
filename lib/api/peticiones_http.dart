// import 'dart:io';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PeticionesHttp {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = "http://192.168.1.103:80";
    _dio.options.headers = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(
        path,
      );

      // return resp.data;
      return resp;
    } catch (e) {
      debugPrint("$e");
      throw ('Error en el GET');
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    final formData = data;

    try {
      final resp = await _dio.post(path, data: formData);
      // return resp.data;
      return resp;
    } catch (e) {
      debugPrint("$e");
      throw ('Error en el POST');
    }
  }

  static Future<Response> httpPut(
      String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);
      // return resp.data;
      return resp;
    } catch (e) {
      debugPrint("$e");
      throw ('Error en el PUT');
    }
  }

  static Future<Response> httpDelete(
      String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      // return resp.data;
      return resp;
    } catch (e) {
      debugPrint("$e");
      throw ('Error en el delete');
    }
  }
}
