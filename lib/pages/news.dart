import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../models/news.dart';
import '../variables.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {

  late Future<NewsList> newsList;


  @override
  void initState() {
    super.initState();
    newsList = getNewsList();
    // setState(() {
    //   _items = data["items"];
    // });
  }

  bool isLoadedImage = false;
  late String currentNewsId;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        //initialRoute: 'news',

        //  routes: {
        //   '/home': (context) => const Home(),
        //   // '/account': (context) => Account(userId: userId,),
        //   // '/members': (context) => Members(),
        //   '/news': (context) => const News(),
        //   '/shop': (context) => const Shop(),
        //   '/partners': (context) => Partners(),
        //   '/contacts': (context) => Contacts(),
        //
        // },

        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset('assets/images/burger.svg'),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

          body: Center (
              child: ListView (
                  children: [
                    Center(
                      child: Container(
                          child: Column (
                          crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox (
                                    width: 320,
                                    child: FutureBuilder<NewsList>(
                                        future: newsList,
                                        builder: (context, snapshot) {

                                          var news = snapshot.data?.news;
                                          final List<New>? newsList = snapshot.data?.news;
                                          print('news');
                                          print(newsList);

                                          if (snapshot.connectionState != ConnectionState.done) {
                                            return const Center(child: CircularProgressIndicator());
                                          }

                                          if (snapshot.hasError) {
                                            return Center(child:Text(snapshot.error.toString()));
                                          }

                                          if (snapshot.hasData) {
                                            return Center(
                                                child: SizedBox(
                                                    width: 320,
                                                    //height: 1260,
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(
                                                                bottom: 20, top: 45),
                                                            child:
                                                            const TitlePage(
                                                                title: '?????????????? ??????????????'),
                                                          ),
                                                          SizedBox(
                                                            height: 740,
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.vertical,
                                                                shrinkWrap: true,
                                                                // padding: const EdgeInsets.only(top: 38, bottom: 10),
                                                                itemCount: snapshot.data?.news.length,
                                                                itemBuilder: (context, index) {
                                                                  late Uint8List bytes;

                                                                  var pathEncode = snapshot.data?.news[index].path;
                                                                  var decode64 = base64.decode(pathEncode!);

                                                                  bytes = decode64;


                                                                  if (snapshot.data?.news[index].path != null) {
                                                                    isLoadedImage = true;

                                                                  } else {
                                                                    isLoadedImage = false;
                                                                  }

                                                                  return Container(
                                                                      width: 320,
                                                                      // height: 166,
                                                                      margin: const EdgeInsets.only(top: 10, bottom: 10,),

                                                                      child: Column (
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Stack(
                                                                                      clipBehavior: Clip.none,
                                                                                      children: [
                                                                                        Container(
                                                                                          margin: const EdgeInsets.only(bottom: 10,),
                                                                                          child: Text('${snapshot.data?.news[index].newsDate}',
                                                                                              textAlign: TextAlign.left,
                                                                                              style: const TextStyle(
                                                                                                fontSize: 32.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                fontFamily: 'CadillacSans',
                                                                                                color: Color(0xFF8F97BF),
                                                                                                height: 1.7, //line-height / font-size
                                                                                              )
                                                                                          ),
                                                                                        ),

                                                                                      ]
                                                                                  )

                                                                                ]
                                                                            ),

                                                                            Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Stack(
                                                                                      clipBehavior: Clip.none,
                                                                                      children: [
                                                                                        Text.rich(
                                                                                          TextSpan (
                                                                                              text: '${snapshot.data?.news[index].newsName}'.toUpperCase(),
                                                                                              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal, color: Colors.white, height: 1.5),
                                                                                              children: <InlineSpan>[
                                                                                                TextSpan(
                                                                                                  text: '\ncadillac escalada'.toUpperCase(),
                                                                                                  style: const TextStyle(fontSize: 24,fontWeight: FontWeight.normal, color: Colors.white, height: 1.4),
                                                                                                )
                                                                                              ]
                                                                                          ),
                                                                                        ),

                                                                                      ]

                                                                                  ),
                                                                                ]
                                                                            ),


                                                                            Container (
                                                                                width: 284,
                                                                                height: 160,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Color(0XffE4E6FF),
                                                                                  borderRadius: BorderRadius.all(Radius
                                                                                      .circular(20.0)),
                                                                                ),
                                                                                margin: const EdgeInsets.only(bottom: 10.0, top: 10),
                                                                                child: isLoadedImage ? Image.memory(
                                                                                    base64.decode(snapshot.data?.news[index].path ?? ''),
                                                                                    fit: BoxFit.cover, width: 284, height: 160) :
                                                                                const Text('no image',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      fontSize: 18.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontFamily: 'CadillacSans',
                                                                                      color: Color(0xFF8F97BF),
                                                                                      height: 1.7, //line-height / font-size
                                                                                    ))
                                                                            ),
                                                                            Container(
                                                                              margin: const EdgeInsets.only(bottom: 10,),
                                                                              child: Text('${snapshot.data?.news[index].newsDescr}',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontFamily: 'CadillacSans',
                                                                                    color: Color(0xFF8F97BF),
                                                                                    height: 1.7, //line-height / font-size
                                                                                  )
                                                                              ),
                                                                            ),
                                                                          ]
                                                                      ),
                                                      );

                                                    }
                                                ),
                                              ),

                                              // Container (
                                              //   width: MediaQuery.of(context).size.width,
                                              //   height: 200,
                                              //   padding: EdgeInsets.zero,
                                              //   margin: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                                              //   color: Color(0xFF181C33),
                                              //   child: Banners(),
                                              // ),
                                            ]
                                        )

                                    )
                                );
                            }
                            return const Center(child: Text('no data'));

                            }
                          )
                                )

                              ]
                          ),

                    ),
                  )

               ]
            )
          ),

          drawer: const NavDrawer(),
        ),

    );
  }
}

Future<NewsList> getNewsList() async {
  print('getNewsList');
  const url = baseUrl + '/test/news_list.php';
  final response = await http.get(Uri.parse(url));
  print('response members getUserLists');
  print(response.body);
  if(response.statusCode == 200) {
    return NewsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}