import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:vsing/pages/spalsh.dart';

class Edit_Book extends StatefulWidget {
  final name;
  final pax;
  final date;
  final time;
  final phone;
  final event;
  final attendance;
  final id;
  final idmonthbfr;
  final no_table;
  final remark;
  final floor;
  final paxbfr;
  final day;
  final week;
  final todayear;
  final todayearbfr;
  final idmonth;

  const Edit_Book({
    super.key,
    required this.id,
    required this.idmonthbfr,
    required this.week,
    required this.remark,
    required this.attendance,
    required this.name,
    required this.date,
    required this.time,
    required this.phone,
    required this.event,
    required this.no_table,
    required this.day,
    required this.floor,
    required this.pax,
    required this.paxbfr,
    required this.todayear,
    required this.todayearbfr,
    required this.idmonth,
  });

  @override
  State<Edit_Book> createState() => _Edit_BookState();
}

class _Edit_BookState extends State<Edit_Book> {
  var user = FirebaseAuth.instance.currentUser;

  bool select = false;
  var status = '', newstatus = '', no = '';
  var lantai = 'floor1', selection = "", idreport;

  var selectedtable, unpackedArr = [];
  List chooseTable = [], selectedIndex = [], tableFix = [];
  String Idmonth = '', year = '', month = '', finalDate = '', monthname = '';
  List lantais = [], userData = [], tableUser = [], userLantai = [];

