import 'package:dio/dio.dart';
import 'package:recipe_app/common/function/print_fun.dart';

import '../../util/const_util.dart';
import '../models/response_model.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConstUtil.baseUrl,
      connectTimeout: const Duration(seconds: 30), // 5 seconds
      receiveTimeout: const Duration(seconds: 30), // 3 seconds
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// GET request
  static Future<ResponseModel> getRequest(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    try {
      printInfo(endpoint);
      Response response = await _dio.get(endpoint, queryParameters: params);
      return ResponseModel(
        isSuccess: true,
        message: response.data.toString(),
        statusCode: response.statusCode ?? 200,
        responseJson: response.data,
      );
    } on DioException catch (e) {
      printError(
        'GET request error: ${e.type}, ${e.response?.statusCode}, ${e.message}',
      );
      // Handle Errors
      return _handleDioError(e);
    }
  }

  /// Error handling function
  static ResponseModel _handleDioError(DioException e) {
    printError(
      'GET request error: ${e.type}, ${e.response?.statusCode}, ${e.message}',
    );

    // Handle no internet connection
    if (e.type == DioExceptionType.connectionError) {
      return ResponseModel(
        isSuccess: false,
        message: 'No internet connection. Please check your network.',
        statusCode: 503, // Custom code for no internet
        responseJson: '',
      );
    }

    // Handle specific HTTP status codes
    if (e.response != null) {
      return ResponseModel(
        isSuccess: false,
        message: 'Error: ${e.response!.statusCode}',
        statusCode: e.response!.statusCode!,
        responseJson: e.response!.data.toString(),
      );
    }

    // General error response
    return ResponseModel(
      isSuccess: false,
      message: e.message ?? 'An error occurred',
      statusCode: e.response?.statusCode ?? 500,
      responseJson: e.response?.data.toString() ?? '',
    );
  }
}
