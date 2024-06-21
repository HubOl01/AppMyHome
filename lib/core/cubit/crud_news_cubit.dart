import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Data/NewsData.dart';
import '../Model/NewsModel.dart';

part 'crud_news_state.dart';

class CrudNewsCubit extends Cubit<List<NewsModel>> {
  CrudNewsCubit() : super(news);
  void addNews(NewsModel newsModel) {
    state.add(newsModel);
    return emit(state);
  }

  Future allNews() async {
    print("allNews");
    return emit(state);
  }

  Future updateNew(int index, NewsModel newsModel) async {
    state.insert(index, newsModel);
    return emit(state);
  }

  Future deleteNew(NewsModel newsModel) async {
    state.remove(newsModel);
    return emit(state);
  }
}
