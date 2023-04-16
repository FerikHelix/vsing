import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

import '../pages/spalsh.dart';

class detail_book extends StatefulWidget {
  final name;
  final id;
  final phone;
  final day;
  final pax;
  final date;
  final time;
  final no;
  final floor;
  final attendance;
  final remark;
  final event;
  final bookdata;
  final paxdata;
  final bookall;
  final paxall;
  final idmonth;
  final todayear;
  final cekuser;
  final weekofmonth;
  const detail_book({
    super.key,
    required this.name,
    required this.id,
    required this.cekuser,
    required this.phone,
    required this.day,
    required this.remark,
    required this.attendance,
    required this.pax,
    required this.date,
    required this.time,
    required this.no,
    required this.event,
    required this.floor,
    required this.bookdata,
    required this.paxdata,
    required this.bookall,
    required this.paxall,
    required this.idmonth,
    required this.todayear,
    required this.weekofmonth,
  });

  @override
  State<detail_book> createState() => _detail_bookState();
}

class _detail_bookState extends State<detail_book> {
  var bookday,
      paxday,
      booktotal,
      paxtotal,
      todayear,
      monthnow,
      idmonth,
      week,
      day,
      bookselect,
      paxselect;
  var user = FirebaseAuth.instance.currentUser;

  _cekdatas() async {
    DateFormat tahun = DateFormat('yyyy');
    todayear = tahun.format(DateTime.now());

    DateFormat now = DateFormat('MMM');
    monthnow = now.format(DateTime.now());

    if (monthnow == 'Jan') {
      idmonth = '01';
    } else if (monthnow == 'Feb') {
      idmonth = '02';
    } else if (monthnow == 'Mar') {
      idmonth = '03';
    } else if (monthnow == 'Apr') {
      idmonth = '04';
    } else if (monthnow == 'Mei') {
      idmonth = '05';
    } else if (monthnow == 'Jun') {
      idmonth = '06';
    } else if (monthnow == 'Jul') {
      idmonth = '07';
    } else if (monthnow == 'Agu') {
      idmonth = '08';
    } else if (monthnow == 'Sep') {
      idmonth = '09';
    } else if (monthnow == 'Okt') {
      idmonth = '10';
    } else if (monthnow == 'Nov') {
      idmonth = '11';
    } else if (monthnow == 'Des') {
      idmonth = '12';
    }

    if (widget.day == 'Sunday') {
      day = 'sun';
    } else if (widget.day == 'Monday') {
      day = 'mon';
    } else if (widget.day == 'Tuesday') {
      day = 'tue';
    } else if (widget.day == 'Wednesday') {
      day = 'wed';
    } else if (widget.day == 'Thursday') {
      day = 'thu';
    } else if (widget.day == 'Saturday') {
      day = 'sat';
    } else if (widget.day == 'Friday') {
      day = 'fri';
    }

    // ==============================================
    final dataq = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_${widget.weekofmonth}')
        .collection('reports')
        .where('day', isEqualTo: day)
        .get();

    var dq = dataq.docs.map((e) => e.data()).toList();
    for (int x = 0; x < dq.length; ++x) {
      bookday = dq[x]['book_datas'];
      paxday = dq[x]['pax_datas'];

      // print('week ${widget.weekofmonth} = $bookday , $paxday');
    }
    final total = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_${widget.weekofmonth}')
        .collection('reports')
        .where('day', isEqualTo: 'total')
        .get();

    var ttl = total.docs.map((e) => e.data()).toList();

    for (int s = 0; s < ttl.length; ++s) {
      booktotal = ttl[s]['book_total'];
      paxtotal = ttl[s]['pax_total'];
      // print('total = $booktotal , $paxtotal');
    }
  }

  reportdata() async {
    // Current date and time of system
    // ==============================================
    var book = widget.bookdata + bookday;
    var pax = widget.paxdata + paxday;
    var bmonth = widget.bookdata + booktotal;
    var pmonth = widget.paxdata + paxtotal;

    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_${widget.weekofmonth}')
        .collection('reports')
        .doc(day)
        .set({'book_datas': book, 'pax_datas': pax, 'day': day});

    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_${widget.weekofmonth}')
        .collection('reports')
        .doc('total')
        .set({'book_total': bmonth, 'pax_total': pmonth, 'day': 'total'});
  }

  _cekbookpax() async {
    final data = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Day')
        .where('date', isEqualTo: '${widget.date}')
        .get();

    var da = data.docs.map((e) => e.data()).toList();

    for (int x = 0; x < da.length; ++x) {
      setState(() {
        bookselect = da[x]['book'];
        paxselect = da[x]['pax'];

        print(bookselect);
        print(paxselect);
      });
    }
  }

  // =====================================================================\\
  // del func
  // =====================================================================\\
  _deleteData() async {
    // update table
    for (int x = 0; x < widget.no.length; ++x) {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('table_master')
          .doc(widget.floor)
          .collection('lantai')
          .doc(widget.no[x])
          .update({'status': 'Avail'});
    }

    // delete data
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('user_data')
        .doc(widget.id)
        .delete();
  }

