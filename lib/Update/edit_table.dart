import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:vsing/pages/spalsh.dart';
import 'package:vsing/util/table.dart';

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
  final bookdata;
  final paxdata;
  final paxbfr;
  final day;
  final week;

  final todayear;
  final todayearbfr;
  final idmonth;
  final bookmonth;
  final paxmonth;
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
    required this.bookdata,
    required this.paxdata,
    required this.floor,
    required this.pax,
    required this.paxbfr,
    required this.todayear,
    required this.todayearbfr,
    required this.idmonth,
    required this.bookmonth,
    required this.paxmonth,
  });

  @override
  State<Edit_Book> createState() => _Edit_BookState();
}

class _Edit_BookState extends State<Edit_Book> {
  var user = FirebaseAuth.instance.currentUser;

  bool select = false;
  var status = '';
  var newstatus = '';
  var no = '';
  var lantai = 'Choose Table Here';
  var selection = "", idreport;

  var selectedtable;
  var unpackedArr = [];
  List chooseTable = [], selectedIndex = [], tableFix = [];

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
  }

  _tableEdit() {
    for (int x = 0; x < widget.no_table.length; ++x) {
      if (widget.no_table[x]
          .contains(RegExp(r'\b(?:U10|U11|U12|U13|U14|U15|U16|U17|U18)\b'))) {
        tableFix.add(widget.no_table[x].replaceAll('U', 'T'));
        // print(tableFix);
      } else {
        tableFix.add(widget.no_table[x]);
        // print(tableFix);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//     _tableEdit();

//     chooseTable = tableFix;
//     selectedIndex = tableFix;
// //
//     print(chooseTable);
//     print(selectedIndex);

    _cekdata();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    // _update() async {
    //   await db
    //       .collection('Vsing-rsv')
    //       .doc(widget.todayear)
    //       .collection('Reservation')
    //       .doc(widget.date)
    //       .collection('table')
    //       .doc(lantai)
    //       .collection('lantai')
    //       .doc(no)
    //       .update({'status': 'Selected'});
    // }

    // _updateselected() async {
    //   await db
    //       .collection('Vsing-rsv')
    //       .doc(widget.todayear)
    //       .collection('Reservation')
    //       .doc(widget.date)
    //       .collection('table')
    //       .doc(lantai)
    //       .collection('lantai')
    //       .doc(no)
    //       .update({'status': 'Avail'});
    // }

    // _getselected() async {
    //   final result = await db
    //       .collection('Vsing-rsv')
    //       .doc(widget.todayear)
    //       .collection('Reservation')
    //       .doc(widget.date)
    //       .collection('table')
    //       .doc(lantai)
    //       .collection('lantai')
    //       .where('status', isEqualTo: newstatus)
    //       .get();

    //   setState(() {
    //     selectedtable = result.docs.map((e) => e.data()).toList();
    //   });
    // }

    // // List search = [widget.name, widget.phone, widget.date];
    _searchByName() {
      var data = [];
      for (var i = 0; i < widget.name.length; i++) {
        var potongan = widget.name.substring(0, i + 1);
        data.add(potongan);
      }
      return data;
    }

    _searchByNumber() {
      var data = [];
      for (var i = 0; i < widget.phone.length; i++) {
        var potongan = widget.phone.substring(0, i + 1);
        data.add(potongan);
      }
      return data;
    }

    _searchByDate() {
      var data = [];
      for (var i = 0; i < widget.date.length; i++) {
        var potongan = widget.date.substring(0, i + 1);
        data.add(potongan);
      }
      return data;
    }

    _savebook() async {
      for (int x = 0; x < chooseTable.length; ++x) {
        if (chooseTable[x]
            .contains(RegExp(r'\b(?:T10|T11|T12|T13|T14|T15|T16|T17|T18)\b'))) {
          unpackedArr.add(chooseTable[x].replaceAll('T', 'U'));
        } else {
          unpackedArr.add(chooseTable[x]);
        }
      }
      await db
          .collection('Vsing-rsv')
          .doc(widget.todayear)
          .collection('Reservation')
          .doc(widget.date)
          .collection('user')
          .doc(widget.name + widget.pax + widget.date + widget.phone)
          .set({
        'name': widget.name,
        'remark': widget.remark,
        'pax': widget.pax,
        'date': widget.date,
        'dateday': '${widget.day}',
        'week': widget.week,
        'datefull': '${widget.date.toString()} ${widget.day}',
        'table_no': unpackedArr == ""
            ? FieldValue.arrayUnion(widget.no_table)
            // JUMP KE SINI
            : FieldValue.arrayUnion(unpackedArr),
        'event': widget.event,
        "phone_number": widget.phone,
        'floor': lantai == "Choose Table Here" ? widget.floor : lantai,
        'time': widget.time,
        "attendance": widget.attendance,
        'search': FieldValue.arrayUnion(
            [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
      });
      for (var i = 0; i < unpackedArr.length; i++) {
        await db
            .collection('Vsing-rsv')
            .doc(widget.todayear)
            .collection('Reservation')
            .doc(widget.date)
            .collection('table')
            .doc(lantai)
            .collection('lantai')
            .doc(unpackedArr[i].toString())
            .update({'status': 'Book'});
      }
    }

    // await db
    //     .collection('table')
    //     .doc(lantai)
    //     .collection('lantai')
    //     .doc(unpackedArr.join(','))
    //     .update({'status': 'Book'});

    var hasilpax;
    var hasilpaxmonth;
    _removebookpax() async {
      hasilpax = widget.paxdata - int.parse(widget.paxbfr);
      hasilpaxmonth = widget.paxmonth - int.parse(widget.paxbfr);

      // month
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(widget.todayearbfr)
          .collection('Book-Pax')
          .doc(widget.idmonthbfr)
          .update({'pax': hasilpaxmonth});
      // day
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(widget.todayearbfr)
          .collection('Reservation')
          .doc(widget.date)
          .update({'pax': hasilpax});
    }

    _addbookpax() async {
      var paxnew = hasilpax + int.parse(widget.pax);
      var pmonthnew = hasilpaxmonth + int.parse(widget.pax);

      // month
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(widget.todayear)
          .collection('Book-Pax')
          .doc(widget.idmonth)
          .update({'pax': pmonthnew});
      // day
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(widget.todayear)
          .collection('Reservation')
          .doc(widget.date)
          .update({'pax': paxnew});
    }

    // log activity
    String Idmonth = '';
    String year = '';
    String month = '';
    String finalDate = '', monthname = '';

    //
    var user = FirebaseAuth.instance.currentUser;
    String removeMail(String userMail) {
      return userMail.replaceAll('@mail.com', '');
    }

    _addlog() async {
      setState(() {
        DateFormat bulan = DateFormat('MM');
        Idmonth = bulan.format(DateTime.now());

        DateFormat tahun = DateFormat('yyyy');
        year = tahun.format(DateTime.now());

        DateFormat bulanini = DateFormat('dd MMM yyyy');
        month = bulanini.format(DateTime.now());

        DateFormat bulanin = DateFormat('MMMM');
        monthname = bulanin.format(DateTime.now());

        DateFormat bulanok = DateFormat('HH:mm');
        finalDate = bulanok.format(DateTime.now());
      });
      await db
          .collection('Vsing-rsv')
          .doc(widget.todayear)
          .collection('History')
          .doc('report_${month + finalDate}')
          .set({
        "id": '$monthname $year',
        "bulan": month,
        "time": finalDate.toString(),
        "Log_Msg": "update data ${widget.name} by ${removeMail(user!.email!)}"
      });
    }

    _del() async {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(widget.todayearbfr)
          .collection('Reservation')
          .doc(widget.date)
          .collection('user')
          .doc(widget.id)
          .delete();

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(widget.todayear)
          .collection('user-list')
          .doc(idreport)
          .delete();
    }

    return Scaffold(
      // button

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () {
              _del();
              _removebookpax();
              _addbookpax();
              // _updateTablefinal();
              _savebook();
              _addlog();
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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Select Table $selection',
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
                            .doc(widget.todayear)
                            .collection('Reservation')
                            .doc(widget.date)
                            .collection('table')
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
                                        color:
                                            Color.fromARGB(255, 235, 235, 235),
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

            // tablet

            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.h,
              child: FutureBuilder(
                  future: db
                      .collection('Vsing-rsv')
                      .doc(widget.todayear)
                      .collection('Reservation')
                      .doc(widget.date)
                      .collection('table')
                      .doc(lantai)
                      .collection('lantai')
                      .get(),
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
                    var data = snapshot.data!.docs;
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 60,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 10),
                        itemCount: data.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                              onTap: (data[index].data()['status'] == 'Avail')
                                  ? () {
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
                                      setState(() {
                                        if (selectedIndex.contains(index) &&
                                            chooseTable.contains(
                                                data[index].data()['no'])) {
                                          selectedIndex.remove(index);
                                          chooseTable
                                              .remove(data[index].data()['no']);

                                          print(chooseTable);
                                        } else {
                                          chooseTable
                                              .add(data[index].data()['no']);
                                          selectedIndex.add(index);
                                          print(chooseTable);
                                        }
                                      });
                                      // _getselected();

                                      // if (status == 'Avail') {
                                      //   _update();
                                      // } else if (status == 'Selected') {
                                      //   _updateselected();
                                      // } else if (status == 'Book') {}
                                    }
                                  : () {
                                      null;
                                    },
                              child: tableui(
                                  label: data[index].data()['no'],
                                  ceklabel: chooseTable,
                                  warna: data[index].data()['status']));
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
                            color: Color.fromARGB(255, 221, 20, 124)),
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
                            color: Color.fromARGB(255, 2, 161, 234)),
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
    );
  }
}
