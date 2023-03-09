import 'package:creativa_fproject/Screens/Home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:creativa_fproject/Screens/Register.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObscureText = true;

  bool isObscureTextTwo = true;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child:Lottie.asset('assets/animation/ecommerceLog.json'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          "Welcome to Our App",
                          style: GoogleFonts.genos
                            (fontSize:40,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Text("Log in to continue "),
                        SizedBox(height: 10),

                        //Email
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: ("User name "),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xff16e7b3),
                              ),
                            ),
                            validator: (String? value) {
                              // callback function
                              if (value!.length < 6) {
                                return "The email must be above 6 character";
                              }
                              // String
                              if (value.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Email must be not empty'),
                                  backgroundColor: Colors.greenAccent,
                                ));
                              }
                              return null;
                            },
                          ),
                        ),
                        //Password
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
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              print(emailController.text);
                              print(passwordController.text);

                              // false
                              if (_formKey.currentState!.validate()) {
                                // successful state
                                Log_in();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Chek The Error in Password & Email'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            //Login
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(builder: (BuildContext) {
                                //   return MainPage();
                                // }));
                              },
                              child: Text(
                                "Login ",
                              ),
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: Text("Are you forgot?"),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Do you have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext) {
                                    return Registration();
                                  }));
                                },
                                child: Text(
                                  "   Register ",
                                  style: TextStyle(color: Colors.blue),
                                ),

                              ),

                            ]),
                      ]),
                ),
              ),
              SizedBox(height:200,),
            ],
          ),
        ),
      ),
    );
  }

  void Log_in() async {
    try {
      final response = await Dio().post(
        "https://api.escuelajs.co/api/v1/auth/login",
        data: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );
      print('Datais:${response.data['access_token']}');
      final accessToken = response.data['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      final access = await prefs.get('access_token');
      print('my access token is: $access');

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } on DioError catch (e) {
      print("This is an error : ${e.response}");
      if (e.response!.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You should enter valid email and password!'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
