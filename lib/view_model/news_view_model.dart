

import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

import '../models/categories_news_model.dart';

class NewsViewModel{
  final _rep= NewsRepository();
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String name)async{
    final response =await _rep.fetchNewsChannelHeadlinesApi(name);
    return response;
  }
  Future<CategoryModel> fetchNewsCategoriesApi(String category)async{
    final response =await _rep.fetchNewsCategoriesApi(category);
    return response;
  }
}