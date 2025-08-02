import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/features/data/controllers/authctrllers/loginctrller.dart';
import 'package:todo_app/features/presentation/widgets/custom_btns.dart';
import 'package:todo_app/features/presentation/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Loginctrller loginctrller;

  @override
  void initState() {
    loginctrller = Get.put(Loginctrller());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: loginctrller.formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 30),
                      child: CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.savings_outlined, size: 50),
                      ),
                    ),
                    CustomTextField(
                      ctrller: loginctrller.emailid,
                      label: 'Email Id',
                      textinputaction: TextInputAction.next,
                      textinputtype: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Id required';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid Email Id';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomTextField(
                        ctrller: loginctrller.password,
                        isobsure: loginctrller.showpass.value,
                        label: 'Password',
                        textinputaction: TextInputAction.done,
                        textinputtype: TextInputType.text,
                        suffixicon: IconButton(
                          onPressed: loginctrller.toggle,
                          icon: Icon(
                            loginctrller.showpass.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password required';
                          }
                          if (value.length < 6) {
                            return 'Password atleast 6 digit';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomBtns(
                        label: 'Login',
                        isloading: loginctrller.isLoading.value,
                        hasicon: true,
                        icon: Icons.login,
                        onpress:
                            loginctrller.isLoading.value
                                ? () {}
                                : () {
                                  FocusScope.of(context).unfocus();
                                  loginctrller.onsubmit();
                                },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Do\'nt have an account ?'),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.register),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
