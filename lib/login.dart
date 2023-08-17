import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:physical/popup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _nameState();
}

class _nameState extends State<Login> {
  final String domainKey = 'XE3LSGPPEYVLHR1B';

  bool? isChecked = false;
  bool isObscured = true;
  bool emailValidate = false;
  bool passValidate = false;
  String errorMessage = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 7,
            // child: Container(
            child: Image.asset(
              'images/healthcare.jpg',
              fit: BoxFit.fill,
            ),
            // ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 130,
                        height: 80,
                        child: Image.asset(
                          'images/boodskaplogo.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Login to Health Care',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(199, 32, 122, 107),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Enter the account details below',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'username',
                                errorText:
                                    emailValidate ? 'Email Required' : null,
                                suffixIcon: const Icon(
                                  Icons.account_circle,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: isObscured,
                              decoration: InputDecoration(
                                hintText: 'password',
                                errorText:
                                    passValidate ? 'Password Required' : null,
                                suffixIcon: IconButton(
                                  icon: isObscured
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      isObscured = !isObscured;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (checked) {
                                    setState(() {
                                      isChecked = checked;
                                    });
                                  },
                                ),
                                const Text(
                                  'Remember Me',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              // key: _formKey,
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   emailController.text.isEmpty
                                    //       ? emailValidate = true
                                    //       : emailValidate = false;
                                    //   passwordController.text.isEmpty
                                    //       ? passValidate = true
                                    //       : passValidate = false;
                                    // });
                                    // if (!emailValidate && !passValidate) {
                                    //   login(emailController.text.toString(),
                                    //       passwordController.text.toString());
                                    // }
                                    Mypopup.showPopUpMessage(context);
                                  },
                                  child: Text('Login'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(199, 32, 122, 107),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: Visibility(
                      visible: errorMessage.isNotEmpty,
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '2023 All rights reserved. Powered by',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'images/boodskaplogo.png',
                        width: 100,
                        height: 40,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  login(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          "https://v5dev.boodskap.io/api/domain/login",
        ),
        body: jsonEncode(
          {"email": email, "password": password, "targetDomainKey": domainKey},
        ),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        // print(response.body.toString());
        Object user = response.body;
        Navigator.pushNamed(context, '/home', arguments: user);
      } else {
        setState(() {
          errorMessage = "Authentication failed";
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
