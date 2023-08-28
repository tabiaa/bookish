import 'storage_controller.dart';
import 'package:dio/dio.dart';

class AuthController {
  final Dio dio = Dio();
  Future<bool> register(String email, String password) async {
    try {
      Response response = await dio.post('https://reqres.in/api/register',
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (error) {
      print(error.response?.statusCode ?? "Something went wrong");
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      var response = await dio.post('https://reqres.in/api/login',
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        await StorageController().saveData(true);
        return true;
      } else {
        return false;
      }
    } on DioException catch (error) {
      print(error);
      print(error.response?.statusCode ?? "Something went wrong");
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
