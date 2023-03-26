// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:ropstam_test/models/car_model.dart';
import 'package:ropstam_test/utills/app_colors.dart';
import 'package:ropstam_test/utills/custom_text.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uuid/uuid.dart';

import '../../../provider.dart/home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CarModel> list_of_car_model = [];
  XFile? file;

  @override
  void initState() {
    //.Find object of provider
    final provider = Provider.of<HomeScreenProvider>(context, listen: false);
    //..Get all records if available
    provider.getAllVehicleRecord(email: widget.email, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //..Find object of home provider to fetch all data which is available in home model
    final homeProvider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0.0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.transparent),
          title: const CustomText(
            text: "Home Screen",
            color: AppColors.blackColor,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            //..display all items from db
            SizedBox(
              child: ListView.builder(
                itemCount: homeProvider.list_of_car_model.length,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10.sp),
                    height: 100.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: AppColors.blackColor.withOpacity(0.12))
                        ],
                        borderRadius: BorderRadius.circular(8.sp)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100.h,
                              width: 90.w,
                              child: Image.file(
                                File(homeProvider
                                    .list_of_car_model[index].image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 106.w,
                                      child: CustomText(
                                        text: "Owner Name:",
                                        size: 14.sp,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomText(
                                      text: homeProvider
                                              .list_of_car_model[index]
                                              .ownerName ??
                                          "No Data",
                                      size: 14.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 106.w,
                                      child: CustomText(
                                        text: "Vehicle Name:",
                                        size: 14.sp,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomText(
                                      text: homeProvider
                                              .list_of_car_model[index]
                                              .vehicleName ??
                                          "No Data",
                                      size: 14.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 106.w,
                                      child: CustomText(
                                        text: "Vehicle Color:",
                                        size: 14.sp,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomText(
                                      text: homeProvider
                                              .list_of_car_model[index]
                                              .vehicleColor ??
                                          "No Data",
                                      size: 14.sp,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                                value: 'Edit',
                                child: CustomText(
                                  text: "Edit",
                                )),
                            const PopupMenuItem<String>(
                                value: 'Delete',
                                child: CustomText(
                                  text: "Delete",
                                )),
                          ],
                          onSelected: (String value) async {
                            if (value == 'Delete') {
                              print(
                                  'in delete id...${homeProvider.list_of_car_model[index].id}');
                              Directory appDocDir =
                                  await getApplicationDocumentsDirectory();
                              String databasePath =
                                  path.join(appDocDir.path, 'my_database.db');
                              final databaseFactory = databaseFactoryIo;
                              final store =
                                  stringMapStoreFactory.store('vehicle_store');
                              final database = await databaseFactory
                                  .openDatabase(databasePath);
                              //..Find the id which one you want to delete
                              await store.delete(database,
                                  finder: Finder(
                                    filter: Filter.equals('id',
                                        '${homeProvider.list_of_car_model[index].id}'),
                                  ));
                              //..deleted of selected id recod from db
                              homeProvider.getAllVehicleRecord(
                                  email: widget.email, context: context);
                            } else {
                              homeProvider.file = XFile(
                                  '${homeProvider.list_of_car_model[index].image}');
                              homeProvider.owner_name.text =
                                  '${homeProvider.list_of_car_model[index].ownerName}';
                              homeProvider.vehicle_name.text =
                                  '${homeProvider.list_of_car_model[index].vehicleName}';
                              homeProvider.vehicle_color.text =
                                  '${homeProvider.list_of_car_model[index].vehicleColor}';
                              //..show dialog to add new product
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: StatefulBuilder(
                                            builder: (context, setState) {
                                          return Container(
                                              height: 420.h,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 7.h),
                                                  CustomText(
                                                    text: "Add Product",
                                                    color: AppColors.blackColor,
                                                    size: 14.sp,
                                                  ),
                                                  SizedBox(height: 15.h),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    child: Container(
                                                      height: 45.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: Colors.grey[100],
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey[400]!,
                                                            offset: const Offset(
                                                                0.0,
                                                                1.0), //(x,y)
                                                            blurRadius: 6.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: TextFormField(
                                                        controller: homeProvider
                                                            .owner_name,
                                                        cursorColor:
                                                            Colors.black,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration: const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            errorBorder:
                                                                InputBorder
                                                                    .none,
                                                            disabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    bottom: 5,
                                                                    right: 15),
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        12),
                                                            hintText:
                                                                "Enter Owner Name"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    child: Container(
                                                      height: 45.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: Colors.grey[100],
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey[400]!,
                                                            offset: const Offset(
                                                                0.0,
                                                                1.0), //(x,y)
                                                            blurRadius: 6.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: TextFormField(
                                                        cursorColor:
                                                            Colors.black,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller: homeProvider
                                                            .vehicle_name,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        // ignore: unnecessary_new
                                                        decoration: const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            errorBorder:
                                                                InputBorder
                                                                    .none,
                                                            disabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    bottom: 5,
                                                                    right: 15),
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        12),
                                                            hintText:
                                                                "Enter Vehicle Name"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    child: Container(
                                                      height: 45.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: Colors.grey[100],
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey[400]!,
                                                            offset:
                                                                const Offset(
                                                                    0.0, 1.0),
                                                            blurRadius: 6.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: TextFormField(
                                                        cursorColor:
                                                            Colors.black,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller: homeProvider
                                                            .vehicle_color,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        // ignore: unnecessary_new
                                                        decoration: const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            errorBorder:
                                                                InputBorder
                                                                    .none,
                                                            disabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    bottom: 5,
                                                                    right: 15),
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        12),
                                                            hintText:
                                                                "Enter Vehicle Color"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  CustomText(
                                                    text: "Vehicle Picture",
                                                    color: AppColors.blackColor,
                                                    size: 14.sp,
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  InkWell(
                                                    onTap: () async {
                                                      print('click');
                                                      final ImagePicker
                                                          _picker =
                                                          ImagePicker();
                                                      homeProvider.file =
                                                          await _picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                      setState(() {});
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      child: Container(
                                                        height: 80,
                                                        width: 100,
                                                        // ignore: sort_child_properties_last
                                                        child: homeProvider
                                                                    .file ==
                                                                null
                                                            ? const Center(
                                                                child: Icon(
                                                                    Icons
                                                                        .image),
                                                              )
                                                            : Image.file(File(
                                                                homeProvider
                                                                    .file!
                                                                    .path)),
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Colors
                                                                    .black12),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15.h),
                                                  InkWell(
                                                    onTap: () async {
                                                      Directory appDocDir =
                                                          await getApplicationDocumentsDirectory();
                                                      String databasePath =
                                                          path.join(
                                                              appDocDir.path,
                                                              'my_database.db');
                                                      final databaseFactory =
                                                          databaseFactoryIo;
                                                      final store =
                                                          stringMapStoreFactory
                                                              .store(
                                                                  'vehicle_store');
                                                      final database =
                                                          await databaseFactory
                                                              .openDatabase(
                                                                  databasePath);
                                                      var uuid = const Uuid();
                                                      CarModel model = CarModel(
                                                          email: widget.email,
                                                          image: homeProvider
                                                              .file!.path,
                                                          ownerName:
                                                              homeProvider
                                                                  .owner_name
                                                                  .text,
                                                          vehicleColor:
                                                              homeProvider
                                                                  .vehicle_color
                                                                  .text,
                                                          id: uuid.v1(),
                                                          vehicleName:
                                                              homeProvider
                                                                  .vehicle_name
                                                                  .text);
                                                      await store.update(
                                                          database,
                                                          model.toJson(),
                                                          finder: Finder(
                                                            filter: Filter.equals(
                                                                'id',
                                                                '${homeProvider.list_of_car_model[index].id}'),
                                                          ));
                                                      await homeProvider
                                                          .getAllVehicleRecord(
                                                              context: context,
                                                              email:
                                                                  widget.email);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      height: 45.h,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xff171717),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.sp)),
                                                      child: Center(
                                                        child: Text(
                                                          'Add',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: const Color(
                                                                  0xffECF0F5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }),
                                      )).then((value) {
                                //..clear the textfromfield text after add product
                                file = null;
                                homeProvider.owner_name.text = '';
                                homeProvider.vehicle_name.text = '';
                                homeProvider.vehicle_color.text = '';
                              });
                            }
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 70.h,
            )
          ],
        ),
      ),
      //...........................Add New Product..............................//
      floatingActionButton: FloatingActionButton.extended(
        label: const CustomText(
          text: "Add Product",
          color: AppColors.blackColor,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          //..show dialog to add new product
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    height: 420.h,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 7.h),
                        CustomText(
                          text: "Add Product",
                          color: AppColors.blackColor,
                          size: 14.sp,
                        ),
                        SizedBox(height: 15.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400]!,
                                  offset: const Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: homeProvider.owner_name,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 5, right: 15),
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: "Enter Owner Name"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400]!,
                                  offset: const Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              controller: homeProvider.vehicle_name,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 5, right: 15),
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: "Enter Vehicle Name"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400]!,
                                  offset: const Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              controller: homeProvider.vehicle_color,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 5, right: 15),
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: "Enter Vehicle Color"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Text('Vehicle Picture'),
                        SizedBox(height: 5.h),
                        InkWell(
                          onTap: () async {
                            print('click');
                            final ImagePicker _picker = ImagePicker();
                            homeProvider.file = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {});
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              height: 80,
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.black12),
                              child: homeProvider.file == null
                                  ? const Center(
                                      child: Icon(Icons.image),
                                    )
                                  : Image.file(File(homeProvider.file!.path)),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        InkWell(
                          onTap: () async {
                            //.add new product
                            await homeProvider.addProduct(email: widget.email);
                            //..
                            await homeProvider.getAllVehicleRecord(
                                email: widget.email, context: context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 45.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: const Color(0xff171717),
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xffECF0F5),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ).then(
            (value) {
              file = null;
              //..clear add new product textfromfield after add new product
              homeProvider.owner_name.text = '';
              homeProvider.vehicle_name.text = '';
              homeProvider.vehicle_color.text = '';
            },
          );
        },
      ),
    );
  }
}
