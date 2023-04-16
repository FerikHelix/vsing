import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:timelines/timelines.dart';
import 'package:vsing/main.dart';

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  var tahunnow;
  var monthid;
  var month;
  var monthidname;
  @override
  void initState() {
    super.initState();
    monthid = DateFormat('MMMM').format(DateTime.now());
    tahunnow = DateTime.now().year.toString();
    _cekDatas();
  }

  String removeMail(String userMail) {
    return userMail.replaceAll('@mail.com', '');
  }

  List bulan = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  _cekDatas() async {
    final table = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('History')
        .where('id', isEqualTo: '$monthid $tahunnow')
        .get();

    var lantai = table.docs.map((e) => e.data()).toList();
  }

  String getFirstName(String fullName) {
    List<String> nameParts = fullName.split(
        " "); // Membagi string nama lengkap menjadi array berdasarkan spasi
    return nameParts[0]; // Mengambil elemen pertama (nama pertama)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 250, 250, 250),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
                color: Color.fromARGB(255, 56, 43, 83),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_rounded,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      height: 50.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 121, 104, 229),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40.w,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      getFirstName(user!.displayName!),
                      style: TextStyle(
                        fontFamily: "nunito",
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          NAlertDialog(
                            dialogStyle: DialogStyle(titleDivider: true),
                            title: Text(
                              "VSing Reservation",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 23.sp, fontWeight: FontWeight.bold),
                            ),
                            content: Text("V.1.0.7",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                )),
                          ).show(context);
                        },
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        )),
                    MaterialButton(
                      child: Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        // GoogleSignIn().signOut();

                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return new auth();
                        }), (r) {
                          return false;
                        });
                        //   // _googleSignIn. signOut();
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "History",
                      style: TextStyle(
                          fontFamily: "nunito",
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(tahunnow),
                      Container(
                        height: 3.h,
                        width: 60.w,
                        color: Colors.black,
                      )
                    ],
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                    size: 35.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    children: [
                      Text(monthid),
                      Container(
                        height: 3.h,
                        width: 80.w,
                        color: Colors.black,
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 300.h,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: bulan.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 8,
                                            right: 8),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              monthid = bulan[index];
                                              print(monthid);
                                            });
                                          },
                                          child: Text(
                                            bulan[index],
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                      size: 35.w,
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 35, bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 700.h,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: StreamBuilder(
                    stream: db
                        .collection('Vsing-rsv')
                        .doc('reservation')
                        .collection('History')
                        .where('id', isEqualTo: '$monthid $tahunnow')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                          oppositeContentsBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data[index].data()['bulan'],
                                  style: TextStyle(
                                      fontFamily: "nunito",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data[index].data()['time'].toString(),
                                  style: TextStyle(
                                      fontFamily: "nunito",
                                      fontSize: 16.sp,
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
                                      fontSize: 18.sp,
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
                )),

            // log
          ],
        ),
      ),
    );
  }
}
