import 'package:QuatesApp/App/api.dart';
import 'package:QuatesApp/App/imports.dart';
import 'package:QuatesApp/UI/Home/Controller/home_controller.dart';
import 'package:QuatesApp/UI/Home/Model/tag.dart';
import 'package:QuatesApp/UI/Home/View/FavQuotesPage.dart';
import 'package:QuatesApp/UI/Home/View/QuotesPage.dart';
import 'package:QuatesApp/UI/Models/provider_mode.dart';
import 'package:flip_card/flip_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // HomeController _homeController;
  Tag quote;
  int _currentIndex = 0;

  final List<Widget> _mainPages = [
    QuotesPage(),
    FavQuotesPage(),
  ];

  Size mq;
  bool _flip = false;
  double _containerHeight = 300;
  bool _isBig = true;
  int _rotateSpeed = 500;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    _isBig = true;
    HomeController.controller.page = -1;
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Theme.of(context).textTheme.headline6.color,
          ),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        actions: [
          IconButton(
            icon: Provider.of<ProviderModel>(context).darkMode
                ? Icon(
                    Icons.lightbulb,
                    color: Colors.blueGrey,
                  )
                : Icon(Icons.lightbulb_outline),
            onPressed: () {
              Provider.of<ProviderModel>(context, listen: false).setDarkMode();
            },
          ),
        ],
      ),
      body: Container(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          height: _isBig ? mq.height : mq.height * 0.7,
          child: FlipCard(
            front: _mainPages[_currentIndex],
            back: _mainPages[_currentIndex],
            onFlipDone: (_) {},
            key: cardKey,
            flipOnTouch: false,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _isBig = !_isBig;
            cardKey.currentState.toggleCard();
            Future.delayed(Duration(milliseconds: (_rotateSpeed * 0.2).toInt()),
                () {
              _isBig = !_isBig;
              _currentIndex = newIndex;
              setState(() {});
            });
          });
        },
        selectedItemColor: Colors.cyan,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }

  // Future<Tag> _getNewQuote() async {
  //   print("___calling new");
  //   setState(() {
  //     quote = null;
  //   });
  //   await ApiClient.apiClient.getQuote().then((value) {
  //     quote = value;
  //   });
  //   return quote;
  // }
}
