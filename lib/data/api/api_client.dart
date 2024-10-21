import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import 'package:getondial/data/model/response/address_model.dart';
import 'package:getondial/data/model/response/error_response.dart';
import 'package:getondial/data/model/response/module_model.dart';
import 'package:getondial/helper/responsive_helper.dart';
import 'package:getondial/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    if (kDebugMode) {
      print('Token: $token');
    }
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
    } catch (_) {}
    int? moduleID;
    if (GetPlatform.isWeb &&
        sharedPreferences.containsKey(AppConstants.moduleId)) {
      try {
        moduleID = ModuleModel.fromJson(
                jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!))
            .id;
      } catch (_) {}
    }
    updateHeader(
        token,
        addressModel?.zoneIds,
        addressModel?.areaIds,
        sharedPreferences.getString(AppConstants.languageCode),
        moduleID,
        addressModel?.latitude,
        addressModel?.longitude);
  }

  Map<String, String> updateHeader(
      String? token,
      List<int>? zoneIDs,
      List<int>? operationIds,
      String? languageCode,
      int? moduleID,
      String? latitude,
      String? longitude,
      {bool setHeader = true}) {
    Map<String, String> header = {};
    if (moduleID != null) {
      header.addAll({AppConstants.moduleId: moduleID.toString()});
    }
    header.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.zoneId: zoneIDs != null ? jsonEncode(zoneIDs) : '',

      ///this will add in ride module
      // AppConstants.operationAreaId: operationIds != null ? jsonEncode(operationIds) : '',
      AppConstants.localizationKey:
          languageCode ?? AppConstants.languages[0].languageCode!,
      AppConstants.latitude: latitude != null ? jsonEncode(latitude) : '',
      AppConstants.longitude: longitude != null ? jsonEncode(longitude) : '',
      'Authorization': 'Bearer $token'
      // 'Authorization':
      //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNmQ4Yzk1Mzg1ZDRiYTEwYmIyODIwNWRkNWIxYTQzODRkMDVhMDgwM2VkOTIwY2FiODAwMTNkMzZmZmFiNWM0ZGFkMGNjN2ExOGU3OGY1ZWYiLCJpYXQiOjE2ODczMzE5NTUuNDg2ODE5OTgyNTI4Njg2NTIzNDM3NSwibmJmIjoxNjg3MzMxOTU1LjQ4NjgyNDk4OTMxODg0NzY1NjI1LCJleHAiOjE3MTg5NTQzNTUuNDgwMTg0MDc4MjE2NTUyNzM0Mzc1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.cDkbpZTGGIBHnasshnIakrMAF6tkFeR6wgmX69pDzmZBE7OE7pr51PHs_T8RLeLenmv8MIZQwbZ4CTelN-UidMgWIof6dVZaZO0Wk2C6tjaBTPGEBLhIxbwltAL9qjUoj7Fy2veDjbdfYWxZkpom4HJNV99z0r-GMpxXJJAlo0MJaF8bDoXh2Cz3gTuhgqiu3DKdgBN27eYZXIcIhqwtmzFEvrvk-cUvB3rpoyajQcV8XiMNR7lqXzVmtbohu89DCy2nXHya4093Ax_i3g0sezcv4DOWPO01pUAHsnaM4hBqVXDJinxBg6DYPEPmi_LRmD3iC5GlZ6EzeXdyqvNM_4cYH5WMfbU8JLpRO8ECTOYvydiCyUkTQmsSQdlBx7fCgbplsbWIM2zfn6lcgl3J7qqrSkbC4SkY6zfjCxhvjxHoyEmH4v7fiz95OM-20GhT8Rct-O0TqrxA2dx98PK-CtPM0SNm9KUVZ-EP8IdxsMHFXfX_1FrxX8QHi4Fyhy5J1qCKUjO-wIxBuOl3VDDh2n6lQqDDZtsJ_WyZj5enBwwPBlpWOvICgajkSXzybtRK7O4X6soSogQQhtaIlKQdJfYVG1NSvIQA9lA_UH0uhs83323EgKoO2-gUJOoTWznxS-2rpXpfd-TuLq3GzsDzaJbT-QKDjPZUQya3ZQwiM3Y'
    });
    if (setHeader) {
      _mainHeaders = header;
    }
    return header;
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http
          .get(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      if (kDebugMode) {
        print('------------${e.toString()}');
      }
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers, int? timeout}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
       return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key,
            multipart.file!.readAsBytes().asStream(),
            list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response response = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http
          .delete(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.errors![0].message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    
    if (kDebugMode) {
      print('====> API Response: [${response0.statusCode}] $uri');
      if (!ResponsiveHelper.isWeb() || response.statusCode != 500) {
        print('${response0.body}');
      }
    }
    return response0;
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
