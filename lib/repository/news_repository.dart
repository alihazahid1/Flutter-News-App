import 'dart:convert';

import 'package:http/http.dart'as http;

import '../models/categories_news_model.dart';
import '../models/news_channel_headlines_model.dart';


class NewsRepository{
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String name)async{
    String url ='https://newsapi.org/v2/top-headlines?sources=${name}&apiKey=e95336c94081463190a36c3016a5a602';
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var data= jsonDecode(response.body.toString());
      return NewsChannelsHeadlinesModel.fromJson(data);
    }
    throw Exception('ERROR');

  }

  Future<CategoryModel> fetchNewsCategoriesApi(String category)async{
    String url ='https://newsapi.org/v2/everything?q=${category}&apiKey=e95336c94081463190a36c3016a5a602';
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var data= jsonDecode(response.body.toString());
      return CategoryModel.fromJson(data);
    }
    throw Exception('ERROR');

  }
}