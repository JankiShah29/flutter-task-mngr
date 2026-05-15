import 'package:flutter/material.dart';
import 'package:interview_test/services/api_response.dart';

class ApiHandler {

  static Future<ApiResponse<T>> makeCall<T>({
    
    required BuildContext context,
     bool showLoader = true,
    required Future<Map<String, dynamic>> Function() apiCall,
    
    Function(ApiResponse<T> response)? onSuccess,
    Function(ApiResponse<T> response)? onFailure,
    Function(dynamic error)? onError,

  }) async {

    if (showLoader) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    try {

      final result = await apiCall();

      final response = ApiResponse<T>(
        success: result["success"] ?? false,
        message: result["message"] ?? '',
        data: result["data"],
      );

      if (response.success) {
        onSuccess?.call(response);
      } else {
        onFailure?.call(response);
      }

      return response;

    } catch (e) {

      onError?.call(e);

      return ApiResponse<T>(
        success: false,
        message: e.toString(),
        data: null,
      );

    } finally {

      if (showLoader && context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }
}