  _bookpax() async {
    // // day
    // await FirebaseFirestore.instance
    //     .collection('Vsing-rsv')
    //     .doc('reservation')
    //     .collection('book-pax')
    //     .doc(idmonth)
    //     .collection('Report_Day')
    //     .doc(widget.date)
    //     .update(
    //         {'book': bookselect - 1, 'pax': paxselect - int.parse(widget.pax)});
    // month
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(widget.idmonth)
        .update({
      'book': widget.bookall - 1,
      'pax': widget.paxall - int.parse(widget.pax)
    });
  }

  // =====================================================================\\
  // history log
  // =====================================================================\\
  String Idmonth = '';
  String year = '';
  String month = '';
  String finalDate = '', monthname = '';

  String removeMail(String userMail) {
    return userMail.replaceAll('@mail.com', '');
  }

  // log
  String getFirstName(String fullName) {
    List<String> nameParts = fullName.split(
        " "); // Membagi string nama lengkap menjadi array berdasarkan spasi
    return nameParts[0]; // Mengambil elemen pertama (nama pertama)
  }

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
          "booking for ${widget.name} has been delete By ${getFirstName(user!.displayName!)}"
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cekdatas();
  }

  @override
  Widget build(BuildContext context) {
    // =====================================================================\\
    // variable
    // =====================================================================\\
    var color;
    var icon;
    var iconattend;
    var hasilbook;
    var hasilpax;

    // =====================================================================\\
    // colors and icons
    // =====================================================================\\
    if (widget.attendance == 'Present') {
      widget.cekuser != 'Staff'
          ? iconattend = Positioned(
              right: 75,
              top: 10,
              child: Center(
                child: Image.asset(
                  'lib/assets/ceklis.png',
                  width: 80.w,
                  opacity: const AlwaysStoppedAnimation(.5),
                ),
              ),
            )
          : iconattend = Positioned(
              right: 25,
              top: 10,
              child: Center(
                child: Image.asset(
                  'lib/assets/ceklis.png',
                  width: 80.w,
                  opacity: const AlwaysStoppedAnimation(.5),
                ),
              ),
            );
    }

    if (widget.event == 'Birthday') {
      color = Color.fromARGB(255, 189, 183, 223);
      icon = FaIcon(
        FontAwesomeIcons.cakeCandles,
        color: Color.fromARGB(255, 54, 51, 140),
        size: 20.w,
      );
    } else if (widget.event == 'Anniversary') {
      color = Color.fromARGB(255, 238, 212, 199);
      icon = FaIcon(
        FontAwesomeIcons.solidHeart,
        color: Color.fromARGB(255, 246, 46, 46),
        size: 20.w,
      );
    } else if (widget.event == 'Company') {
      color = Color.fromARGB(255, 166, 166, 175);
      icon = Icon(
        Icons.business_center,
        color: Color.fromARGB(255, 121, 75, 40),
        size: 20.w,
      );
    } else if (widget.event == 'Bachelor Night') {
      color = Color.fromARGB(255, 166, 208, 204);
      icon = Icon(
        Icons.group,
        color: Color.fromARGB(255, 105, 88, 214),
        size: 20.w,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 115.h,
        decoration: BoxDecoration(
            color: widget.event == '' ? Colors.white : color,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
          child: Stack(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.name}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          widget.phone,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        Row(
                          children: [
                            Text(
                              "Pax : ${widget.pax} - ${widget.event}  ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            widget.event == '' ? SizedBox() : icon
                          ],
                        ),
                        Text(
                          "Slot : ${(widget.no.join(" , ").contains(RegExp(r'\b(?:U10|U11|U12|U13|U14|U15|U16|U17|U18)\b')) ? widget.no.join(" , ").replaceAll('U', 'T') : widget.no.join(","))} ${widget.floor}",
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ],
                    )),
                    Container(
                      width: 2.5.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20.r)),
                    ),
                    Container(
                      width: 150.w,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Date & Time",
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "${widget.date}",
                            style: TextStyle(
                                fontSize: 19.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.time}",
                            style: TextStyle(
                                fontSize: 19.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    widget.cekuser != 'Staff'
                        ? Container(
                            width: 2.5.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                          )
                        : SizedBox(),
                    widget.cekuser == 'Staff'
                        ? SizedBox()
                        : Container(
                            width: 80.w,
                            child: IconButton(
                                onPressed: () async {
                                  _cekbookpax();

                                  NAlertDialog(
                                    dialogStyle:
                                        DialogStyle(titleDivider: true),
                                    title: Text(
                                      "Delete",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text("Delete This Booking ?...",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                        )),
                                    actions: <Widget>[
                                      TextButton(
                                          child: Text("Okay",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Color.fromARGB(
                                                      255, 192, 34, 23))),
                                          onPressed: () {
                                            // _bookpax();
                                            _deleteData();
                                            _addlog();

                                            Navigator.pushAndRemoveUntil(
                                                context, MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                              return splash();
                                            }), (r) {
                                              return false;
                                            });
                                          }),
                                      TextButton(
                                          child: Text("Cancel",
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Color.fromARGB(
                                                    255, 54, 51, 140),
                                              )),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  ).show(context);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 25,
                                )),
                          ),
                  ],
                ),
              ),
              widget.attendance != 'Absent' ? iconattend : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
