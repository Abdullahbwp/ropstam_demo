import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:ropstam_test/models/car_model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uuid/uuid.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<CarModel> list_of_car_model = [];
  XFile? file;
  TextEditingController owner_name = TextEditingController();
  TextEditingController vehicle_name = TextEditingController();
  TextEditingController vehicle_color = TextEditingController();
//..Fetch all records if database exist
  Future getAllVehicleRecord({String? email, BuildContext? context}) async {
    //..used to store data that needs to be accessed by the application
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //..used to join together different parts of a file path or
    // directory path into a single
    String databasePath = path.join(appDocDir.path, 'my_database.db');
    final databaseFactory = databaseFactoryIo;
    //..used to store data in a structured format
    final store = stringMapStoreFactory.store('vehicle_store');
    //.. used to create or open a database. Once a database is opened,
    //developers can read and write data
    final database = await databaseFactory.openDatabase(databasePath);
    final query = Finder(
      filter: Filter.equals('email', email),
    );
    final snapshots = await store.find(database, finder: query);
    final data = snapshots.map((snapshot) => snapshot.value).toList();
    list_of_car_model.clear();
    for (var element in data) {
      list_of_car_model.add(CarModel.fromJson(element));
    }
    notifyListeners();
  }

  //..........................Add New Product................................//
  Future addProduct({String? email}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = path.join(appDocDir.path, 'my_database.db');
    final databaseFactory = databaseFactoryIo;
    final store = stringMapStoreFactory.store('vehicle_store');
    final database = await databaseFactory.openDatabase(databasePath);
    var uuid = const Uuid();
    CarModel model = CarModel(
        email: email,
        image: file!.path,
        ownerName: owner_name.text,
        vehicleColor: vehicle_color.text,
        id: uuid.v1(),
        vehicleName: vehicle_name.text);
    await database.transaction((txn) async {
      await store.add(txn, model.toJson());
    });
    notifyListeners();
  }
}
