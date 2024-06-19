import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Data/NewsData.dart';
import '../Model/NewsModel.dart';

part 'crud_news_state.dart';

class CrudNewsCubit extends Cubit<List<NewsModel>> {
  CrudNewsCubit() : super(news);
  void addNews(NewsModel newsModel) {
    return state.add(newsModel);
  }

  Future allNews() async => state;
}
