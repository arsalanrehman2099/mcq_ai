import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:mcq_ai/utils/constant_manager.dart';

import '../views/dashboard/preview_result_screen.dart';

class CalculationApi {
  final dio = Dio();
  var BASE_URL = 'http://10.0.2.2:8080';

  apiTest() async {
    var response = await dio.get('$BASE_URL/py_server');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response}');
  }

  performCalculation({imageFile, correctAnswers}) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });
      var url = '$BASE_URL/api/prediction?true=$correctAnswers';
      print(url);
      final response = await dio.post(url, data: formData);
      Get.back();

      print(response.data);

      if (response.statusCode == 200) {
        if (response.data['error'] == 0) {

          ConstantManager.showtoast(response.data['client-message']);
          Get.to(() => PreviewResultScreen(
                apiResponse: response.data,
                correctAnswer: correctAnswers,
              ));
        } else {
          ConstantManager.showtoast(response.data['client-message']);
        }
      } else {
        ConstantManager.showtoast('Error Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.back();

      ConstantManager.showtoast('Exception Occurred: $e');
    }
  }
}
