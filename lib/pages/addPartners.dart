// import 'dart:html';

import 'dart:typed_data';

import 'package:cadillac/pages/partnersAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:cadillac/variables.dart';


import 'package:cadillac/widgets/titlePage.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../NavDrawerAdmin.dart';
import '../main.dart';
import '../models/partners.dart';
import 'data.dart';


class AddPartners extends StatefulWidget {
  const AddPartners({Key? key}) : super(key: key);


  @override
  State<AddPartners> createState() => _AddPartnersState();
}

class _AddPartnersState extends State<AddPartners> {
  late String encode64Partner;

  @override
  void initState() {
    super.initState();
    encode64Partner = '';
  }

  final _partnersKey = GlobalKey<FormBuilderState>();

  late dynamic partner;
  late String id = '1';
  late String partnerId = '111';
  late String partnerName = 'name';
  late List<dynamic> partnerImage;

  late String path;
  late String platform;
  late Uint8List? bytes;



  // final styleFormInput = const TextStyle(
  //   fontSize: 14.0,
  //   fontWeight: FontWeight.normal,
  //   fontFamily: 'CadillacSans',
  //   color: Colors.white,
  // );

  // final styleTitleFormInput = const TextStyle(
  //   fontSize: 14.0,
  //   fontWeight: FontWeight.normal,
  //   fontFamily: 'CadillacSans',
  //   color: Colors.white,
  //   height: 1.5, //line-height : font-size
  // );

  @override
  Widget build(BuildContext context) {
    platform = Provider.of<Data>(context).data['platform'].toString();
    print(platform);

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        routes: const {
          // '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          // '/shop': (context) => const Shop(),
          // '/partners': (context) => Partners(),
          // '/contacts': (context) => Contacts(),
        },
        home: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF181c33),
          //   shadowColor: Colors.transparent,
          //   elevation: 0.0,
          //   leading: Builder(
          //     builder: (BuildContext context) {
          //       return IconButton(
          //         icon: SvgPicture.asset('assets/images/burger.svg'),
          //         onPressed: () {
          //           Scaffold.of(context).openDrawer();
          //         },
          //         tooltip:
          //         MaterialLocalizations.of(context).openAppDrawerTooltip,
          //       );
          //     },
          //   ),
          // ),

