import 'package:QuatesApp/App/imports.dart';
import 'package:QuatesApp/UI/Home/Controller/home_controller.dart';
import 'package:QuatesApp/UI/Home/Model/quotes.dart';
import 'package:QuatesApp/UI/Home/Model/record.dart';
import 'package:QuatesApp/UI/Home/Model/tag.dart';
import 'package:QuatesApp/UI/Home/View/SingleQuote.dart';
import 'package:QuatesApp/UI/Widgets/AdaptiveButtons.dart';
import 'package:QuatesApp/UI/Widgets/responsive.dart';
import 'package:QuatesApp/UI/Widgets/utils.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:smooth_shadow/smooth_card.dart';

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  PaginationViewType paginationViewType;
  List<Result> allQuotes;

  @override
  void initState() {
    getOldQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: getMediaHeight(context) * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your daily dose of wisdome.. .",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Container(
              child: FutureBuilder<Tag>(
                future: ApiClient.apiClient.getQuote(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SmoothCard(
                      height: get200Size(context) + get200Size(context),
                      child: SingleQuote(
                        author: snapshot.data.author,
                        content: snapshot.data.content,
                        id: snapshot.data.id,
                        isLiked: false,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return FutureBuilder<List<Record>>(
                        future: HomeController.controller.getAllQuotes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.isEmpty) {
                              return SmoothCard(
                                height:
                                    get200Size(context) + get200Size(context),
                                child: SingleQuote(
                                  author: "QuoteApp team",
                                  content:
                                      "Ops nothing to show, check intenet connection and come back.",
                                  id: "--------",
                                  isLiked: false,
                                ),
                              );
                            }
                            return SmoothCard(
                              height: get200Size(context) + get200Size(context),
                              child: SingleQuote(
                                author: snapshot.data.last.author,
                                content: snapshot.data.last.content,
                                id: snapshot.data.last.id,
                                isLiked: snapshot.data.last.isLiked == 0
                                    ? false
                                    : true,
                              ),
                            );
                          } else {
                            return MyLoadingWidget();
                          }
                        });
                  } else {
                    return MyLoadingWidget();
                  }
                },
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(get8Size(context)),
              width: getMediaWidth(context),
              child: AdaptiveButton(
                color: Colors.cyan,
                onPressed: () {
                  setState(() {});
                },
                child: Text("NEXT"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getOldQuotes() async {
    allQuotes = await HomeController.controller.getAllQuotes().then((value) {
      return value.map((e) {
        return Result(
          tags: [],
          id: e.id,
          content: e.content,
          author: e.author,
          isLiked: e.isLiked == 0 ? false : true,
          length: 0,
        );
      }).toList();
    });
  }
}

/**
 * return Container(
      child: PaginationView<Result>(
        paginationViewType: paginationViewType,
        preloadedItems: allQuotes,
        itemBuilder: (BuildContext context, Result quote, int index) {
          return Container(
            margin: EdgeInsets.all(get12Size(context)),
            child: SmoothCard(
              height: get200Size(context) + get100Size(context),
              child: InkWell(
                onLongPress: () async {
                  //TODO delete
                  _showDialog(context, quote);
                },
                child: SingleQuote(
                  author: quote.author,
                  content: quote.content,
                  id: quote.id,
                ),
              ),
            ),
          );
        },
        pageFetch: HomeController.controller.pageFetch,
        pullToRefresh: true,
        onError: (dynamic error) {
          return Container(
            child: FutureBuilder<List<Record>>(
                future: FavController.controller.getAllQuotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: getMediaHeight(context),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length == 0
                            ? 1
                            : snapshot.data.length,
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
                              child: SingleQuote(
                                author: snapshot.data[index].author,
                                content: snapshot.data[index].content,
                                isLiked: snapshot.data[index].isLiked == 0
                                    ? false
                                    : true,
                                id: snapshot.data[index].id,
                              ),
                            ),
                          );
                          // return SingleQuote(
                          //   author: snapshot.data[index]['author'],
                          //   content: snapshot.data[index]['content'],
                          //   isLiked:
                          //       snapshot.data[index]['isLiked'] == 0 ? true : false,
                          //   id: snapshot.data[index]['id'],
                          // );
                        },
                      ),
                    );
                  } else {
                    return MyLoadingWidget();
                  }
                }),
          );
        },
        onEmpty: Center(
          child: Text(
            'Ops nothing to show yet\n :\\',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        bottomLoader: Center(
          child: MyLoadingWidget(),
        ),
        initialLoader: Center(
          child: MyLoadingWidget(),
        ),
      ),
    );
 */
