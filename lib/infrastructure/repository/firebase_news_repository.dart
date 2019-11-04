import 'package:nocia/domain/repository/news_repository.dart';
import 'package:nocia/domain/repository/repository.dart';
import 'package:nocia/infrastructure/repository/db_reference.dart';

class FirebaseNewsRepository extends NewsRepository implements Repository {
  @override
  Future<List<dynamic>> getNews() async{
    var snapshot = await instance().child("news").once();
    var newsList = snapshot.value as Map;
    return newsList.values.toList();
  }
}