import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/models/users.dart';
//import 'package:cadillac/models/user.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../NavDrawerAdmin.dart';
import '../variables.dart';
import 'accountAdmin.dart';
import 'addUser.dart';
import 'homeAdmin.dart';

class MembersAdmin extends StatefulWidget {
  const MembersAdmin({Key? key}) : super(key: key);

  @override
  State<MembersAdmin> createState() => _MembersAdminState();
}

class _MembersAdminState extends State<MembersAdmin> {
  late Future<UsersList> usersList;

  @override
  void initState() {
    super.initState();
    //officesList = getOfficesList();
    //officesList = readJson();

    //usersList = readJson(); //работает на сервере, на ондроид нет

    usersList = getUsersList();
    // setState(() {
    //   _items = data["items"];
    // });
  }
  int selectedIndex = 1;

  bool isLoadedImage = false;
  bool isLoadedCar = false;
  late Uint8List image;
  late Uint8List car1;

  late String currentUserId;
  String path = "assets/images/avatar.png";



  // final List<String> users = <String>["денис антонов", "денис антонов", "денис антонов", "денис антонов", "денис антонов", "денис антонов"];

  @override
  Widget build(BuildContext context) {
    // Widget mainWidget = const Members();

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        // initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeAdmin(),
          // '/account': (context) => Account(),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),

        },
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2C335E),
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

          // body: mainWidget,
          body: Center(
              child: ListView(
                  children: [
                    Center(
                        child: Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment
                              //     .center,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [

                                  SizedBox (
                                    width: 284,
                                    //height: 580,
                                    child: FutureBuilder<UsersList>(
                                        future: usersList,
                                        builder: (context, snapshot) {

                                          var users = snapshot.data?.users;
                                          final List<User>? usersList = snapshot.data?.users;
                                          // print('members');
                                          // print(usersList);
                                          if (snapshot.connectionState != ConnectionState.done) {
                                            return const Center(child: CircularProgressIndicator());
                                          }

                                          if (snapshot.hasError) {
                                            return Center(child:Text(snapshot.error.toString()));
                                          }

                                          if (snapshot.hasData) {

                                            return Center(
                                                child: SizedBox(
                                                    width: 284,
                                                    height: 860,
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(
                                                                bottom: 20),
                                                            child:
                                                            const TitlePage(
                                                                title: 'члены автоклуба'),
                                                          ),
                                                          SizedBox(
                                                            height: 780,
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.vertical,
                                                                shrinkWrap: true,
                                                                // padding: const EdgeInsets.only(top: 38, bottom: 10),
                                                                itemCount: snapshot.data?.users.length,
                                                                itemBuilder: (context, index) {
                                                                // print('path snapshot');
                                                                // print(snapshot.data?.users[index].path);

                                                                List<Uint8List> images = [];
                                                                late Uint8List bytes;
                                                                late Uint8List bytesCar1;
                                                                var pathEncode = snapshot.data?.users[index].path;
                                                                var decode64 = base64.decode(pathEncode!);

                                                                bytes = decode64;

                                                                if (snapshot.data?.users[index].path != null) {
                                                                isLoadedImage = true;

                                                                } else {
                                                                isLoadedImage = false;
                                                                }

                                                                if (snapshot.data?.users[index].car1 != null) {
                                                                isLoadedCar = true;
                                                                var car1Encode = snapshot.data?.users[index].car1;
                                                                var car1Decode64 = base64.decode(car1Encode!);
                                                                bytesCar1 = car1Decode64;
                                                                // print('bytesCar1');
                                                                // print(bytesCar1);
                                                                // if (bytesCar1.isNotEmpty) {
                                                                //   images.add(bytesCar1);
                                                                // } else {
                                                                //   print('car1 no exist');
                                                                // }
                                                                } else {
                                                                isLoadedCar =  false;
                                                                }
                                                                  return GestureDetector(
                                                                      onLongPress: () {
                                                                        setState(() {
                                                                          // устанавливаем индекс выделенного элемента
                                                                          selectedIndex =
                                                                              index;
                                                                          var currentUserId = snapshot.data?.users[selectedIndex].userId;
                                                                        });
                                                                        Navigator
                                                                            .pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (
                                                                                    context) =>
                                                                                    AccountAdmin())
                                                                        );
                                                                      },
                                                                  child: Container(
                                                                      width: 284,
                                                                      // height: 166,
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical: 10,
                                                                          horizontal: 10),
                                                                      margin: const EdgeInsets.only(
                                                                          top: 10, bottom: 10),
                                                                      decoration: BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFE4E6FF),
                                                                        borderRadius: BorderRadius
                                                                            .circular(10),
                                                                      ),

                                                                      child: Flex(
                                                                          direction: Axis.vertical,
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            Flexible(
                                                                                fit: FlexFit.loose,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                        margin: const EdgeInsets.only(bottom: 10),
                                                                                        child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                  '${snapshot.data
                                                                                                      ?.users[index]
                                                                                                      .username}'
                                                                                                      .toUpperCase(),
                                                                                                  textAlign: TextAlign
                                                                                                      .right,
                                                                                                  style: const TextStyle(
                                                                                                    fontSize: 14.0,
                                                                                                    fontWeight: FontWeight
                                                                                                        .w700,
                                                                                                    fontFamily: 'CadillacSans',
                                                                                                    color: Colors
                                                                                                        .black,
                                                                                                    height: 1.7, //line-height / font-size
                                                                                                  )
                                                                                              ),
                                                                                              Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                        'именной номер'.toUpperCase(),
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          fontSize: 14.0,
                                                                                                          fontWeight: FontWeight
                                                                                                              .normal,
                                                                                                          fontFamily: 'CadillacSans',
                                                                                                          color: Colors
                                                                                                              .black,
                                                                                                          height: 1.7, //line-height / font-size
                                                                                                        )
                                                                                                    ),
                                                                                                    Text(
                                                                                                        '${snapshot.data
                                                                                                            ?.users[index]
                                                                                                            .login}'
                                                                                                            .toUpperCase(),
                                                                                                        textAlign: TextAlign
                                                                                                            .left,
                                                                                                        style: const TextStyle(
                                                                                                          fontSize: 14.0,
                                                                                                          fontWeight: FontWeight
                                                                                                              .w700,
                                                                                                          fontFamily: 'CadillacSans',
                                                                                                          color: Colors
                                                                                                              .black,
                                                                                                          height: 1.7, //line-height / font-size
                                                                                                        )
                                                                                                    ),
                                                                                                  ]
                                                                                              )
                                                                                            ]
                                                                                        )

                                                                                    ),

                                                                                    Container(
                                                                                      margin: const EdgeInsets
                                                                                          .only(
                                                                                          bottom: 10.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment
                                                                                            .spaceBetween,
                                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                                            .center,
                                                                                        children:  [
                                                                                          ClipOval(
                                                                                            child: CircleAvatar(
                                                                                                radius: 48,
                                                                                                backgroundColor: Colors.transparent,
                                                                                                child:
                                                                                                isLoadedImage ?
                                                                                                Image.memory(
                                                                                                    base64.decode(snapshot.data?.users[index].path ?? ''),
                                                                                                    fit: BoxFit.cover,
                                                                                                    width: 96,
                                                                                                    height: 96)
                                                                                                    : Text('no image')

                                                                                              // child: Image.memory(base64.decode("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")
                                                                                            ),
                                                                                          ),

                                                                                          isLoadedCar ?
                                                                                          Image.memory(bytesCar1, fit: BoxFit.cover, width: 157, height: 79)
                                                                                              : Text('no image'),
                                                                                        ],
                                                                                      ),
                                                                                    ),

                                                                                    Row(
                                                                                        mainAxisAlignment: MainAxisAlignment
                                                                                            .end,
                                                                                        children: [
                                                                                          Text('${snapshot.data?.users[index].carname}'.toUpperCase(),
                                                                                              // Text('cadillac'.toUpperCase(),
                                                                                              style: const TextStyle(
                                                                                                fontSize: 14.0,
                                                                                                fontWeight: FontWeight
                                                                                                    .normal,
                                                                                                fontFamily: 'CadillacSans',
                                                                                                color: Color(
                                                                                                    0xFF12141F),
                                                                                                // height: 1.7, //line-height / font-size
                                                                                              )
                                                                                          ),
                                                                                          Container(
                                                                                            // height: 15,

                                                                                            margin: const EdgeInsets
                                                                                                .only(left: 42.0,),
                                                                                            alignment: Alignment
                                                                                                .centerLeft,
                                                                                            child: SvgPicture.asset(
                                                                                                'assets/images/cadillac.svg',
                                                                                                semanticsLabel: 'Icon car',
                                                                                                height: 15.0
                                                                                            ),
                                                                                          ),

                                                                                        ]
                                                                                    ),
                                                                                    Visibility(
                                                                                      visible: false,
                                                                                      child: FormBuilderTextField(
                                                                                        name: 'currentNewsId',
                                                                                        initialValue: '${snapshot.data?.users[selectedIndex].userId}',
                                                                                        onSaved: (value) => currentUserId = value!,
                                                                                      ),
                                                                                    ),
                                                                                  ]
                                                                                )

                                                                                )


                                                                          ]
                                                                      )

                                                                  )
                                                                  );


                                                                }
                                                            ),
                                                          )


                                                        ]
                                                    )
                                                )
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Text('Error');
                                          }
                                          return const Center(child: Text('no data'));

                                        }
                                    ),

                                  ),
                                  Container(
                                      width: 310,
                                      height: 20,
                                      margin: const EdgeInsets.only(left: 15, bottom: 20),
                                      alignment: const Alignment(1, 1),
                                      child: GestureDetector(
                                        onLongPress: () {
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                              const AddUser());
                                          Navigator.push(context,route);
                                        },
                                        child: SvgPicture
                                            .asset(
                                          'assets/images/add.svg',
                                          semanticsLabel: 'Icon add',
                                          height: 20.0,

                                        ),
                                      )

                                  ),
                                ]
                            )
                        )
                    )
                  ]
              )
          ),
          drawer: const NavDrawerAdmin(),
        )
    );
  }
}

Future<UsersList> getUsersList() async {
  // const url = 'https://about.google/static/data/locations.json';
  // const url = 'http://localhost/test/users_list.php';
  const url = baseUrl + '/test/users_list.php';
  final response = await http.get(Uri.parse(url));
  //print('response members getUserLists');
  //print(response.body);
  if(response.statusCode == 200) {
    return UsersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

// readData() async {
// var file="users.json";
//
//
//   await DefaultAssetBundle.of(context).loadString("assets/$file")
//       .then((s) {
//     setState(() {
//
//       var response = json.decode(s);
//       List<dynamic> list_telugu = response['telugu'];
//       List<dynamic> list_english = response['english'];
//
//       for (var k = 0; k < list_telugu.length; k++) {
//         list_items.add(Items(list_english[k], list_telugu[k]));
//       }
//
//
//     });
//   }).catchError((error) {
//
//     print(error);
//   });
// }

