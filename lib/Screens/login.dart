import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:referral_app/Processing/auth_provider.dart';
import 'package:referral_app/Processing/enums.dart';
import 'package:referral_app/Screens/home.dart';
import 'package:referral_app/Screens/sign_up.dart';
import '../Processing/constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';

  String password = '';

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentBlue,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer<AuthProvider>(
          builder: (context, model, child) {
            return model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    reverse: true,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Referral App",
                                        style: TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Refer and Earn",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                  color: kAccentBlue,
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, left: 5),
                                            child: Text(
                                              "Sign In",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kAccentBlue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                            child: TextField(
                                              onChanged: (value) {
                                                email = value;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: InputDecoration(
                                                  hintText: "Email",
                                                  hintStyle:
                                                      TextStyle(fontSize: 15),
                                                  prefixIcon: Icon(
                                                    Icons.mail,
                                                    color: kGrey,
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kAccentBlue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: TextField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                },
                                                obscureText: !isPasswordVisible,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration: InputDecoration(
                                                    hintText: "Password",
                                                    hintStyle:
                                                        TextStyle(fontSize: 15),
                                                    prefixIcon: Icon(
                                                      Icons.password,
                                                      color: Colors.grey,
                                                    ),
                                                    suffixIcon: password.isEmpty
                                                        ? null
                                                        : IconButton(
                                                            color: Colors.grey,
                                                            icon: Icon(isPasswordVisible
                                                                ? Icons
                                                                    .visibility
                                                                : Icons
                                                                    .visibility_off),
                                                            onPressed: () {
                                                              setState(() {
                                                                isPasswordVisible =
                                                                    !isPasswordVisible;
                                                              });
                                                            },
                                                          ),
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //SizedBox(height: 5,),
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Forgot Password?",
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (email == '' || password == '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'All fields are required')));
                                            } else {
                                              await model.loginUser(email, password);
                                              if(model.state == ViewState.Success){
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return HomePage();
                                                }));
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(model.message)));
                                              }
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: kBlue,
                                              borderRadius: BorderRadius.all(
                                                  (Radius.circular(20))),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Sign In",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Don't have an account?  "),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return SignUpScreen();
                                                  }));
                                                },
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return SignUpScreen();
                                                    }));
                                                  },
                                                  child: Text(
                                                    "Sign Up",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                      color: kYellow,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30))),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          // child: SingleChildScrollView(
          //   physics: NeverScrollableScrollPhysics(),
          //   reverse: true,
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.height,
          //     child: SafeArea(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           Expanded(
          //               flex: 4,
          //               child: Container(
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text(
          //                       "Referral App",
          //                       style: TextStyle(
          //                           fontSize: 48, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "Refer and Earn",
          //                       style: TextStyle(fontSize: 15),
          //                     )
          //                   ],
          //                 ),
          //                 color: kAccentBlue,
          //               )),
          //           Expanded(
          //               flex: 3,
          //               child: Container(
          //                 padding:
          //                 EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.stretch,
          //                   children: [
          //                     Expanded(
          //                         flex: 2,
          //                         child: Padding(
          //                           padding: EdgeInsets.only(top: 8, left: 5),
          //                           child: Text(
          //                             "Sign In",
          //                             style: TextStyle(
          //                                 fontSize: 24,
          //                                 fontWeight: FontWeight.bold),
          //                           ),
          //                         )),
          //                     Expanded(
          //                       flex: 2,
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                             color: kAccentBlue,
          //                             borderRadius:
          //                             BorderRadius.all(Radius.circular(20))),
          //                         child: Center(
          //                           child: TextField(
          //                             onChanged: (value) {
          //                               email = value;
          //                             },
          //                             keyboardType: TextInputType.emailAddress,
          //                             textInputAction: TextInputAction.done,
          //                             decoration: InputDecoration(
          //                                 hintText: "Email",
          //                                 hintStyle: TextStyle(fontSize: 15),
          //                                 prefixIcon: Icon(
          //                                   Icons.mail,
          //                                   color: kGrey,
          //                                 ),
          //                                 border: InputBorder.none,
          //                                 contentPadding:
          //                                 EdgeInsets.symmetric(vertical: 15)),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       height: 15,
          //                     ),
          //                     Expanded(
          //                       flex: 2,
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                             color: kAccentBlue,
          //                             borderRadius:
          //                             BorderRadius.all(Radius.circular(20))),
          //                         child: Center(
          //                           child: Padding(
          //                             padding: const EdgeInsets.only(right: 5),
          //                             child: TextField(
          //                               onChanged: (value) {
          //                                 setState(() {
          //                                   password = value;
          //                                 });
          //                               },
          //                               obscureText: !isPasswordVisible,
          //                               keyboardType: TextInputType.emailAddress,
          //                               textInputAction: TextInputAction.done,
          //                               decoration: InputDecoration(
          //                                   hintText: "Password",
          //                                   hintStyle: TextStyle(fontSize: 15),
          //                                   prefixIcon: Icon(
          //                                     Icons.password,
          //                                     color: Colors.grey,
          //                                   ),
          //                                   suffixIcon: password.isEmpty ? null : IconButton(
          //                                     color: Colors.grey,
          //                                     icon: Icon(isPasswordVisible
          //                                         ? Icons.visibility
          //                                         : Icons.visibility_off),
          //                                     onPressed: () {
          //                                       setState(() {
          //                                         isPasswordVisible =
          //                                         !isPasswordVisible;
          //                                       });
          //                                     },
          //                                   ),
          //                                   border: InputBorder.none,
          //                                   contentPadding:
          //                                   EdgeInsets.symmetric(vertical: 15)),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     //SizedBox(height: 5,),
          //                     Expanded(
          //                         flex: 1,
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           crossAxisAlignment: CrossAxisAlignment.end,
          //                           children: [
          //                             Text(
          //                               "Forgot Password?",
          //                             ),
          //                           ],
          //                         )),
          //                     SizedBox(
          //                       height: 15,
          //                     ),
          //                     Expanded(
          //                       flex: 2,
          //                       child: GestureDetector(
          //                         onTap: (){
          //                           if(email=='' || password==''){
          //                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
          //                           } else {
          //
          //                           }
          //                         },
          //                         child: Container(
          //                           decoration: BoxDecoration(
          //                             color: kBlue,
          //                             borderRadius:
          //                             BorderRadius.all((Radius.circular(20))),
          //                           ),
          //                           child: Center(
          //                             child: Text(
          //                               "Sign In",
          //                               style: TextStyle(
          //                                 fontSize: 16,
          //                                 fontWeight: FontWeight.w500,
          //                                 color: Colors.white,
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     SizedBox(height: 5,),
          //                     Expanded(
          //                         flex: 1,
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text("Don't have an account?  "),
          //                             GestureDetector(
          //                               onTap: (){
          //                                 Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));
          //                               },
          //                               child: GestureDetector(
          //                                 onTap: (){
          //                                   Navigator.push(context, MaterialPageRoute(builder: (context){
          //                                     return SignUpScreen();
          //                                   }));
          //                                 },
          //                                 child: Text(
          //                                   "Sign Up",
          //                                   style: TextStyle(
          //                                       fontWeight: FontWeight.w600),
          //                                 ),
          //                               ),
          //                             )
          //                           ],
          //                         )),
          //                   ],
          //                 ),
          //                 decoration: BoxDecoration(
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.grey.withOpacity(0.5),
          //                         spreadRadius: 0,
          //                         blurRadius: 10,
          //                         offset: Offset(0, 4), // changes position of shadow
          //                       ),
          //                     ],
          //                     color: kYellow,
          //                     borderRadius: BorderRadius.only(
          //                         topRight: Radius.circular(30),
          //                         topLeft: Radius.circular(30))),
          //               )),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
