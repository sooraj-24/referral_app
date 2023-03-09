import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:referral_app/Processing/constants.dart';
import 'package:referral_app/Screens/login.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference profileRef =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kYellow,
        title: Text(
          'Welcome',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return SignInScreen();
                  }), ModalRoute.withName('/'));
                });
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      backgroundColor: kAccentBlue,
      body: FutureBuilder<QuerySnapshot>(
        future: profileRef
            .where("refCode", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data?.docs[0];

            final earnings = data?.get("refEarnings");
            List referralsList = data?.get('referals');
            final refCode = data?.get('refCode');
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: RefreshIndicator(
                onRefresh: () {
                  setState(() {});
                  return Future.delayed(Duration(seconds: 2));
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text('Earnings'),
                              subtitle: Text('Rs ${earnings}'),
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          Card(
                            child: ListTile(
                              title: Text('Referral Code'),
                              subtitle: Text('${refCode}'),
                              trailing: IconButton(
                                onPressed: () {
                                  ClipboardData data =
                                      ClipboardData(text: refCode);
                                  Clipboard.setData(data);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Referral code copied!')));
                                },
                                icon: Icon(Icons.copy),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Invite your friends to this app and earn Rs. 500 when they register with your referral code.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      String shareLink =
                                          'Hey, register on this app using my referral code ${refCode}';
                                      Share.share(shareLink);
                                    },
                                    child: Text('Share link'),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Referrals'),
                                Text('${referralsList.length}'),
                              ],
                            ),
                          ),
                          if (referralsList.isEmpty) Text('No referrals'),
                          if (referralsList.isNotEmpty ||
                              referralsList.length != 0)
                            ...List.generate(referralsList.length, (index) {
                              final data = referralsList[index];
                              return Container(
                                height: 50,
                                margin: EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: kBlue,
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(data),
                                ),
                              );
                            }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
