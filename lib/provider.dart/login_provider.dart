// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../models/sign_up_model.dart';
import '../utills/snack_bar.dart';
import '../view_model/views/home_page/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SignUpModel sign_up_model = SignUpModel();
  //..login Method for user login
  loginMethod(BuildContext context) async {
    //..used to store data that needs to be accessed by the application
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //..used to join together different parts of a file path or
    // directory path into a single
    String databasePath = join(appDocDir.path, 'my_database.db');
    final databaseFactory = databaseFactoryIo;
    //..used to store data in a structured format
    final store = stringMapStoreFactory.store('sign_up_store');
    //.. used to create or open a database. Once a database is opened,
    //developers can read and write data
    final database = await databaseFactory.openDatabase(databasePath);
    print('check store is>>><< $store');
    //..check single record
    print('email .....${emailController.text}');
    final finder = Finder(
      filter: Filter.equals('email', emailController.text),
    );
    var records = await store.find(database, finder: finder);
    print('check finder is == $finder');
    log(' all records =$records');
    if (records.isNotEmpty) {
      sign_up_model = SignUpModel.fromJson(records.first.value);
      if (emailController.text == sign_up_model.email &&
          passwordController.text == sign_up_model.password) {
        SnackBarMessage().showSuccessSnackBar(
            message: 'Login Successfully', context: context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      email: emailController.text,
                    )));
      } else {
        SnackBarMessage()
            .showErrorSnackBar(message: 'Wrong credentials', context: context);
      }
    } else {
      SnackBarMessage()
          .showErrorSnackBar(message: 'User did not exists', context: context);
    }
  }
}