          body: Center (
              child: Container (
                width: 284,
                margin: const EdgeInsets.only(top: 70),
                child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded (
                        child: SingleChildScrollView (
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(bottom: 40),
                                    child: const TitlePage(title: '???????????????? ????????????????'),
                                  ),

                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FormBuilder(
                                          key: _partnersKey,
                                          autovalidateMode: AutovalidateMode.always,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  //alignment: Alignment(-1,0),
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                    '???????????????? ????????????????'.toUpperCase(),
                                                    textAlign: TextAlign.left,
                                                    style: styleTitleFormInput,
                                                  ),
                                                ),
                                                Container(
                                                  width: 284,
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  child: FormBuilderTextField(
                                                      name: 'partnerName',
                                                      autofocus: true,
                                                      cursorWidth: 1.0,
                                                      cursorColor: Colors.white,
                                                      style: styleFormInput,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10))),
                                                        fillColor: Color(0XFF515569),
                                                        filled: true,
                                                        hintText: "???????????????? ????????????????",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      // onChanged: _onChanged,
                                                      onSaved: (value) => partnerName = value!,
                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // validator: FormBuilderValidators.compose([
                                                      //   // FormBuilderValidators.required(context),
                                                      //   // FormBuilderValidators.numeric(context),
                                                      //   // FormBuilderValidators.max(context, 70),
                                                      // ]),
                                                      autovalidateMode: AutovalidateMode.always,
                                                      validator:
                                                      FormBuilderValidators.compose([
                                                            (val) {
                                                          if (val == null) {
                                                            return '???????? partnersName ???? ?????????? ???????? ????????????';
                                                          } else if (val.length < 3) {
                                                            return '?????????????? 3 ??????????????';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ]),
                                                      keyboardType: TextInputType.text),
                                                ),
                                                FormBuilderFilePicker(
                                                  name: "partnerImage",
                                                  decoration:
                                                  InputDecoration(
                                                    fillColor:
                                                    Color(0xff515569),
                                                    iconColor: Colors.white,
                                                    contentPadding:
                                                    EdgeInsets.all(0),
                                                    border:
                                                    OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide.none,
                                                      //gapPadding: 40,
                                                    ),
                                                  ),
                                                  maxFiles: null,
                                                  previewImages: true,
                                                  onChanged: (val) => {},
                                                  selector: Column(
                                                      children: [
                                                        Stack(
                                                            alignment:
                                                            Alignment
                                                                .center,
                                                            children: [
                                                              Container(
                                                                //dding: EdgeInsets.only(bottom: 40),
                                                                width: 284,
                                                                height: 160,
                                                                decoration: const BoxDecoration(
                                                                    color: Color(
                                                                        0xFF515569),
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    borderRadius:
                                                                    BorderRadius.all(Radius.circular(10))),
                                                              ),
                                                              SvgPicture
                                                                  .asset(
                                                                'assets/images/load.svg',
                                                                semanticsLabel:
                                                                'Icon upload',
                                                                height:
                                                                18.0,
                                                              ),
                                                              Positioned(
                                                                bottom: 0,
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                    children: [
                                                                      SizedBox(
                                                                          height: 40),
                                                                      Text(
                                                                          '?????????????????? ????????',
                                                                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'CadillacSans', color: Colors.white, height: 1.4 //line-height : font-size
                                                                          ),
                                                                          textAlign: TextAlign.center),
                                                                      Icon(
                                                                        Icons.file_upload,
                                                                        semanticLabel:
                                                                        'Icon upload',
                                                                        size:
                                                                        18.0,
                                                                        color:
                                                                        Colors.white,
                                                                      )
                                                                    ]),
                                                              )
                                                            ]),
                                                      ]),
                                                  onFileLoading: (val) {
                                                    // print(val);
                                                  },
                                                  onSaved: (value) => {
                                                    print('value'),
                                                    print(value
                                                        .runtimeType),
                                                    partnerImage = value!,
                                                  }),

                                                Container(
                                                  width: 284,
                                                  margin: const EdgeInsets.only(top: 30, bottom: 45),
                                                  child: MaterialButton(
                                                    padding: const EdgeInsets.all(17),
                                                    color: const Color.fromARGB(255, 255, 255, 255),
                                                    // textColor: const Color(0xFF12141F),
                                                    child: Text(
                                                      "???????????????? ????????????????".toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 14, color: Color(0xFF12141F)),
                                                    ),

                                                    shape: const RoundedRectangleBorder(
                                                      side: BorderSide.none,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () async{

                                                      if (_partnersKey.currentState?.saveAndValidate() ??
                                                          false) {
                                                        confirmDialog(context);
                                                        debugPrint('Partner added');
                                                        if (platform == 'android' ||
                                                            platform == 'ios') {
                                                          print(platform);
                                                          final bytes = File(partnerImage[0].path).readAsBytesSync();
                                                          print(bytes);
                                                          print(bytes.runtimeType);
                                                          setState(() {
                                                            encode64Partner = base64.encode(bytes);
                                                          });
                                                          //var encode64 = base64.encode(bytes);
                                                          print(encode64Partner);


                                                        } else {
                                                          print(platform);
                                                          //late Uint8List bytes;
                                                          bytes = partnerImage[0].bytes;

                                                          setState(() {
                                                            encode64Partner = base64.encode(bytes!);
                                                          });
                                                        }


                                                        final partner = Partner(
                                                          id: id,
                                                          partnerId: partnerId,
                                                          partnerName: partnerName,
                                                          path: encode64Partner,

                                                        );

                                                        addPartner(partner);

                                                        Navigator
                                                            .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    const PartnersAdmin()
                                                            ));
                                                      } else {
                                                        debugPrint('Error');
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ]
                                          ),

                                        )
                                      ]
                                  ),
                                ]
                            )
                        ),
                      ),
                    ]
                ),
              )
          ),
          drawer: const NavDrawerAdmin(),

        )
    );
  }

  getpathImage(url) async {
    return url;
  }

  addPartner(Partner partner) async {
    dynamic partnerName = partner.partnerName;
    dynamic path = partner.path;


    // String apiurl = "http://localhost/test/mail.php";
    String apiurl = baseUrl + "/test/add_partner.php";

    var response = await http.post(Uri.parse(apiurl), body: {
      'partnerName': partnerName,
      'path': path,

    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      print('partner added');
      // var uuid = const Uuid();
      // id = uuid.v1();

      print(response.statusCode);
      print(response.body);

      final partnerJson = json.decode(response.body);

      print('partnerJson');
      // print(userJson);

      return Partner.fromJson(partnerJson);
      // return User.fromJson(jsonDecode(response.body));
      // setState(() {
      //   showprogress = false; //don't show progress indicator
      //   error = true;
      //   errormsg = jsondata["message"];
      // });

    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}


Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('?????????????????????? ?????? ??????????'),
        content: Text('???????????????? ?????????????????'.toUpperCase(),
          textAlign: TextAlign.center,
          style: styleTextAlertDialog,
        ),
        actions: <Widget>[
          Container (
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: const Color(0xFFE4E6FF),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),),
                      child: Text(
                        '????'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: styleTextAlertDialog,
                      ),
                      onPressed: () {
                        var partnerId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PartnersAdmin()));
                      },
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: const Color(0xFFE4E6FF),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),),
                      child: Text(
                        '??????'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: styleTextAlertDialog,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]
              )
          )


        ],
      );
    },
  );
}

void _onChanged() {}
