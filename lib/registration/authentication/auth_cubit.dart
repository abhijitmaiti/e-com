import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:telo/registration/authentication/auth_repository.dart';
import 'package:telo/registration/authentication/auth_state.dart';

class AuthCubit extends Cubit<AuthSate> {
  static String token = '';
  AuthRepository authRepository;
  final FlutterSecureStorage storage;

  AuthCubit({required this.storage, required this.authRepository})
      : super(AuthInitial());
  Future<AuthSate> authenticate() async {
    AuthSate newState;
    if (token.isEmpty) {
      try {
        var tokenValue = await _getToken();
        if (tokenValue == null) {
          newState = LoggedOut();
          emit(newState);
        } else {
          token = tokenValue;
          newState = await _fetchUserData();
        }
      } catch (e) {
        newState = LoggedOut();
        emit(newState);
      }
    } else {
      newState = await _fetchUserData();
    }
    return newState;
  }

  Future<void> _setToken() async {
    await storage.write(key: "token", value: token);
  }

  Future<String?> _getToken() async {
    String? value = await storage.read(key: "token");
    return value;
  }

  Future<void> _deleteToke() async {
    await storage.delete(key: "token");
  }

  Future<AuthSate> _fetchUserData() async {
    AuthSate newState;
    try {
      var response = await authRepository.getUserData(token: token);
      newState = Authenticated();
      emit(newState);
    } catch (value) {
      DioException error = value as DioException;
      if (error.response != null) {
        newState = await removeToken();
      } else {
        if (error.type == DioExceptionType.unknown) {
          newState =
              AuthenticationFailed("Please check your internet connection");
          emit(newState);
        } else {
          newState = AuthenticationFailed(error.message);
          emit(newState);
        }
      }
    }
    return newState;
  }

  Future<AuthSate> removeToken() async {
    AuthSate newState;
    token = '';
    try {
      await _deleteToke();
    } catch (e) {
      //do nothing
    }
    newState = LoggedOut();
    emit(newState);
    return newState;
  }
}
