import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/widgets/titlePage.dart';


// import 'package:cadillac/models/productsList.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';

// import 'package:cadillac/widgets/productsList.dart';
import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';


class CardProduct extends StatefulWidget {
  // var productId;

  CardProduct({Key? key, }) : super(key: key);

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {

  late Future<ProductsList> productsList;

  get currentUser => null;
  List<String> images = [
    "assets/images/notebook.png",
    "assets/images/notebook.png",

  ];

  @override
  void initState() {
    super.initState();
    //officesList = getOfficesList();
    //officesList = readJson();

    // productsList = readJson();
    // setState(() {
    //   _items = data["items"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,

        routes: {
          // '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          '/shop': (context) => Shop(),
          // '/partners': (context) => Partners(),
          // '/contacts': (context) => Contacts(),

        },
        home: Scaffold(

          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  // icon: SvgPicture.network('assets/images/burger.svg'),
                  onPressed: () {

                    Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) =>
                            Shop()
                      // SuccessPayment(
                      //     currentUser: user),
                    )
                    );

                  },


                );
              },
            ),
          ),

          body: Center (
            child: Container (
            width: 284,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container (
                    width: 284,
                    margin: EdgeInsets.only(top: 30, bottom: 70),
                    child: const TitlePage(title: 'клубная атрибутика'),
                  ),
                  Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 320,
                          height: 279,
                          padding: EdgeInsets.zero,
                          margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                child: Swiper(

                                  itemCount: 2,
                                  // control: SwiperControl(),
                                  allowImplicitScrolling: true,
                                  //containerHeight: 160,
                                  //containerWidth: 390,
                                  viewportFraction: 0.8,
                                  itemHeight: 279,
                                  itemWidth: 332,
                                  autoplay: true,
                                  outer: true,
                                    pagination: const SwiperPagination(
                                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                                        builder: DotSwiperPaginationBuilder(
                                            color: Colors.white,
                                            activeColor: Color(0xFF8F97BF),
                                            size: 7.0,
                                            activeSize: 7.0
                                        )
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                          width: 332,
                                          height: 279,
                                          margin: const EdgeInsets.only(left: 0, right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),),
                                          child: Image.asset(
                                            images[index],
                                            //centerSlice: Rect.fromPoints(const Offset(0.0, 0.0), const Offset(0, 0)),
                                            fit: BoxFit.contain,
                                            // alignment: Alignment.topLeft,
                                          ),

                                        );
                                    }
                                ),
                            ),
                        Container (
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text("Блокнот".toUpperCase(),
                            style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFF8F97BF)
                            ),
                            textAlign: TextAlign.left,
                          )
                        ),

                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("3700 ",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Icon( Icons.currency_ruble,
                                color: Colors.white,
                                size: 24,),
                            ]
                        ),
                        Container (
                          child: Column (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container (
                                  margin: EdgeInsets.only(top: 100, bottom: 15),
                                  child: Text("Хотите такой блокнот?".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                              ),
                              Container (
                                margin: const EdgeInsets.only(bottom: 15),
                                child: const TitlePage(title: 'Напишите нам'),
                              ),
                              Socials()
                            ]
                        )
                    )

                      ]
                  )

              ]
             )
          )
          )
        )

    );
  }
}