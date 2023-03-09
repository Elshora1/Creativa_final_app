import 'package:creativa_fproject/Screens/Login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data' ;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isObscureText = true;
  bool isObscureTextTwo = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset('assets/animation/ecommerceReg.json'),
                  ),

                  Text(
                    "Sign Up Now.. ",
                    style: GoogleFonts.genos
                      (fontSize:40,fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),

                  //Full name
                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: ("Full Name "),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle,
                          color: Color(0xff16e7b3),),
                      ),
                      validator: (String? value) {
                        // callback function
                        if (value!.length < 6) {
                          return "The name must be above 6 character";
                        }
                        // String
                        if (value.isEmpty) {
                          return "The name must be not empty!";
                        }
                        return null;
                      },
                    ),
                  ),

                  //Email

                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: ("Your Email "),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email,
                          color: Color(0xff16e7b3),),

                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "The name must be not empty!";
                        }
                      },
                    ),
                  ),
                  //password
                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: isObscureText, // false
                      decoration: InputDecoration(
                        hintText: 'Enter your Password ',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          color: Color(0xff16e7b3),
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          icon: isObscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility), // false
                        ),
                      ),
                      validator: (String? value) {
                        // callback function
                        if (value!.length < 4) {
                          return "The name must be above 6 character";
                        }
                        // String
                        if (value.isEmpty) {
                          return "The name must be not empty!";
                        }
                        return null;
                      },
                    ),
                  ),
                  //SecondPassword
                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: secondPasswordController,
                      textInputAction: TextInputAction.next,
                      obscureText: isObscureTextTwo, // false
                      decoration: InputDecoration(
                        hintText: 'Enter your Password Again',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          color: Color(0xff16e7b3),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscureTextTwo = !isObscureTextTwo;
                            });
                          },
                          icon: isObscureTextTwo
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility), // false
                        ),
                      ),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        // print(nameController.text);
                        // print(emailController.text);
                        // print(passwordController.text);

                        // false
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text ==
                              secondPasswordController.text) {
                            // successful state
                            Log_in();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Your password dont match!'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                      },
                      child: Text("Sign up"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an account?"),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (BuildContext) {
                                return Login();
                              }));
                            },
                            child: Text(
                              "Sign in ",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 250,)
                ]),
          ),
        ),

      ),
    );
  }

  void Log_in() async {
    try {
      final response =
          await Dio().post("https://api.escuelajs.co/api/v1/users/", data: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480"
      });

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Login();
      }));
    } on DioError catch (e) {
      print("This is an error : ${e.response}");
      if (e.response!.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You should enter valid email and password!'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
