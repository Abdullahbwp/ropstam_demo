// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:ropstam_test/models/sign_up_model.dart';
import 'package:ropstam_test/utills/snack_bar.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../view_model/views/login_page/login_screen.dart';

class SignUpProvider extends ChangeNotifier {
  //.......This is all TextFromField use ti get the string to store in the db..........//
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordCotroller =
      TextEditingController();
  //..........Make a sign up method for create an account......//
  Future signUpMethod(BuildContext context) async {
    //..used to store data that needs to be accessed by the application
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //..used to join together different parts of a file path or
    // directory path into a single
    String databasePath = path.join(appDocDir.path, 'my_database.db');
    final databaseFactory = databaseFactoryIo;
    //..used to store data in a structured format
    final store = stringMapStoreFactory.store('sign_up_store');
    //.. used to create or open a database. Once a database is opened,
    //developers can read and write data
    final database = await databaseFactory.openDatabase(databasePath);
    SignUpModel model = SignUpModel(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: confirmPasswordCotroller.text);
    //..This ensures that the database remains in a consistent state,
    //even if an error occurs during the transaction.
    await database.transaction((txn) async {
      await store.add(txn, model.toJson());
    });
    SnackBarMessage()
        .showSuccessSnackBar(message: 'Sign Up Successfully', context: context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      ModalRoute.withName('/'),
    );
  }
}
