import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:on_reserve/Pages/Auth/auth_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_reserve/Controllers/signup_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();

    // Controllers
    final SignUpController signUpController = Get.find();

    String subtitle =
        "One stop online reservation and ticketing solution for Ethiopians";
    return ScaffoldMessenger(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFdbdde1),
            body: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Images/Login BG Flipped.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: AuthBase(
                      background: "assets/Images/Login BG Flipped.png",
                      subTitle: subtitle,
                      reversed: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 95.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80.h),
                        Form(
                          key: logInFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              TextFormField(
                                focusNode: signUpController.emailFocusNode,
                                controller: signUpController.emailController,
                                validator: ValidationBuilder()
                                    .email()
                                    .maxLength(50)
                                    .build(),
                                onFieldSubmitted: (value) => signUpController
                                    .firstnameFocusNode
                                    .requestFocus(),
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                    color: Colors.black,
                                  ),
                                  fillColor:
                                      const Color.fromARGB(200, 255, 255, 255),
                                  filled: true,
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      focusNode:
                                          signUpController.firstnameFocusNode,
                                      controller:
                                          signUpController.fnameController,
                                      onFieldSubmitted: (value) =>
                                          signUpController.lastnameFocusNode
                                              .requestFocus(),
                                      decoration: InputDecoration(
                                        hintText: 'First Name',
                                        hintStyle: TextStyle(
                                          fontSize: 50.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Inter",
                                          color: Colors.black,
                                        ),
                                        fillColor: const Color.fromARGB(
                                            200, 255, 255, 255),
                                        filled: true,
                                        border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14)),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 50.w),
                                  Expanded(
                                    child: TextFormField(
                                      focusNode:
                                          signUpController.lastnameFocusNode,
                                      controller:
                                          signUpController.lnameController,
                                      onFieldSubmitted: (value) =>
                                          signUpController.passwordFocusNode
                                              .requestFocus(),
                                      decoration: InputDecoration(
                                        hintText: 'Last Name',
                                        hintStyle: TextStyle(
                                          fontSize: 50.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Inter",
                                          color: Colors.black,
                                        ),
                                        fillColor: const Color.fromARGB(
                                            200, 255, 255, 255),
                                        filled: true,
                                        border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14)),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50.h),
                              TextFormField(
                                focusNode: signUpController.passwordFocusNode,
                                controller: signUpController.passwordController,
                                validator: ValidationBuilder()
                                    .minLength(8, 'Password Length < 8 😟')
                                    .build(),
                                onFieldSubmitted: (value) => signUpController
                                    .password2FocusNode
                                    .requestFocus(),
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                    color: Colors.black,
                                  ),
                                  fillColor:
                                      const Color.fromARGB(200, 255, 255, 255),
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.h),
                              TextFormField(
                                focusNode: signUpController.password2FocusNode,
                                controller:
                                    signUpController.password2Controller,
                                onFieldSubmitted: (value) {
                                  if (logInFormKey.currentState!.validate())
                                    signUpController.signUp();
                                },
                                validator: (value) {
                                  if (signUpController
                                          .passwordController.text !=
                                      value) return 'Passwords do not match 😟';
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                    color: Colors.black,
                                  ),
                                  fillColor:
                                      const Color.fromARGB(200, 255, 255, 255),
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.h),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(height: 10.h),
                                  GetBuilder<SignUpController>(
                                      builder: (signUpController) {
                                    return Column(
                                      children: [
                                        RoundedLoadingButton(
                                          color: const Color(0xFF3e4c45),
                                          child: Text('Sign Up',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          controller:
                                              signUpController.btnController,
                                          onPressed: () async {
                                            if (logInFormKey.currentState!
                                                .validate()) {
                                              if (!await signUpController
                                                  .signUp()) {
                                                SnackBar(
                                                    content:
                                                        Text("Sign Up Failed"));
                                              } else {}
                                            } else {
                                              signUpController.btnController
                                                  .reset();
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          signUpController.errortext,
                                          style: TextStyle(
                                            fontSize: 50.sp,
                                            fontFamily: "Inter",
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  SizedBox(height: 30.h),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Already have an account? ',
                                      style: TextStyle(
                                        fontSize: 50.sp,
                                        fontFamily: "Inter",
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.toNamed(Routes.login);
                                            },
                                          text: 'Log In',
                                          style: TextStyle(
                                            fontSize: 50.sp,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            )));
  }
}
