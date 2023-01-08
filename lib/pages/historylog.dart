import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:vsing/auth/loginpage.dart';
import 'package:vsing/main.dart';

class history extends StatefulWidget {
  final bulan;
  final tahun;
  const history({super.key, required this.bulan, required this.tahun});

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var tahun = '0';
    var bulan = '0';

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Color.fromARGB(255, 54, 51, 140),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    user!.email!,
                    style: TextStyle(
                      fontFamily: "nunito",
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  MaterialButton(
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      // GoogleSignIn().signOut();

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return auth();
                      }), (r) {
                        return false;
                      });
                      //   // _googleSignIn. signOut();
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
              child: Container(
                child: Text(
                  "Riwayat",
                  style: TextStyle(
                      fontFamily: "nunito",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 35, top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 600,
                child: ListView(
                  children: [
                    StreamBuilder(
                      stream: db
                          .collection('History')
                          .doc(widget.tahun)
                          .collection('month')
                          .doc(widget.bulan)
                          .collection('bulan')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("eror"),
                          );
                        }

                        // data
                        var data = snapshot.data!.docs;

                        return FixedTimeline.tileBuilder(
                          builder: TimelineTileBuilder.connectedFromStyle(
                            contentsAlign: ContentsAlign.basic,
                            oppositeContentsBuilder: (context, index) =>
                                Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[index].data()['bulan'],
                                    style: TextStyle(
                                        fontFamily: "nunito",
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data[index].data()['time'].toString(),
                                    style: TextStyle(
                                        fontFamily: "nunito",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            contentsBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data[index].data()['Log_Msg'].toString(),
                                    style: TextStyle(
                                        fontFamily: "nunito",
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            connectorStyleBuilder: (context, index) =>
                                ConnectorStyle.solidLine,
                            indicatorStyleBuilder: (context, index) =>
                                IndicatorStyle.dot,
                            itemCount: data.length,
                          ),
                        );
                      },
                    ),
                  ],
                ))

            // log
          ],
        ),
      )),
    );
  }
}
