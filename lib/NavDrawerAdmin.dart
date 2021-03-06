import 'package:cadillac/pages/accountAdmin.dart';
import 'package:cadillac/pages/homeAdmin.dart';
import 'package:cadillac/pages/membersAdmin.dart';
import 'package:cadillac/pages/newsAdmin.dart';
import 'package:cadillac/pages/partnersAdmin.dart';
import 'package:cadillac/pages/shopAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



//import 'models/user2.dart';

// import 'package:flutter_app_learning/routes.dart';
// final List<String> menuUser = ["главная", "мой аккаунт", "члены автоклуба", "клубные новости", "клубная атрибутика и одежда", "партнеры", "контакты"];
// final List<String> menuAdmin = ["главная", "аккаунт члена клуба", "члены автоклуба", "клубные новости", "клубная атрибутика и одежда", "партнеры"];
// final List<String> icons = ["home.svg", "account.svg", "members.svg", "news.svg", "clubwear.svg", "partners.svg", "contacts.svg"];
// final List<Widget> pages = [Home(), Account(), Members(), News(), Shop(), Partners(), Contacts()];

// final String assetName = 'assets/images/home.svg';
// final Widget svg = SvgPicture.asset(
//     menuUser[0],
//     semanticsLabel: 'Acme Logo'
// );

class NavDrawerAdmin extends StatefulWidget {
  //final currentUser = User();
  final userId;
  //const NavDrawer({Key? key, this.currentUser}) : super(key: key);
  const NavDrawerAdmin({Key? key, this.userId,}) : super(key: key);

  @override
  _NavDrawerAdminState createState() => _NavDrawerAdminState();
}

class _NavDrawerAdminState extends State<NavDrawerAdmin> {
  Widget mainWidget = const HomeAdmin();


  final List<String> menuAdmin = ["главная", "аккаунт члена клуба", "члены автоклуба", "клубные новости", "клубная атрибутика и одежда", "партнеры"];
  final List<String> icons = ["home.svg", "account.svg", "members.svg", "news.svg", "clubwear.svg", "partners.svg"];
  final List<Widget> pages = [const HomeAdmin(), AccountAdmin(), const MembersAdmin(), const NewsAdmin(), const ShopAdmin(), const PartnersAdmin()];

  static get userId => null;

  //static get currentUser => null;


  @override
  Widget build(BuildContext context) {

    return Align(
        alignment: Alignment.topLeft,
        child: Container(//Drawer здесь был
          // margin: const EdgeInsetsDirectional.only(start: 0, end: 0, top: 0, bottom: 2),
            width: 344,
            height: 578,
            // color: const Color(0xFF181c33),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: Color(0xFF2C335E),
                  offset: Offset(-2.0, -2.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),//BoxShadow
              ],
            ),
            // backgroundColor: const Color(0xFF181c33),
            child: ListView.builder (

              padding: const EdgeInsets.only(top: 30, bottom: 10, left: 60, right: 10),
              itemCount: menuAdmin.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column (
                      children: [
                        Container (
                          width: 230,
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close_outlined, color: Colors.white),
                          ),
                        ),
                        ListTile (
                            title: Text(menuAdmin[index].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'CadillacSans',
                                  color: Colors.white,
                                  height: 1.7, //line-height : font-size
                                )
                            ),

                            leading: SvgPicture.asset(
                              'assets/images/' + icons[index],
                              semanticsLabel: 'Icon home',
                              height: 20.0,
                            ),

                            onTap: () {
                              // What happens after you tap the navigation item

                              setState(() {
                                mainWidget = pages[index];
                              });
                              Navigator.pop(context);
                              // Navigator.pushNamed(context, '/' + menuUser[index]);
                              Route route = MaterialPageRoute(builder: (context) => pages[index]);
                              Navigator.push(context, route);
                              //Navigator.pushNamed(context, '/news');
                              // Route route = MaterialPageRoute(builder: (context) => pages[index] );
                              // Navigator.push(context,route);
                            }
                        )
                      ]
                  );
                }

                return ListTile(
                    title: Text(menuAdmin[index].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'CadillacSans',
                          color: Colors.white,
                          height: 1.7, //line-height / font-size
                        )
                    ),

                    leading: SvgPicture.asset(
                      'assets/images/' + icons[index],
                      semanticsLabel: 'Icon home',
                      height: 20.0,
                    ),

                    onTap: () {
                      // What happens after you tap the navigation item

                      print('path');
                      print(menuAdmin[index]);

                      setState(() {
                        mainWidget = pages[index];
                      });
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, 'members', arguments: User);
                      // Route route = MaterialPageRoute(builder: (context) => Members());
                      Route route = MaterialPageRoute(builder: (context) => pages[index]);
                      Navigator.push(context, route);

                      // Navigator.pushNamed(context, menuUser[index]);



                    }
                );
              },
            )

        )
    );
  }
}

