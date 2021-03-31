import 'package:QuatesApp/App/imports.dart';
import 'package:QuatesApp/UI/Home/Model/myDB.dart';
import 'package:QuatesApp/UI/Home/Model/quotes.dart';
import 'package:QuatesApp/UI/Home/Model/record.dart';

///This class is responsible for all actions inside home page. (performance reason)
class HomeController {
  HomeController._();
  static final HomeController controller = HomeController._();

  int counter = 0;
  int page = -1;

  int incrementCounter() {
    this.counter++;
    return counter;
  }

  bool isCounterAboveLimit() {
    return counter > 2;
  }

  Future<List<Result>> pageFetch(int offset) async {
    print("___pageFetch offset: $offset");
    page = (offset / 20).round();
    if (page == 2) {
      //allow to fetch 3 times.
      return []; //empty list
    }
    Quotes quotes = await ApiClient.apiClient.getQuotes(page);

    // store in DB.
    List<Record> records = List<Record>();

    for (int i = 0; i < quotes.results.length; i++) {
      Result result = quotes.results[i];
      Record record = Record(
        result.id,
        result.content,
        result.author,
        0, // 0 = false
      );
      records.add(record);
    }

    SQLiteDbProvider.db.insertList(records);

    return quotes.results;
  }

  Future<void> likeQuote(Record record) async {
    try {
      //find, update, insert.
      // Record recordById = await SQLiteDbProvider.db.getRecordById(record.id);
      // recordById.isLiked = 1;
      SQLiteDbProvider.db.update(record);
    } catch (e) {
      print("error in likeQuote e >> $e");
      //if not found, add.
      SQLiteDbProvider.db.insert(record);
    }
  }

  Future<dynamic> deleteQuote(String id) async {
    return await SQLiteDbProvider.db.delete(id);
  }

  Future<List<Record>> getAllQuotes() async {
    return await SQLiteDbProvider.db.getAllRecords();
  }
}
