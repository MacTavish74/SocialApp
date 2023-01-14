import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(LoginInitiateState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    Future<void> userLogin(
        {required String email, required String password}) async {
      try {
        emit(LoginLoadingState());
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        emit(LoginSuccessState(FirebaseAuth.instance.currentUser!.uid));
      } on DioError catch (e) {
        if (e.type == DioErrorType.response) {
          print('error ${e.response!.data}');

          emit(LoginErrorState(e.response!.data));
          // ...
        } else {
          print(e.error.toString());
          emit(LoginErrorState(e.toString()));
        }
      } catch (error) {
        emit(LoginErrorState(error.toString()));
        print('test$error');
      }
    }
  }
}
