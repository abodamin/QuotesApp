import 'package:QuatesApp/App/imports.dart';
import 'package:QuatesApp/UI/Home/Controller/home_controller.dart';
import 'package:QuatesApp/UI/Home/Model/record.dart';
import 'package:QuatesApp/UI/Models/provider_mode.dart';
import 'package:QuatesApp/UI/Widgets/responsive.dart';
import 'package:provider/provider.dart';

class SingleQuote extends StatefulWidget {
  final String content;
  final String author;
  final String id;
  bool isLiked;

  SingleQuote({
    Key key,
    this.content,
    this.author,
    this.id,
    this.isLiked = false,
  }) : super(key: key);

  @override
  _SingleQuoteState createState() => _SingleQuoteState();
}

class _SingleQuoteState extends State<SingleQuote> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        //  --- Icon
        Align(
          alignment: Alignment.topLeft,
          child: RotatedBox(
            quarterTurns: 2,
            child: Image.asset(
              'assets/icons/quote.png',
              height: get40Size(context),
              color: Provider.of<ProviderModel>(context).darkMode
                  ? Colors.blueGrey
                  : null,
            ),
          ),
        ),
        //  --- Content
        Container(
          alignment: Alignment.center,
          child: Text(
            widget.content ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
            // maxLines: 100,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("- ${widget.author ?? ""}"),
          ),
        ),
        //  --- Icon
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset(
            'assets/icons/quote.png',
            height: get40Size(context),
            color: Provider.of<ProviderModel>(context).darkMode
                ? Colors.blueGrey
                : null,
          ),
        ),
        // --- Counter
        Align(
          alignment: Alignment.bottomLeft,
          child: IconButton(
            icon: widget.isLiked ?? false
                ? Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  )
                : Icon(Icons.favorite_border),
            onPressed: () {
              if (!widget.isLiked) {
                Record _tempRecord = Record(
                  widget.id,
                  widget.content,
                  widget.author,
                  1, //liked
                );

                HomeController.controller.likeQuote(_tempRecord);
              }

              setState(() {
                widget.isLiked = !widget.isLiked;
              });
            },
          ),
        ),
      ],
    );
  }
}
