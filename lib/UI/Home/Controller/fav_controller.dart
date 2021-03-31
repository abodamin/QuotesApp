import 'package:QuatesApp/UI/Home/Model/myDB.dart';
import 'package:QuatesApp/UI/Home/Model/record.dart';

///This class is responsible for all actions inside FavPage. (performance reason)
class FavController {
  FavController._();
  static final FavController controller = FavController._();

  Future<List<Map<dynamic, dynamic>>> getLikedQuotes() async {
    return await SQLiteDbProvider.db.getLikedQuotes();
  }

  Future<List<Record>> getAllQuotes() async {
    return await SQLiteDbProvider.db.getAllRecords();
  }
}
