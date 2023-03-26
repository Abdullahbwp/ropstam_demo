import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:ropstam_test/custom_widgets/custom_textform_field.dart';
import 'package:ropstam_test/provider.dart/sign_up_provider.dart';
import 'package:ropstam_test/provider.dart/update_data_provider.dart';
import 'package:ropstam_test/utills/app_colors.dart';
import 'package:ropstam_test/utills/helper.dart';
import 'package:ropstam_test/utills/snack_bar.dart';
import 'package:ropstam_test/view_model/views/login_page/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool showPassword = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode phoneNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpdateDataProvider>(
      context,
    );
    final signUpprovider = Provider.of<SignUpProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70.h,
              ),
              SizedBox(
                height: 200.h,
                width: 200.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.sp),
                  child: Image.asset(
                    'assets/images/login.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Hey there, welcome back',
                style:
                    TextStyle(color: const Color(0xff201A1B), fontSize: 18.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                textAlign: TextAlign.center,
                'Sign Up to create your account.',
                style:
                    TextStyle(fontSize: 14.sp, color: const Color(0xff939393)),
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomFormField(
                      hintText: "Ali",
                      labelText: "First Name",
                      controller: signUpprovider.firstNameController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (p0) {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      validator: (input) => input!.length < 3
                          ? "should be more than 3 letters"
                          : null,
                      prefixIcon: Icon(Icons.person_outlined,
                          size: 32.sp, color: AppColors.lightBlackColor),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomFormField(
                      hintText: "Ahmad",
                      labelText: "Last Name",
                      onFieldSubmitted: (p0) {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      controller: signUpprovider.lastNameController,
                      keyboardType: TextInputType.text,
                      validator: (input) => input!.length < 3
                          ? "should be more than 3 letters"
                          : null,
                      prefixIcon: Icon(Icons.person_outlined,
                          size: 32.sp, color: AppColors.lightBlackColor),
                    ),
                    SizedBox(height: 20.h),
                    CustomFormField(
                      controller: signUpprovider.emailController,
                      validator: (t) {
                        if (t != null && !Helper.isEmail(t.trim())) {
                          return "should be a valid email";
                        }
                        return null;
                      },
                      labelText: "Email",
                      onFieldSubmitted: (p0) {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.lightBlackColor,
                      ),
                      hintText: 'example@mail.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomFormField(
                      controller: signUpprovider.passwordController,
                      hintText: '••••••••',
                      keyboardType: TextInputType.text,
                      labelText: 'password',
                      obscureText: provider.hidePassword,
                      onFieldSubmitted: (p0) {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      validator: (v) {
                        if (v!.length < 8) {
                          return "should be more than 7 letters";
                        }
                        if (signUpprovider.confirmPasswordCotroller.text
                                .trim() !=
                            signUpprovider.passwordController.text.trim()) {
                          return "password dose not match";
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.setHidePassword();
                        },
                        color: Theme.of(context).focusColor,
                        icon: Icon(provider.hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                        color: Colors.black26,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      controller: signUpprovider.confirmPasswordCotroller,
                      hintText: '••••••••',
                      keyboardType: TextInputType.text,
                      labelText: 'Confirm Password',
                      obscureText: provider.showPassword,
                      onFieldSubmitted: (p0) {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      validator: (v) {
                        if (v!.length < 8) {
                          return "should be more than 7 letters";
                        }
                        if (signUpprovider.confirmPasswordCotroller.text
                                .trim() !=
                            signUpprovider.passwordController.text.trim()) {
                          return "password dose not match";
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.setShowPassword();
                        },
                        color: Theme.of(context).focusColor,
                        icon: Icon(provider.showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      prefixIcon: const Icon(Icons.lock_open_outlined,
                          color: AppColors.lightBlackColor),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                        if (signUpprovider.firstNameController.text.isEmpty) {
                          SnackBarMessage().showErrorSnackBar(
                              message: 'First Name Field is not Empty',
                              context: context);
                        } else if (signUpprovider
                            .lastNameController.text.isEmpty) {
                          SnackBarMessage().showErrorSnackBar(
                              message: 'Last Name Field is not Empty',
                              context: context);
                        } else if (signUpprovider
                            .emailController.text.isEmpty) {
                          SnackBarMessage().showErrorSnackBar(
                              message: 'Email Field is not Empty',
                              context: context);
                        } else if (signUpprovider
                            .passwordController.text.isEmpty) {
                          SnackBarMessage().showErrorSnackBar(
                              message: 'Password Field is not Empty',
                              context: context);
                        } else if (signUpprovider
                            .confirmPasswordCotroller.text.isEmpty) {
                          SnackBarMessage().showErrorSnackBar(
                              message: 'Confirm Password Field is not Empty',
                              context: context);
                        } else if (signUpprovider.confirmPasswordCotroller.text
                                .trim() !=
                            signUpprovider.passwordController.text.trim()) {
                          SnackBarMessage().showErrorSnackBar(
                              message: 'Password does not match',
                              context: context);
                        } else {
                          await signUpprovider.signUpMethod(context);
                          signUpprovider.firstNameController.clear();
                          signUpprovider.lastNameController.clear();
                          signUpprovider.emailController.clear();
                          signUpprovider.passwordController.clear();
                          signUpprovider.confirmPasswordCotroller.clear();
                        }
                      },
                      child: Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xff171717),
                          borderRadius: BorderRadius.circular(30.sp),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I have account back to ",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