  _cekdata() async {
    final data = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(widget.todayear)
        .collection('user-list')
        .where('date', isEqualTo: widget.date)
        .get();
    var id = data.docs.map((e) => e.id).toList();
    for (var i = 0; i < id.length; i++) {
      setState(() {
        idreport = id[i];
      });
    }

    userLantai.clear();
    // table
    final table = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('table_master')
        .get();

    lantais = table.docs.map((e) => e.data()['lantai']).toList();
    print(lantai);
    // user
    final user = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('user_data')
        .where('date', isEqualTo: widget.date)
        .get();
    userData = user.docs.map((e) => e.data()).toList();
    // print(userData);
    for (var i = 0; i < userData.length; i++) {
      setState(() {
        userLantai.addAll(userData[i]['table_no']);

        print('lantai $userLantai');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cekdata();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    String removeMail(String userMail) {
      return userMail.replaceAll('@mail.com', '');
    }

    String getFirstName(String fullName) {
      List<String> nameParts = fullName.split(
          " "); // Membagi string nama lengkap menjadi array berdasarkan spasi
      return nameParts[0]; // Mengambil elemen pertama (nama pertama)
    }

    // log
    int generateRandomNumber(int min, int max) {
      Random random = Random(); // Membuat objek Random
      int randomNumber = min +
          random.nextInt(max -
              min +
              1); // Menghasilkan angka acak antara min dan max (inklusif)
      return randomNumber;
    }

    _addlog() async {
      print('add history');
      var tahun = DateFormat('yyyy').format(DateTime.now());
      var namaBulan = DateFormat('MMMM').format(DateTime.now());
      var months = DateFormat('d MMM yyyy').format(DateTime.now());
      var jam = DateFormat('HH:mm').format(DateTime.now());
      var doc = DateFormat('d_MM_yyyy_HH_mm_ss').format(DateTime.now());

      // adding log
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('History')
          .doc(
              'Report_${generateRandomNumber(1, 100)}_${doc}_${generateRandomNumber(1, 100)}')
          .set({
        "id": '$namaBulan $tahun',
        "bulan": months,
        "time": jam.toString(),
        "Log_Msg":
            "update data table ${widget.name} by ${getFirstName(user!.displayName!)}"
      });
    }

    _savebook() async {
      await db
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('user_data')
          .doc(widget.id)
          .update({
        'table_no': unpackedArr == ""
            ? FieldValue.arrayUnion(widget.no_table)
            : FieldValue.arrayUnion(chooseTable),
        'floor': lantai == "Choose Table Here" ? widget.floor : lantai,
      });

      _addlog();
    }

    _updatetable() async {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('user_data')
          .doc(widget.id)
          .update({
        'table_no': FieldValue.arrayUnion(widget.no_table),
        'floor': widget.floor,
      });
    }

    return WillPopScope(
      onWillPop: () async {
        _updatetable();
        Navigator.pop(context);

        return false;
      },
      child: Scaffold(
        // button

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60.h,
            child: ElevatedButton(
              onPressed: () {
                _savebook();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return splash();
                }), (r) {
                  return false;
                });
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 54, 51, 140)),
              ),
              child: const Text(
                "BOOK",
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _updatetable();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Select Slot $selection',
            style: TextStyle(
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromARGB(232, 232, 231, 231),
        ),
        backgroundColor: Color.fromARGB(232, 250, 250, 250),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              // lantai
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 300.h,
                        child: FutureBuilder(
                          future: db
                              .collection('Vsing-rsv')
                              .doc('reservation')
                              .collection('table_master')
                              .get(),
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
                            var data = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      lantai = data[index].data()['lantai'];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 235, 235, 235),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Center(
                                        child: Text(
                                          data[index].data()['lantai'],
                                          style: TextStyle(
                                            fontSize: 25.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lantai,
                        style: TextStyle(
                          fontSize: 24.sp,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 50.w,
                      )
                    ],
                  ),
                ),
              ),

              // stage
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: Center(
                  child: Text(
                    'STAGE',
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // table

              Container(
                width: MediaQuery.of(context).size.width,
                height: 400.h,
                child: StreamBuilder(
                    stream: db
                        .collection('Vsing-rsv')
                        .doc('reservation')
                        .collection('table_master')
                        .doc(lantai)
                        .collection('lantai')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("eror"),
                        );
                      }
                      if (snapshot == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data = snapshot.data!.docs;

                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 60,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10),
                          itemCount: data.length,
                          itemBuilder: (BuildContext ctx, index) {
                            if (no == 'T10') {
                              no = "U10";
                            } else if (no == 'T11') {
                              no = "U11";
                            } else if (no == 'T12') {
                              no = "U12";
                            } else if (no == 'T13') {
                              no = "U13";
                            } else if (no == 'T14') {
                              no = "U14";
                            } else if (no == 'T15') {
                              no = "U15";
                            } else if (no == 'T16') {
                              no = "U16";
                            } else if (no == 'T17') {
                              no = "U17";
                            } else if (no == 'T18') {
                              no = "U18";
                            }

                            var colorbg;
                            colorbg = Colors.grey;
                            if (userLantai.isEmpty) {
                              for (var i = 0; i < chooseTable.length; ++i) {
                                if (data[index].data()['no'] ==
                                    chooseTable[i]) {
                                  colorbg = Color.fromARGB(255, 2, 161, 234);
                                  break;
                                } else {
                                  colorbg = Colors.grey;
                                }
                              }
                            } else {
                              for (var i = 0; i < userLantai.length; ++i) {
                                if (data[index].data()['no'] == userLantai[i]) {
                                  colorbg = Color.fromARGB(255, 221, 20, 124);
                                  break;
                                } else {
                                  for (var i = 0; i < chooseTable.length; ++i) {
                                    if (data[index].data()['no'] ==
                                        chooseTable[i]) {
                                      colorbg =
                                          Color.fromARGB(255, 2, 161, 234);
                                      break;
                                    } else {
                                      colorbg = Colors.grey;
                                    }
                                  }
                                }
                              }
                              for (var i = 0; i < userLantai.length; ++i) {
                                if (data[index].data()['no'] == userLantai[i]) {
                                  colorbg = Color.fromARGB(255, 221, 20, 124);
                                  break;
                                } else {
                                  for (var i = 0; i < chooseTable.length; ++i) {
                                    if (data[index].data()['no'] ==
                                        chooseTable[i]) {
                                      colorbg =
                                          Color.fromARGB(255, 2, 161, 234);
                                      break;
                                    } else {
                                      colorbg = Colors.grey;
                                    }
                                  }
                                }
                              }
                            }

                            // for (var i = 0; i < chooseTable.length; ++i) {
                            //   if (data[index].data()['no'] == chooseTable[i]) {
                            //     colorbg = Color.fromARGB(255, 2, 161, 234);
                            //     break;
                            //   } else {
                            //     colorbg = Colors.grey;
                            //   }
                            // }

                            return InkWell(
                                onTap: (colorbg ==
                                        Color.fromARGB(255, 221, 20, 124))
                                    ? () {
                                        null;
                                      }
                                    : () {
                                        if (selectedIndex.contains(index) &&
                                            chooseTable.contains(
                                                data[index].data()['no'])) {
                                          selectedIndex.remove(index);
                                          setState(() {
                                            chooseTable.remove(
                                                data[index].data()['no']);
                                          });

                                          print(chooseTable);
                                        } else {
                                          chooseTable
                                              .add(data[index].data()['no']);

                                          setState(() {
                                            selectedIndex.add(index);
                                          });
                                          print(chooseTable);
                                        }
                                      },
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: colorbg,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(data[index].data()['no'])));
                          });
                    }),
              ),

              // info

              // available
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 15.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: Colors.grey),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Available',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // selected
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 15.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: Color.fromARGB(255, 2, 161, 234)),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Selected',
                          style: TextStyle(
                              fontSize: 20.w, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // reserved
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 15.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: Color.fromARGB(255, 221, 20, 124)),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Booked',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.event,
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        Text(
                          widget.phone,
                          style: TextStyle(
                            fontSize: 25.sp,
                          ),
                        ),
                        Text(
                          'Pax : ${widget.pax}',
                          style: TextStyle(
                            fontSize: 25.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 3.w,
                    height: 60.h,
                    color: Colors.black,
                  ),
                  Container(
                    width: 250.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Date & Time',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.time,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
