// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment_6/helpers/constants.dart';
import 'package:assignment_6/helpers/sql_helper.dart';
import 'package:assignment_6/helpers/validator.dart';
import 'package:assignment_6/model/user_model.dart';
import 'package:assignment_6/screens/all_data.dart';
import 'package:assignment_6/widget/my_button.dart';
import 'package:assignment_6/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  bool _isLoading = false;

  void _getAllUsers() async {
    final data = await SQLHelper.getItems();
    setState(() {
      UserModel.allUsers = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  Future<void> _addUser() async {
    await SQLHelper.createItem(
        UserModel.username.toString(), UserModel.password.toString());
    _getAllUsers();
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Assignment 6')),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.black,
        inAsyncCall: _isLoading,
        progressIndicator: CircularProgressIndicator(color: kRedColor),
        child: Container(

          height: size.height,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/back.png'),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          // Container(
          //     alignment: Alignment.center,
          //     padding: const EdgeInsets.all(10),
          //     child: const Text(
          //       '2020BTEIT00042',
          //       style: TextStyle(
          //           color: Colors.blue,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 30),
          //     )),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 35 / 3),
                  Text(
                    '2020BTEIT00042',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 22 / 3),
                  Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 105 / 3),
                    child: Form(
                      key: _formFieldKey,
                      child: Column(
                        children: [
                          MyTextInput(
                            icon: Icons.person,
                            hintText: 'Username',

                            controller: _usernameController,
                            validator: userNameValidator,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 10 ),
                          MyTextInput(
                            hintText: "Password",
                            icon: Icons.lock_rounded,
                            controller: _passwordController,
                            validator: passwordRequireValidator,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              if (_formFieldKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                  UserModel.username = _usernameController.text;
                                  UserModel.password = _passwordController.text;
                                });
                                await _addUser();
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllData(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: kSkyBlueShade,
                                    content: Text(
                                      'Successfully added a user',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                             child: MyButton(text: "Login"),
                              //
                              // child: Container(
                              //     height: 50,
                              //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              //     child: ElevatedButton(
                              //       child: const Text('login'),
                              //       // onPressed: () {
                              //       //   // print(nameController.text);
                              //       //   // print(passwordController.text);
                              //       // },
                              //       onPressed: () {
                              //         Navigator.pushReplacement(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) => AllData(),
                              //           ),
                              //         );
                              //       },
                              //     )
                              // ),
                            ),

                          // Row(
                          //   children: [
                          // SizedBox(height: 112.7 / 3),
                          // MyButton(text: "Create"),
                          // SizedBox(height: 112.7 / 3),
                          // MyButton(text: "Delete"),
                          //   ],
                          // ),
                          SizedBox(height: 30),
                          Row(
                            children: [

                              Expanded(
                                child: Container(

                                    height: 50,
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AllData(),
                                          ),
                                        );
                                      },
                                    )
                                ),
                              ),

                              Expanded(
                                child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                      child: const Text('Create'),
                                      // onPressed: () {
                                      //   // print(nameController.text);
                                      //   // print(passwordController.text);
                                      // },
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AllData(),
                                          ),
                                        );
                                      },
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children:[
                          Expanded(
                            child: Container(
                                height: 50,
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  child: const Text('Update'),
                                  // onPressed: () {
                                  //   // print(nameController.text);
                                  //   // print(passwordController.text);
                                  // },
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllData(),
                                      ),
                                    );
                                  },
                                )
                            ),
                          ),
                    ],
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => AllData(),
                          //       ),
                          //     );
                          //   },
                          //   child: Container(
                          //     alignment: AlignmentDirectional.center,
                          //     height: 50,
                          //     width: size.width * 0.5,
                          //    // color: Colors.blue,
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //         color: Colors.blue,
                          //         width: 2,
                          //       ),
                          //     ),
                          //     child: Text(
                          //       "Update",
                          //       style: TextStyle(
                          //         color: Colors.black,
                          //         fontSize: 22,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 74 / 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
