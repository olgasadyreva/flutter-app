
import 'dart:typed_data';

import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
// import 'generated/l10n.dart';

// import 'package:hive/hive.dart';
// import 'package:requests/requests.dart';

// import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

// import 'package:image/image.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


import 'package:url_launcher/url_launcher.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/common/theme_helper.dart';

import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/home.dart';

import 'package:cadillac/models/users.dart';

import 'package:cadillac/main.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import 'data.dart';

enum ImageSourceType { gallery, camera }

var uuid = '';

class Edit extends StatefulWidget {
  Edit({Key? key} ) : super(key: key);

  late String path;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late String encode64;

  dynamic user;
  dynamic findedUser;

  @override
  initState()  {
    print('init state edit');
    super.initState();
    uuid = '';
    encode64 = '';
    //uuid = userId;


    //var path = "assets/images/avatar.png";
    // setState(() {
    //   _items = data["items"];
    // });
  }

  //XFile? file;
  //final String userUuId;
  //late final dynamic currentUser;
  final _formKey = GlobalKey<FormBuilderState>();


  late dynamic userId;
  late dynamic username;
  late dynamic email = 'test@test';
  late dynamic phone = '5555';
  late dynamic password;
  late dynamic login = 'test@test';
  late dynamic birthday;
  late dynamic type;
  late dynamic carname;
  late String path;
  late dynamic car1;
  late dynamic car2;
  late dynamic car3;

  late List<dynamic> photo;
  late List<dynamic> cars;

  late String platform;
  late Uint8List? bytes;
  late Uint8List? bytesCar1;
  late Uint8List? bytesCar2;
  late Uint8List? bytesCar3;

  // var box = Hive.box<User>(HiveBoxes.user);
  final List<String>? _allowedExtensions = ['png', 'jpg'];

  //User newUser = User();

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '+7 ___-___-__-__',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  var maskFormatterDate = MaskTextInputFormatter(
      mask: '__.__.____',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  final _emailController = TextEditingController();

  //dynamic id;


  @override
  Widget build(BuildContext context) {
    dynamic user;
    print('load edit account');
    userId = Provider.of<Data>(context).data['userId'].toString();
    platform = Provider.of<Data>(context).data['platform'].toString();
    print(platform);
    print(userId);

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('en', ''),
        //   // ????????????????????, ?????? ???????? ???????????? Locale ( 'es' , '' ), // ??????????????????, ?????? ???????? ???????????? ],
        // ],



        routes: {
          '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          //  '/members': (context) => Members(),
          //  '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),

        },
        home: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF181c33),
          //   shadowColor: Colors.transparent,
          // ),

          body: Center (
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //ListView(
                children: [
                  Container(
                    width: 284,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 47),
                  ),
                  Expanded(
                      child: SingleChildScrollView(

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 284,
                                  margin: const EdgeInsets.only(bottom: 58),
                                  child: const TitlePage(title: '?????????????????? ????????????'),
                                ),

                                Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(bottom: 56),
                                    child:

                                    FormBuilder(
                                        key: _formKey,
                                        autovalidateMode: AutovalidateMode.always,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 284,
                                                margin: const EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  '?????? ??????????'.toUpperCase(),
                                                  textAlign: TextAlign.left,
                                                  style: styleTitleFormInput,
                                                ),
                                              ),
                                              FormBuilderTextField(
                                                  name: 'login',
                                                  // readOnly: true,
                                                  // enabled: false,
                                                  // initialValue: '${currentUser.email}',
                                                  autofocus: true,
                                                  cursorWidth: 1.0,
                                                  cursorColor: Colors.white,
                                                  style: styleFormInput,
                                                  // decoration: ThemeHelper().textInputDecoration('', '?????????????? ?????? ??????????', ''),
                                                  decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.all(16),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                    ),

                                                    fillColor: Color(0XFF515569),
                                                    filled: true,
                                                    hintText: "?????????????? ?????? ?????????? (email)",
                                                    hintStyle: TextStyle(
                                                      color: Colors.white60,
                                                    ),
                                                  ),
                                                  // controller: _emailController,
                                                  // onChanged: _onChanged,
                                                  // valueTransformer: (text) => num.tryParse(text),
                                                  autovalidateMode: AutovalidateMode.always,
                                                  // validator:
                                                  //   FormBuilderValidators.compose([
                                                  //     FormBuilderValidators.required(context),
                                                  //     // FormBuilderValidators.numeric(),
                                                  //     FormBuilderValidators.max(context, 10, errorText: '???????????????? 20 ????????????????'),
                                                  //     FormBuilderValidators.min(context, 8, errorText: '?????????????? 8 ??????????????'),
                                                  //   ]),
                                                  keyboardType: TextInputType.emailAddress,
                                                  onSaved: (value) => login = value!),
                                              Container(
                                                width: 284,
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Text(
                                                  '?????? ????????????'.toUpperCase(),
                                                  textAlign: TextAlign.left,
                                                  style: styleTitleFormInput,
                                                ),
                                              ),
                                              FormBuilderTextField(
                                                  name: 'password',
                                                  cursorWidth: 1.0,
                                                  autofocus: true,
                                                  cursorColor: Colors.white,
                                                  style: styleFormInput,
                                                  obscureText: true,
                                                  // decoration: ThemeHelper().textInputDecoration('?????????????? ?????? ????????????', '?????????????? ?????? ????????????', ''),
                                                  decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.all(16),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                    ),

