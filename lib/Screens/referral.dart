import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:referral_app/Processing/enums.dart';
import 'package:referral_app/Processing/referral_provider.dart';
import 'package:referral_app/Screens/home.dart';

import '../Processing/constants.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final TextEditingController _refController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: kYellow,
        body: Consumer<RefProvider>(
          builder: (context, model, child) {
            return model.state == ViewState.Busy
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Referral',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Enter referral code, if you have any.',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: kAccentBlue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                    child: TextField(
                                      controller: _refController,
                                      // onChanged: (value) {
                                      //   _refController.text = value;
                                      // },
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: "Referral code",
                                          hintStyle: TextStyle(fontSize: 15),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: kGrey,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15)),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 5, child: Container()),
                                GestureDetector(
                                  onTap: () async {
                                    if (_refController.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
                                    } else {
                                      await model.setReferral(
                                          _refController.text.trim());

                                      if (model.state == ViewState.Success) {
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return HomePage();
                                        }));
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(model.message)));
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: kBlue,
                                      borderRadius: BorderRadius.all(
                                          (Radius.circular(20))),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("No I don't have a code,"),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomePage();
                                          }));
                                        },
                                        child: Text(
                                          "Continue to home page",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
