import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telo/registration/sign_up/signup_repository.dart';
import 'package:telo/registration/sign_up/signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final SignUpRepository _repository = SignUpRepository();

  void requestotp(email, phone) {
    emit(SignUpSubmitting());
    _repository
        .requestotp(email, phone)
        .then((Response) => emit(SignUpSuccess()))
        .catchError((value) {
      DioException error = value;
      if (error.response != null) {
        emit(SignUpFailed(error.response!.data));
      } else {
        if (error.type == DioExceptionType.unknown) {
          emit(SignUpFailed("Please check your internet connection"));
        } else {
          emit(SignUpFailed(error.message));
        }
      }
    });
  }
}
