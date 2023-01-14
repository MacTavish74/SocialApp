import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/constants.dart';
import 'package:social_app/shopStates.dart';
import 'package:social_app/social_user_Model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> buttonitems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ('Home')),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: ('Categories')),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ('favourites')),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: ('Settings'))
  ];
  // List<Widget> screens = [Products(), Categories(), Favourites(), Settings()];
  // void onchanged(int index) {
  //   currentIndex = index;
  //   emit(ShopButNavState());
  // }

  SocialUserModel? model;
  Future<void> getUserData() async {
    try {
      emit(SocialGetUserLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        model = SocialUserModel.fromJson(value.data());
        emit(SocialGetUserSuccessState());
      });
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('error ${e.response!.data}');

        emit(SocialGetUserErrorState(e.response!.data));
        // ...
      } else {
        print(e.error.toString());
        emit(SocialGetUserErrorState(e.toString()));
      }
    } catch (error) {
      emit(SocialGetUserErrorState(error.toString()));
      print('test$error');
    }
  }

  // Future<void> getCategories() async {
  //   try {
  //     emit(CategorieLoadingState());
  //     final value = await DioHelper.getData(url: GET_CATEGORIES, token: token);
  //     categorieModel = CategorieModel.fromJson(value.data);
  //     emit(CategorieSuccessState());
  //   } on DioError catch (e) {
  //     if (e.type == DioErrorType.response) {
  //       print('error ${e.response!.data}');

  //       emit(ShopErrorState(e.response!.data));
  //       // ...
  //     } else {
  //       print(e.error.toString());
  //       emit(ShopErrorState(e.toString()));
  //     }
  //   } catch (error) {
  //     emit(ShopErrorState(error.toString()));
  //     print('test$error');
  //   }
  // }

  // Future<void> getUserData() async {
  //   try {
  //     emit(ShopUserDataLoadingState());
  //     final value = await DioHelper.getData(url: PROFILE, token: token);
  //     usermodel = LoginModel.fromJson(value.data);
  //     print(usermodel!.data!.name);
  //     emit(ShopUserDataSuccessState(usermodel));
  //   } on DioError catch (e) {
  //     if (e.type == DioErrorType.response) {
  //       print('error ${e.response!.data}');

  //       emit(ShopErrorState(e.response!.data));
  //       // ...
  //     } else {
  //       print(e.error.toString());
  //       emit(ShopErrorState(e.toString()));
  //     }
  //   } catch (error) {
  //     emit(ShopErrorState(error.toString()));
  //     print('test$error');
  //   }
  // }
}
