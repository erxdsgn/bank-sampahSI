import 'dart:async';

// import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

class AuthRepository {
  // final ApiClient _apiClient = ApiClient();

  Future<UserModel> register({
    required String name,
    required String nik,
    required String wa,
    required String anggotaKeluarga,
    required String email,
    required String address,
    required String password,
  }) async {
    try {
      // final response = await _apiClient.post('register', {
      //   'name': name,
      //   'nik': nik,
      //   'whatsapp': wa,
      //   'anggota_keluarga': anggotaKeluarga,
      //   'email': email,
      //   'address': address,
      //   'password': password,
      // });

      // return UserModel.fromJson(response['data']);
      await Future.delayed(const Duration(seconds: 2));
      return UserModel(
        id: '1',
        name: name,
        email: email,
        token: 'token-register',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }




  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      // (Nanti di-uncomment saat API asli sudah siap)
      /*
      final response = await _apiClient.post('login', {
        'email': email, 'password': password,
      });
      return UserModel.fromJson(response['data']);
      */

      // SIMULASI SEMENTARA:
      await Future.delayed(const Duration(seconds: 2));
      if (email == 'admin@banksampah.com' && password == '123456') {
        return UserModel(
          id: '1', 
          name: 'Admin Bank Sampah', 
          email: email, 
          token: 'token-login-abc'
        );
      } else {
        throw Exception('Email atau Password salah!');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
