import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/categories_news_model.dart';

class CategoriesController extends GetxController{


  // void onInit() async{
  //   await fetchCategoriesNewsApis;
  //   super.onInit();
  // }

  final format = DateFormat('MMM dd,yyyy');
  var categoriesName = 'General'.obs;
  List<String>categoriesList = [
    'General',
    'Technology',
    'Health',
    'Sports',
    'Business',
    'Entertainment'
  ];

  Future<CategoriesNewsModel>fetchCategoriesNewsApis(String category) async {
    String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=8c17bc88eaab46a5a8e3197e7764caf4";
    try {
      final response = await get(Uri.parse(url));
      final body = jsonDecode(response.body.toString());

      print('HELLO${body}');
      if (response.statusCode == 200) {
        return CategoriesNewsModel.fromJson(body);
      }
      else {
        return CategoriesNewsModel.fromJson(body);
      }
    } catch (e){
      throw Exception("Error loading");
    }
  }

}