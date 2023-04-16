import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // login func
  Future _login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email.text.trim(),
      password: _pass.text.trim(),
    );
  }

  _loginauth() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _pass.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        NAlertDialog(
          dialogStyle: DialogStyle(titleDivider: true),
          title: Text(
            "wrong-email",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text("No user found for that email.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              )),
          actions: <Widget>[
            TextButton(
                child: Text("Okay",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 192, 34, 23))),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ).show(context);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        NAlertDialog(
          dialogStyle: DialogStyle(titleDivider: true),
          title: Text(
            "wrong-password",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text("Wrong password provided for that user.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              )),
          actions: <Widget>[
            TextButton(
                child: Text("Okay",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 192, 34, 23))),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ).show(context);
        print('Wrong password provided for that user.');
      }
    }
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  bool obscure = true;
  var obsicon = Icon(Icons.visibility_off);

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 56, 43, 83),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 480.w,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 56, 43, 83),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotationTransition(
                          turns: new AlwaysStoppedAnimation(-5 / 360),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.asset(
                              'lib/assets/favicon.png',
                              width: 300.w,
                            ),
                          ),
                        ),
                        // SizedBox(height: 30),
                        Text(
                          "Reservation",
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(50.0),
                  //   child: Image.asset('lib/assets/favicon.png'),
                  // ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 450.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Color.fromARGB(255, 72, 57, 105),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 70.h,
                        child: TextFormField(
                          controller: _email,
                          // textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25.sp),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 238, 238),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 70.h,
                        child: TextFormField(
                          controller: _pass,
                          obscureText: obscure,
                          // textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25.sp),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (obscure == true) {
                                  setState(() {
                                    obscure = false;
                                    obsicon = Icon(Icons.visibility_off);
                                  });
                                } else if (obscure == false) {
                                  setState(() {
                                    obscure = true;
                                    obsicon = Icon(Icons.visibility);
                                  });
                                }
                              },
                              icon: obsicon,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 238, 238),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                      ),
                      // Spacer(),
                      SizedBox(height: 80.h),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                          right: 50,
                          bottom: 20,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.h,
                          child: ElevatedButton(
                            onPressed: _loginauth,
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 52, 40, 74),
                              ),
                            ),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
