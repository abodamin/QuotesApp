import 'package:QuatesApp/App/imports.dart';
import 'package:QuatesApp/UI/Home/Controller/fav_controller.dart';
import 'package:QuatesApp/UI/Home/Controller/home_controller.dart';
import 'package:QuatesApp/UI/Home/View/SingleQuote.dart';
import 'package:QuatesApp/UI/Widgets/responsive.dart';
import 'package:smooth_shadow/smooth_card.dart';
import 'package:toast/toast.dart';

class FavQuotesPage extends StatefulWidget {
  @override
  _FavQuotesPageState createState() => _FavQuotesPageState();
}

class _FavQuotesPageState extends State<FavQuotesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Map<dynamic, dynamic>>>(
          future: FavController.controller.getLikedQuotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: getMediaHeight(context),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      snapshot.data.length == 0 ? 1 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data.length == 0) {
                      return Container(
                        height: getMediaWidth(context),
                        child: Center(
                          child: Text(
                            "Ops you didn't like anything yet \n :\\",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.all(get12Size(context)),
                      child: SmoothCard(
                        height: get200Size(context) + get100Size(context),
                        child: InkWell(
                          onLongPress: () {
                            _showDialog(
                              context,
                              snapshot.data[index]['id'],
                            );
                          },
                          child: SingleQuote(
                            author: snapshot.data[index]['author'],
                            content: snapshot.data[index]['content'],
                            isLiked: snapshot.data[index]['isLiked'] == 0
                                ? false
                                : true,
                            id: snapshot.data[index]['id'],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return MyLoadingWidget();
            }
          }),
    );
  }

  void _showDialog(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Quote'),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Are you sure you want to delete"),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  await HomeController.controller.deleteQuote(id).then((value) {
                    setState(() {});
                  });
                  Toast.show(
                    "Deleted succefuly",
                    context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                  );
                  Navigator.pop(context);
                },
                child: const Text('DELETE'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CLOSE'),
              ),
            ],
          );
        });
  }
}
