import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/news_channel_headlines_models.dart';

class HomeScreenController extends GetxController{
 List<String>filterList= [
   'bbcNews',
   'nationalgeographic',
   'cnn',
   'bbcsport',
   'thehindu',
   'thetimesofindia',
 ].obs;
final format = DateFormat('MMM dd,yyyy');
var selectedMenu = ' '.obs;
RxString name= 'bbc-News'.obs;
  Future<NewsChannelHeadlinesModels>fetchNewsChannelHeadlinesApi(String channelName) async {
    String url = "https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=8c17bc88eaab46a5a8e3197e7764caf4";
    try {
      final response = await get(Uri.parse(url));
      final body = jsonDecode(response.body.toString());

      print(body);
      if (response.statusCode == 200) {
        return NewsChannelHeadlinesModels.fromJson(body);
      }
      else {
        return NewsChannelHeadlinesModels.fromJson(body);
      }
    } catch (e){
      throw Exception("Error loading");
    }
  }
}