                                                    fillColor: Color(0XFF515569),
                                                    filled: true,
                                                    hintText: "?????????????? ?????? password",
                                                    hintStyle: TextStyle(
                                                      color: Colors.white60,
                                                    ),
                                                  ),
                                                  // onChanged: _onChanged,
                                                  // valueTransformer: (text) => num.tryParse(text),
                                                  autovalidateMode: AutovalidateMode.always,
                                                  validator: FormBuilderValidators.compose([
                                                    // FormBuilderValidators.required(context, errorText: '???????????????????????? ????????'),
                                                        (val) {
                                                      if (val == null) {
                                                        return '???????? password ???? ?????????? ???????? ????????????';
                                                      } else if (val.length < 8) {
                                                        // return 'Invalid email address';
                                                        return '?????????????? 8 ????????????????';
                                                      } else {
                                                        return null;
                                                      }
                                                    }

                                                    // FormBuilderValidators.max(context, 20),
                                                    // FormBuilderValidators.email(context),
                                                  ]),
                                                  // validator:
                                                  // FormBuilderValidators.compose([
                                                  //   FormBuilderValidators.required(context, errorText: '???????? ?????????????????????? ?????? ????????????????????'),
                                                  //   // FormBuilderValidators.numeric(context, errorText: '?????????? ?????????????? ???????????? ??????????'),
                                                  //   FormBuilderValidators.min(context, 8, errorText: '?????????????? 8 ????????????????'),
                                                  // ]),
                                                  // keyboardType: TextInputType.visiblePassword,
                                                  onSaved: (value) => password = value!
                                              ),

                                              Container(
                                                width: 284,
                                                margin: const EdgeInsets.only(top: 30, bottom: 10),
                                              ),
                                              SizedBox(
                                                      width: 284,

                                                      child: Column(
                                                          children: [

                                                            Container(
                                                              width: 284,
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  top: 10, bottom: 10),
                                                              child: Text(
                                                                '???????? ????????'
                                                                    .toUpperCase(),
                                                                textAlign: TextAlign
                                                                    .left,
                                                                style: styleTitleFormInput,
                                                              ),
                                                            ),

                                                            Container(
                                                              width: 130,
                                                              decoration: const BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          48))),
                                                              child:
                                                              FormBuilderFilePicker(
                                                                  name: "photo",
                                                                  decoration:
                                                                  InputDecoration(
                                                                    fillColor: Color(
                                                                        0xff515569),
                                                                    iconColor:
                                                                    Colors.white,
                                                                    contentPadding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                    border:
                                                                    OutlineInputBorder(
                                                                      borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                      //gapPadding: 40,
                                                                    ),
                                                                  ),
                                                                  maxFiles: null,
                                                                  previewImages: true,
                                                                  onChanged: (val) =>
                                                                  {},
                                                                  selector: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Stack(
                                                                            alignment:
                                                                            Alignment
                                                                                .center,
                                                                            children: [
                                                                              Container(
                                                                                alignment:
                                                                                Alignment.center,
                                                                                width:
                                                                                96,
                                                                                height:
                                                                                96,
                                                                                decoration: const BoxDecoration(
                                                                                    color: Color(0xFF515569),
                                                                                    borderRadius: BorderRadius.all(Radius.circular(48))),
                                                                              ),
                                                                              SvgPicture
                                                                                  .asset(
                                                                                'assets/images/image.svg',
                                                                                semanticsLabel:
                                                                                'Icon upload',
                                                                                height:
                                                                                18.0,
                                                                              ),
                                                                            ]),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                            children: [
                                                                              SizedBox(
                                                                                  height:
                                                                                  40),
                                                                              Text(
                                                                                  '?????????????????? ????????',
                                                                                  style: TextStyle(
                                                                                      fontSize: 14.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontFamily: 'CadillacSans',
                                                                                      color: Color(0xFF515569),
                                                                                      height: 1.4 //line-height : font-size
                                                                                  ),
                                                                                  textAlign: TextAlign.center),
                                                                              Icon(
                                                                                  Icons
                                                                                      .file_upload,
                                                                                  semanticLabel:
                                                                                  'Icon upload',
                                                                                  size:
                                                                                  18.0,
                                                                                  color:
                                                                                  Color(0xFF515569)),
                                                                              //)
                                                                            ]),
                                                                      ]),
                                                                  onFileLoading:
                                                                      (val) {
                                                                    // print(val);
                                                                  },
                                                                  onSaved: (value) =>
                                                                  {
                                                                    print(
                                                                        'value'),
                                                                    print(value
                                                                        .runtimeType),
                                                                    photo =
                                                                    value!,
                                                                  }),
                                                            ),


                                                            Container(
                                                              alignment: Alignment
                                                                  .topLeft,
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  top: 10, bottom: 10),
                                                              child: Text(
                                                                '???????? ?????? ?? ??????????????'
                                                                    .toUpperCase(),
                                                                textAlign: TextAlign
                                                                    .left,
                                                                style: styleTitleFormInput,
                                                              ),
                                                            ),
                                                            FormBuilderTextField(
                                                                name: 'username',
                                                                autofocus: true,
                                                                cursorWidth: 1.0,
                                                                cursorColor: Colors.white,
                                                                style: styleFormInput,
                                                                // decoration: ThemeHelper()
                                                                //     .textInputDecoration(
                                                                //     '', '?????????? ??????????????',
                                                                //     '?????????????? ???????? ?????? ?? ??????????????')
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.all(16),
                                                                  border: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                                  ),

                                                                  fillColor: Color(0XFF515569),
                                                                  filled: true,
                                                                  hintText: "?????????????? ?????? ??????",
                                                                  hintStyle: TextStyle(
                                                                    color: Colors.white60,
                                                                  ),
                                                                ),
                                                                onSaved: (value) => username = value!,
                                                                // onChanged: _onChanged,
                                                                // valueTransformer: (text) => num.tryParse(text),
                                                                autovalidateMode: AutovalidateMode.always,
                                                                validator: FormBuilderValidators.compose([
                                                                      (val) {
                                                                    if (val == null) {
                                                                      return '???????? name ???? ?????????? ???????? ????????????';
                                                                    } else if (val.length < 3) {
                                                                      // return 'Invalid email address';
                                                                      return '?????????????? 3 ??????????????';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  }
                                                                  //   FormBuilderValidators.required(context, errorText: '???????? ?????????????????????? ?????? ????????????????????'),
                                                                  //   FormBuilderValidators.min(context, 3, errorText: '?????????????? 3 ??????????????'),
                                                                  //   FormBuilderValidators.max(context, 20, errorText: '???????????????? 20 ????????????????'),
                                                                ]),
                                                                keyboardType: TextInputType
                                                                    .text),
                                                            Container(
                                                              alignment: Alignment
                                                                  .topLeft,
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  top: 10, bottom: 10),
                                                              child: Text(
                                                                '???????? ???????? ????????????????'
                                                                    .toUpperCase(),
                                                                textAlign: TextAlign
                                                                    .left,
                                                                style: styleTitleFormInput,
                                                              ),
                                                            ),
                                                            FormBuilderTextField(
                                                              name: 'birthday',
                                                              cursorWidth: 1.0,
                                                              cursorColor: Colors.white,
                                                              style: styleFormInput,
                                                              inputFormatters: [
                                                                maskFormatterDate
                                                              ],
                                                              keyboardType: TextInputType
                                                                  .number,
                                                              // decoration: ThemeHelper().textInputDecoration('', '__.__.____','?????????????? ???????? ???????? ????????????????'),
                                                              decoration: const InputDecoration(
                                                                contentPadding: EdgeInsets.all(16),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide.none,
                                                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                                                ),

                                                                fillColor: Color(0XFF515569),
                                                                filled: true,
                                                                hintText: "__.__.____",
                                                                hintStyle: TextStyle(
                                                                  color: Colors.white60,
                                                                ),
                                                              ),
                                                              onSaved: (value) => birthday = value!,
                                                              // onChanged: _onChanged,
                                                              // valueTransformer: (text) => num.tryParse(text),
                                                              // autovalidateMode: AutovalidateMode.always,
                                                              // validator: FormBuilderValidators.compose([
                                                              //   FormBuilderValidators.dateString(context, errorText: '???? ?????????? ???? ????????'),
                                                              //   FormBuilderValidators.required(context, errorText: '???????? ?????????????????????? ?????? ????????????????????'),
                                                              //   FormBuilderValidators.numeric(context, errorText: '?????????? ?????????????? ???????????? ??????????'),
                                                              //   FormBuilderValidators.max(context, 8, errorText: '???????????????? 8 ????????'),
                                                              // ]),

                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .topLeft,
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  top: 10, bottom: 10),
                                                              child: Text(
                                                                '?????? ?????????? ????????????????'
                                                                    .toUpperCase(),
                                                                textAlign: TextAlign
                                                                    .left,
                                                                style: styleTitleFormInput,
                                                              ),
                                                            ),


                                                            FormBuilderTextField(
                                                                name: 'phone2',
                                                                // readOnly: true,
                                                                // enabled: false,
                                                                // initialValue: '${currentUser.phone}',

                                                                //controller: _phoneController,
                                                                cursorWidth: 1.0,
                                                                cursorColor: Colors.white,
                                                                style: styleFormInput,
                                                                inputFormatters: [
                                                                  maskFormatterPhone
                                                                ],
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets
                                                                      .all(16),
                                                                  border: OutlineInputBorder(
                                                                      borderSide: BorderSide
                                                                          .none,
                                                                      borderRadius: BorderRadius
                                                                          .all(
                                                                          Radius.circular(10))
                                                                  ),

                                                                  fillColor: Color(
                                                                      0XFF515569),
                                                                  filled: true,
                                                                  hintText: "+7 ___-___-__-__",
                                                                  hintStyle: TextStyle(
                                                                    color: Colors.white60,
                                                                  ),
                                                                ),
                                                                // onSaved: (value) =>
                                                                // newUser.phone = value!,
                                                                // onChanged: _onChanged,
                                                                // valueTransformer: (text) => num.tryParse(text),
                                                                // autovalidateMode: AutovalidateMode.always,
                                                                // validator: FormBuilderValidators.compose([
                                                                //   FormBuilderValidators.required(context, errorText: '???????? ?????????????????????? ?????? ????????????????????'),
                                                                //   FormBuilderValidators.numeric(context, errorText: '?????????? ?????????????? ???????????? ??????????'),
                                                                //   FormBuilderValidators.max(context, 10, errorText: '???????????????? 10 ????????'),
                                                                // ]),
                                                                keyboardType: TextInputType.text
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .topLeft,
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  top: 10, bottom: 10),
                                                              child: Text(
                                                                '???????? ????????????????????'
                                                                    .toUpperCase(),
                                                                textAlign: TextAlign
                                                                    .left,
                                                                style: styleTitleFormInput,
                                                              ),
                                                            ),
                                                            FormBuilderTextField(
                                                                name: 'carname',
                                                                cursorWidth: 1.0,
                                                                cursorColor: Colors
                                                                    .white,
                                                                style: styleFormInput,
                                                                // decoration: ThemeHelper()
                                                                //     .textInputDecoration(
                                                                //     '',
                                                                //     '?????????????? ???????????????? ????????????????????',
                                                                //     ''),
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.all(16),
                                                                  border: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                                  ),

                                                                  fillColor: Color(0XFF515569),
                                                                  filled: true,
                                                                  hintText: "?????????????? ???????????????? ????????????????????",
                                                                  hintStyle: TextStyle(
                                                                    color: Colors.white60,
                                                                  ),
                                                                ),
                                                                onSaved: (value) => carname = value!,
                                                                // onChanged: _onChanged,
                                                                // valueTransformer: (text) => num.tryParse(text),
                                                                //
                                                                keyboardType: TextInputType.text
                                                            ),

                                                            Container(
                                                              width: 284,
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  top: 10, bottom: 10),
                                                              child: Text(
                                                                '?????????????????? 3 ???????? ???????????? cadillac'
                                                                    .toUpperCase(),
                                                                textAlign: TextAlign
                                                                    .left,
                                                                style: styleTitleFormInput,
                                                              ),
                                                            ),

                                                            //uploadImage(maxImages: 3),
                                                            FormBuilderFilePicker(
                                                                name: "cars",
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
                                                                  cars = value!,
                                                                }),

                                                            Container(
                                                                width: 284,
                                                                margin: const EdgeInsets
                                                                    .only(top: 30 ,
                                                                    bottom: 45),
                                                                child: MaterialButton(
                                                                  padding: const EdgeInsets
                                                                      .all(17),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255, 255, 255,
                                                                      255),
                                                                  // textColor: const Color(0xFF12141F),
                                                                  child: Text(
                                                                    "??????????????????"
                                                                        .toUpperCase(),
                                                                    style: const TextStyle(
                                                                        fontSize: 14,
                                                                        color: Color(
                                                                            0xFF12141F)),
                                                                  ),

                                                                  shape: const RoundedRectangleBorder(
                                                                    side: BorderSide
                                                                        .none,
                                                                    borderRadius: BorderRadius
                                                                        .all(
                                                                      Radius.circular(
                                                                          10),
                                                                    ),
                                                                  ),
                                                                  onPressed: () async {
                                                                    confirmDialog(context);
                                                                    if (_formKey
                                                                        .currentState
                                                                        ?.saveAndValidate() ??
                                                                        false) {
                                                                      // if (true) {
                                                                      //   // Either invalidate using Form Key
                                                                      //   _formKey
                                                                      //       .currentState
                                                                      //       ?.invalidateField(
                                                                      //       name: 'email',
                                                                      //       errorText: 'Email already taken.');
                                                                      //   // OR invalidate using Field Key
                                                                      //   // _emailFieldKey.currentState?.invalidate('Email already taken.');
                                                                      // }

                                                                      debugPrint('Valid success edit');
                                                                      print(photo);
                                                                      if (platform == 'android' ||
                                                                          platform == 'ios') {
                                                                        print(platform);
                                                                        final bytes = File(photo[0].path).readAsBytesSync();
                                                                        print(bytes);
                                                                        print(bytes.runtimeType);
                                                                        setState(() {
                                                                          encode64 = base64.encode(bytes);
                                                                        });
                                                                        //var encode64 = base64.encode(bytes);
                                                                        //print(encode64);
                                                                        print('cars.length');
                                                                        print(cars.length);
                                                                        if (cars.length ==  2) {
                                                                          if (cars[0].path != null) {
                                                                            final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                                            car1 = base64.encode(bytesCar1);
                                                                          } else {
                                                                            car1 = '';
                                                                          }
                                                                          if (cars[1].path != null) {
                                                                            final bytesCar2 = File(cars[1].path).readAsBytesSync();
                                                                            car2 = base64.encode(bytesCar2);
                                                                          } else {
                                                                            car2 = '';
                                                                          }
                                                                          car3 = '';
                                                                        } else if (cars.length == 3) {
                                                                          if (cars[0].path != null) {
                                                                            final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                                            car1 = base64.encode(bytesCar1);
                                                                          } else {
                                                                            car1 = '';
                                                                          }
                                                                          if (cars[1].path != null) {
                                                                            final bytesCar2 = File(cars[1].path).readAsBytesSync();
                                                                            car2 = base64.encode(bytesCar2);
                                                                          } else {
                                                                            car2 = '';
                                                                          }
                                                                          if (cars[2].path != null) {
                                                                            final bytesCar3 = File(cars[2].path).readAsBytesSync();
                                                                            car3 = base64.encode(bytesCar3);
                                                                          } else {
                                                                            car3 = '';
                                                                          }
                                                                        } else {
                                                                          final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                                          car1 = base64.encode(bytesCar1);
                                                                          car2 = '';
                                                                          car3 = '';
                                                                        }
                                                                      } else {
                                                                        print(platform);
                                                                        //late Uint8List bytes;
                                                                        bytes = photo[0].bytes;
                                                                        print('cars.length');
                                                                        print(cars.length);
                                                                        if (cars.length ==  2) {
                                                                          if (cars[0].bytes != null) {
                                                                            final bytesCar1 = cars[0].bytes;
                                                                            car1 = base64.encode(bytesCar1!);
                                                                          } else {
                                                                            car1 = '';
                                                                          }
                                                                          if (cars[1].bytes != null) {
                                                                            final bytesCar2 = cars[1].bytes;
                                                                            car2 = base64.encode(bytesCar2!);
                                                                          } else {
                                                                            car2 = '';
                                                                          }
                                                                          car3 = '';
                                                                        } else if (cars.length == 3) {
                                                                          if (cars[0].bytes != null) {
                                                                            final bytesCar1 = cars[0].bytes;
                                                                            car1 = base64.encode(bytesCar1!);
                                                                          } else {
                                                                            car1 = '';
                                                                          }
                                                                          if (cars[1].bytes != null) {
                                                                            final bytesCar2 = cars[1].bytes;
                                                                            car2 = base64.encode(bytesCar2);
                                                                          } else {
                                                                            car2 = '';
                                                                          }
                                                                          if (cars[2].bytes != null) {
                                                                            final bytesCar3 = cars[2].bytes;
                                                                            car3 = base64.encode(bytesCar3);
                                                                          } else {
                                                                            car3 = '';
                                                                          }
                                                                        } else {
                                                                          final bytesCar1 = cars[0].bytes;
                                                                          car1 = base64.encode(bytesCar1);
                                                                          car2 = '';
                                                                          car3 = '';
                                                                        }
                                                                        // bytesCar1 = cars[0].bytes;
                                                                        // bytesCar2 = cars[1].bytes;
                                                                        // bytesCar3 = cars[2].bytes;
                                                                        // print(bytes);
                                                                        // print(bytes.runtimeType);
                                                                        //var encode64 = base64.encode(bytes!);
                                                                        setState(() {
                                                                          encode64 = base64.encode(bytes!);
                                                                        });
                                                                        // print('encode64');
                                                                        // car1 = base64.encode(bytesCar1!);
                                                                        // car2 = base64.encode(bytesCar2!);
                                                                        // car3 = base64.encode(bytesCar3!);
                                                                      }



                                                                      print(_formKey
                                                                          .currentState?.fields.values
                                                                      );
                                                                      // setState(() {
                                                                      //   path: photo[0].path;
                                                                      // });
                                                                      //photo =new ApiImage();
                                                                      //final user = User(email: email, phone :phone);
                                                                      dynamic currentUser = User(
                                                                        id: '1',
                                                                        userId: userId,
                                                                        login: login,
                                                                        password: password,
                                                                        //photo: photo,
                                                                        username: username,
                                                                        birthday: birthday,
                                                                        carname: carname,
                                                                        phone: phone,
                                                                        email: email,
                                                                        path: encode64,
                                                                        car1: car1,
                                                                        car2: car2,
                                                                        car3: car3,

                                                                      );
                                                                      //currentUser = editUser(user);
                                                                      findedUser = await getUserbyEmail(currentUser);

                                                                      user = await editUser(currentUser);
                                                                      print('after editUser');
                                                                      print('user success');

                                                                      dynamic id = uuid;
                                                                      print("currentUser: ${currentUser.userId}");
                                                                      userId = uuid;

                                                                      // await contactsBox.put(userUuId, currentUser);


                                                                      debugPrint(_formKey
                                                                          .currentState
                                                                          ?.value
                                                                          .toString());

                                                                      // Navigator
                                                                      //     .pushReplacement(
                                                                      //     context,
                                                                      //     MaterialPageRoute(
                                                                      //         builder: (
                                                                      //             context) =>
                                                                      //             Account())
                                                                      // );

                                                                    } else {
                                                                      debugPrint(
                                                                          'Invalid');
                                                                    }

                                                                    // Navigator
                                                                    //     .pushReplacement(
                                                                    //     context,
                                                                    //     MaterialPageRoute(
                                                                    //         builder: (
                                                                    //             context) =>
                                                                    //             Account())
                                                                    // );

                                                                  },
                                                                )
                                                            ),

                                                          ]
                                                      )
                                                  )

                                            ]
                                        )
                                    )
                                )
                              ]
                          )
                      )
                  ),


                ]
            ),
          ),






          drawer: const NavDrawer(),
        )
    );
  }

  getpathImage(url) async {
    return url;
  }

  getUserbyEmail(User user) async {

    print('func getUserbyEmail');
    print(user.username);
    //print('user.userId');
    dynamic login = user.login;
    dynamic password  = user.password;
    // dynamic photo = user.photo;
    dynamic username = user.username;
    dynamic birthday = user.birthday;
    dynamic carname = user.carname;
    dynamic path = user.path;
    dynamic car1, car2, car3;
    if (user.car1 != 'null') car1 = user.car1;
    if (user.car2 != 'null') car2 = user.car2;
    if (user.car3 != 'null') car3 = user.car3;

    String apiurl = baseUrl + "/test/get_user_by_email.php";
    // String apiurl = "http://localhost/test/edit.php";
    var response = await http.post(Uri.parse(apiurl), body: {
      'login': login,
      'username': username,
      'birthday': birthday,
      'carname': carname,
      'path': path,
      'car1': car1 != '' ? car1 : '',
      'car2': car2 != '' ? car2 : '',
      'car3': car3 != '' ? car3 : '',
      'password': password
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });
    if (response.statusCode == 200) {
      print('success getUserbyEmail');

      //print(json.decode(response.body));
      //return response.body; //?????? ??????????????????

      final userJson = json.decode(response.body);
      // //final userJson = response.body;
      // print('userJson success');
      // print(userJson);
      var data = User.fromJson(userJson);

      Provider.of<Data>(context, listen: false).updateUserId(data.userId);
      print('data.userId');
      // print(data.userId);
      // setState(() {
      //   uuid = data.userId;
      // });
      // if (mounted && userId != null) {
      //   setState(() {
      //     uuid = data.userId;
      //   });
      // }
      //getCookie(data.userId);
      return(data);
      //return User.fromJson(userJson);
//return response.body;
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

  // Future<String> editUser() async {
  editUser(User user) async {
    print('func editUser edit');
    // print(user.login);
    dynamic login = user.login;
    dynamic password  = user.password;
    // dynamic photo = user.photo;
    dynamic username = user.username;
    dynamic birthday = user.birthday;
    dynamic carname = user.carname;
    dynamic path = user.path;
    dynamic car1, car2, car3;
    if(user.car1 != 'null') car1 = user.car1;
    if(user.car2 != 'null') car2 = user.car2;
    if(user.car3 != 'null') car3 = user.car3;
    //(car1);
    //print('uuid: $uuid'); //null
    //print(user.userId); //null


    String apiurl = baseUrl + "/test/edit.php";
    // String apiurl = "http://localhost/test/edit.php";
    var response = await http.post(Uri.parse(apiurl), body:{
      'userId': Provider.of<Data>(context, listen: false).data['userId'].toString(),
      'login': login,
      'username': username,
      'birthday': birthday,
      'carname': carname,
      'path': path,
      'car1': car1 != '' ? car1 : '',
      'car2': car2 != '' ? car2 : '',
      'car3': car3 != '' ? car3 : '',
      'password': password
    },
        headers: {
      'Accept':'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    // var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
    //   "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"}, body:{'phone': phone,'email': email});
    // var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
    //       "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});
    print('after response edit');
    // print("response.body success: ${jsonDecode(response.body)}");  SyntaxError: Unexpected end of JSON input


    // print(User.fromJson(jsonDecode(response.body)));
    if(response.statusCode == 200){
      print('success edit');
      // var uuid = const Uuid();
      // id = uuid.v1();
      print(response.body);
      //return response.body;
      final userJson = json.decode(response.body);
      //final userJson = response.body;
      print('userJson edit');
      print(userJson);

      var data = User.fromJson(userJson);
      //print('data.userId');
      //print(data.userId);
      // setState(() {
      //   uuid = data.userId;
      // });
      //return User.fromJson(userJson);
      return data;
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



void _onChanged() {}

final Uri _url = Uri.parse('https://www.google.com');

void _launchURL() async {

  if (!await launchUrl(_url)) throw 'Could not launch $_url';
  // const url = 'https://www.google.com';  //???????? ????????????
  // if (await canLaunchUrl(url)) {  //?????????????????? ?????????????? ???????????????? ???? ????????????????????
  //   await launchUrl(url, forceWebView: true);   //true ???????? ?????????????????? ?? ????????????????????, false ?????????????????? ?? ????????????????
  // } else {
  //   throw 'Could not launch $url';
}

Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('?????????????????????? ?????? ??????????'),
        content: Text('???????????????? ?????????????'.toUpperCase(),
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
                        var userId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Account()));
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
                        Navigator
                            .pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) =>
                                    Account())
                        );
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

