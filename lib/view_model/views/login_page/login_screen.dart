import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ropstam_test/custom_widgets/custom_textform_field.dart';
import 'package:ropstam_test/models/sign_up_model.dart';
import 'package:ropstam_test/provider.dart/login_provider.dart';
import 'package:ropstam_test/provider.dart/update_data_provider.dart';
import 'package:ropstam_test/utills/app_colors.dart';
import 'package:ropstam_test/utills/custom_text.dart';
import 'package:ropstam_test/utills/helper.dart';
import 'package:ropstam_test/utills/snack_bar.dart';
import 'package:ropstam_test/view_model/views/signup_page/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool hidePassword;
  final GlobalKey<FormState> loginFromKey = GlobalKey<FormState>();

  @override
  void initState() {
    hidePassword = true;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SignUpModel sign_up_model = SignUpModel();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpdateDataProvider>(
      context,
    );
    final loginprovider = Provider.of<LoginProvider>(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
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
                'Sign in to continue with your email',
                style:
                    TextStyle(fontSize: 14.sp, color: const Color(0xff939393)),
              ),
              SizedBox(
                height: 40.h,
              ),
              Form(
                key: loginFromKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomFormField(
                      controller: loginprovider.emailController,
                      validator: (t) {
                        if (t != null && !Helper.isEmail(t.trim())) {
                          return "should be a valid email";
                        }
                        return null;
                      },
                      labelText: "Email",
                      onFieldSubmitted: (p0) {
                        if (loginFromKey.currentState!.validate()) {
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
                      controller: loginprovider.passwordController,
                      validator: (v) {
                        if (v!.length < 8) {
                          return "should be more than 7 letters";
                        }
                        return null;
                      },
                      hintText: '••••••••',
                      keyboardType: TextInputType.text,
                      labelText: 'password',
                      obscureText: provider.hidePassword,
                      onFieldSubmitted: (v) {
                        if (loginFromKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.setHidePassword();
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ],
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                        color: Colors.black26,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (loginFromKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          if (loginprovider.emailController.text.isEmpty) {
                            SnackBarMessage().showErrorSnackBar(
                                message: 'Email Field is not Empty',
                                context: context);
                          } else if (loginprovider
                              .passwordController.text.isEmpty) {
                            SnackBarMessage().showErrorSnackBar(
                                message: 'Password Field is not Empty',
                                context: context);
                          } else {
                            loginprovider.loginMethod(context);
                            loginprovider.emailController.clear();
                            loginprovider.passwordController.clear();
                          }
                        }
                      },
                      child: Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xff171717),
                            borderRadius: BorderRadius.circular(30.sp)),
                        child: Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: const Color(0xffECF0F5),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 190.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "Don't have account?  ",
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ));
                    },
                    child: const CustomText(
                      text: "Sign Up",
                      color: AppColors.blueColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
