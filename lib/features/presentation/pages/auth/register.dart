import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/features/data/controllers/authctrllers/registerctrller.dart';
import 'package:todo_app/features/presentation/widgets/custom_btns.dart';
import 'package:todo_app/features/presentation/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerctrller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: registerctrller.formkey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text('Register', style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'Explore your task by sign up with us',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  ctrller: registerctrller.namecontroller,
                  label: 'user name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  ctrller: registerctrller.emailcontroller,
                  label: 'Email Id',
                  textinputtype: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email Id is required';
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
                    ctrller: registerctrller.passwordcontroller,
                    label: 'Password',
                    isobsure: !registerctrller.ispassobsure.value,
                    suffixicon: IconButton(
                      onPressed: () => registerctrller.togglepass(),
                      icon: Icon(
                        registerctrller.ispassobsure.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
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
                  () => CustomTextField(
                    ctrller: registerctrller.confirmcontroller,
                    label: 'Password',
                    isobsure: !registerctrller.iscpassobsure.value,
                    suffixicon: IconButton(
                      onPressed: () => registerctrller.togglecpass(),
                      icon: Icon(
                        registerctrller.iscpassobsure.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confrim Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password atleast 6 digit';
                      }
                      if (!registerctrller.isPassWordmatch()) {
                        return 'Password Mismatch';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Obx(
                  () => CustomBtns(
                    label: 'Register',
                    onpress: () => registerctrller.register(),
                    isloading: registerctrller.isloading.value,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account ?'),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
