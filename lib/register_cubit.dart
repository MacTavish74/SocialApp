import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

import 'package:social_app/register_states.dart';
import 'package:social_app/social_user_Model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(RegisterInitiateState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // void userLogin({required String email, required String password}) {
  //   emit(LoginLoadingState());
  //   DioHelper.postData(url: LOGIN, data: {
  //     'email': email,
  //     'password': password,
  //   }).then((value) {
  //     print(value.data);
  //     emit(LoginSuccessState(loginModel));
  //   }).catchError((error) {
  //     emit(LoginErrorState(error.toString()));
  //   });
  // }
  Future<void> userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      emit(RegisterLoadingState());
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCreateUser(
          email: email,
          name: name,
          phone: phone,
          uID: FirebaseAuth.instance.currentUser!.uid);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(RegisterErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(RegisterErrorState(e.toString()));
      }
    } catch (error) {
      emit(RegisterErrorState(error.toString()));
      print('test$error');
    }
  }

  Future<void> userCreateUser(
      {required String email,
      required String name,
      required String phone,
      required String uID}) async {
    try {
      SocialUserModel model =
          SocialUserModel(name: name, email: email, phone: phone, uID: uID,isEmailVerified: false);

      FirebaseFirestore.instance
          .collection('users')
          .doc(uID)
          .set(model.toMap());
      emit(CreateUserSuccessState());
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(RegisterErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(RegisterErrorState(e.toString()));
      }
    } catch (error) {
      emit(RegisterErrorState(error.toString()));
      print('test$error');
    }
  }
}
