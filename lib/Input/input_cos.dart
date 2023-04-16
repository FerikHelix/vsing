import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:m_toast/m_toast.dart';
import 'package:vsing/style/color_constant.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pages/spalsh.dart';
import '../util/notif.dart';

class TableDetails extends StatefulWidget {
  const TableDetails({super.key});

  @override
  State<TableDetails> createState() => _TableDetailsState();
}

class _TableDetailsState extends State<TableDetails> {
  NotifServis notifServis = NotifServis();
  NotifServisHariH notifServisHariH = NotifServisHariH();
  @override
  void initState() {
    super.initState();
    notifServis.initNotif();
    notifServisHariH.initNotif();

    var datenow = DateTime.now();

    // Membuat objek DocumentReference untuk dokumen yang akan ditambahkan
  }

  // =====================================================================\\
  // variable and input
  // =====================================================================\\
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController remark = TextEditingController();
  int count = 0;
  String datetime = "", time = "", today = '', year = '';
  String month = '', idmonth = '', bpmonth = '', idmonthBfr = '';

  int bookdata = 0, paxdata = 0;
  var bookmonth = 0, paxmonth = 0, datetimenow, datetimebefornow;
  var second, now, finalDate, Dayname, weekOfMonth;
  var monthnama, day, bookday, paxday;
  var booktotal, paxtotal, todayear;
  var brtdy = "Birthday",
      aniv = "Anniversary",
      comp = "Company",
      othr = "Bachelor Night";

  var onklik = '', color, monthFinal;

  bool isSameDate = false;

  @override
  Widget build(BuildContext context) {
    // =====================================================================\\
    // color cek
    // =====================================================================\\

    if (onklik == 'Brithday') {
      color = Color.fromARGB(255, 39, 83, 171);
    } else if (onklik == 'Anniversary') {
      color = Color.fromARGB(255, 237, 84, 84);
    } else if (onklik == 'Company') {
      color = Color.fromARGB(255, 128, 85, 140);
    } else if (onklik == 'Bachelor Night') {
      color = Color.fromARGB(255, 28, 103, 88);
    }

    // =====================================================================\\
    // add table
    // =====================================================================\\

    _cekdatas() async {
      print(DateFormat('ss').format(DateTime.now()));
      print(idmonth);
      print(idmonthBfr);
      if (Dayname == 'Sunday') {
        setState(() {
          day = 'sun';
        });
      } else if (Dayname == 'Monday') {
        setState(() {
          day = 'mon';
        });
      } else if (Dayname == 'Tuesday') {
        setState(() {
          day = 'tue';
        });
      } else if (Dayname == 'Wednesday') {
        setState(() {
          day = 'wed';
        });
      } else if (Dayname == 'Thursday') {
        setState(() {
          day = 'thu';
        });
      } else if (Dayname == 'Saturday') {
        setState(() {
          day = 'sat';
        });
      } else if (Dayname == 'Friday') {
        setState(() {
          day = 'fri';
        });
      }
      // ==============================================
      final dataq = await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('book-pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .where('day', isEqualTo: day)
          .get();

      var dq = dataq.docs.map((e) => e.data()).toList();

      for (int x = 0; x < dq.length; ++x) {
        setState(() {
          bookday = dq[x]['book_datas'];
          paxday = dq[x]['pax_datas'];

          print('day = $bookday, $paxday');
        });
      }
      final total = await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('book-pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .where('day', isEqualTo: 'total')
          .get();

      var ttl = total.docs.map((e) => e.data()).toList();

      for (int s = 0; s < ttl.length; ++s) {
        setState(() {
          booktotal = ttl[s]['book_total'];
          paxtotal = ttl[s]['pax_total'];
          print('ttl = $booktotal, $paxtotal');
        });
      }
    }

    var user = FirebaseAuth.instance.currentUser;

    _searchByName() {
      var data = [];
      for (var i = 0; i < name.text.length; i++) {
        var potongan = name.text.substring(0, i + 1);
        data.add(potongan);
      }
      return data;
    }

    _searchByNumber() {
      var data = [];
      for (var i = 0; i < number.text.length; i++) {
        var potongan = number.text.substring(0, i + 1);
        data.add(potongan);
      }
      return data;
    }

    _searchByDate() {
      var data = [];
      for (var i = 0; i < datetime.length; i++) {
        var potongan = datetime.substring(0, i + 1);
        data.add(potongan);
      }
      return data;
    }

    _bookpax() async {
      print('save book');
      // save book_pax week_day
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('book-pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .doc(day)
          .set({
        'book_datas': 1 + bookday,
        'pax_datas': count + paxday,
        'day': day
      });

      // save book_pax total week_day
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('book-pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .doc('total')
          .set({
        'book_total': 1 + booktotal,
        'pax_total': count + paxtotal,
        'day': 'total'
      });
    }

    _bookpaxBfr() async {
      print('rmv Bfr');
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('book-pax')
          .doc(idmonthBfr)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .doc(day)
          .set({'book_datas': 0, 'pax_datas': 0, 'day': day});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('book-pax')
          .doc(idmonthBfr)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .doc('total')
          .set({'book_total': 0, 'pax_total': 0, 'day': 'total'});
    }

    _savebook() async {
      // Membuat objek DocumentReference untuk dokumen yang akan ditambahkan
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('user_data');
      DocumentReference docRef = collectionRef.doc();

      // Mendapatkan ID dari dokumen yang baru ditambahkan
      String docId = docRef.id;

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('user_data')
          .doc(docId)
          .set({
        'month': monthFinal,
        'id': docId,
        'name': name.text,
        'pax': count,
        'remark': remark.text,
        'datefull': '${datetime.toString()} ${Dayname}',
        'dateday': '${Dayname}',
        'week': weekOfMonth,
        'date': datetime.toString(),
        'table_no': [],
        'event': onklik,
        "phone_number": number.text,
        'floor': "",
        "attendance": 'Absent',
        "promo": "",
        "promo_detail": '',
        'time': time,
        'search': FieldValue.arrayUnion(
            [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
      });
      // save userlist
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc('reservation')
          .collection('user-list')
          .doc(docId)
          .set({
        'month': monthFinal,
        'id': docId,
        'name': name.text,
        'pax': count,
        'remark': remark.text,
        'datefull': '${datetime.toString()} ${Dayname}',
        'dateday': '${Dayname}',
        'week': weekOfMonth,
        'date': datetime.toString(),
        'table_no': [],
        'event': onklik,
        "phone_number": number.text,
        'floor': "",
        "promo": "",
        "promo_detail0": '',
        "attendance": 'Absent',
        'time': time,
        'search': FieldValue.arrayUnion(
            [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
      });
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
            "new booking for ${name.text}_${number.text}. Input By ${getFirstName(user!.displayName!)}"
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text(
          'VSing Ipoh Soho',
          style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(232, 232, 231, 231),
      ),
      backgroundColor: Color.fromARGB(232, 250, 250, 250),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              // =====================================================================\\
              // input name
              // =====================================================================\\
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Name",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 60.h,
                  child: TextFormField(
                    controller: name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.sp),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                ),
              ),

              // =====================================================================\\
              // input phone number
              // =====================================================================\\
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Phone Number",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 60.h,
                  child: TextFormField(
                    controller: number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.sp),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // =====================================================================\\
              // input pax
              // =====================================================================\\

              Text(
                "Pax",
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 23.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // minus btn
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (count > 0) {
                            count -= 1;
                          } else {
                            // do nothing
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 45.w,
                        color: Color.fromARGB(255, 56, 43, 83),
                      )),
                  SizedBox(width: 20.h),
                  Text(
                    count.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(primaryColor),
                      fontSize: 40.sp,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  // Plus btn
                  IconButton(
                      onPressed: () {
                        setState(() {
                          count += 1;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle,
                        size: 45.w,
                        color: Color.fromARGB(255, 56, 43, 83),
                      )),
                ],
              ),
              SizedBox(height: 20.h),
              // =====================================================================\\
              // pick a date
              // =====================================================================\\
              Text(
                datetime == "" ? "Choose Date & Time" : datetime + ' - ' + time,
                style: TextStyle(color: Color(primaryColor), fontSize: 23.sp),
              ),
              SizedBox(height: 10.h),
              Container(
                width: 180.w,
                // height: 100,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 56, 43, 83),
                    ),
                  ),
                  onPressed: () async {
                    var datetimeRet = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Color.fromARGB(
                                  255, 85, 71, 117), // <-- SEE HERE
                              onPrimary: Color.fromARGB(
                                  255, 255, 255, 255), // <-- SEE HERE
                              onSurface: Color.fromARGB(
                                  255, 85, 71, 117), // <-- SEE HERE
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: Color.fromARGB(
                                    255, 85, 71, 117), // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    var selectedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Color.fromARGB(
                                  255, 85, 71, 117), // <-- SEE HERE
                              onPrimary: Color.fromARGB(
                                  255, 255, 255, 255), // <-- SEE HERE
                              onSurface: Color.fromARGB(
                                  255, 85, 71, 117), // <-- SEE HERE
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: Color.fromARGB(
                                    255, 85, 71, 117), // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                      context: context,
                    );
                    String _addMissingZero(int minute) {
                      if (minute < 10) {
                        return '0$minute';
                      } else {
                        return minute.toString();
                      }
                    }

                    initializeDateFormatting('id');
                    String formattedDate =
                        DateFormat.yMMMd('id').format(datetimeRet!);

                    String formatmonth =
                        DateFormat.MMM('id').format(datetimeRet);
                    String formatyear = DateFormat.y('id').format(datetimeRet);

                    if (formatmonth == 'Jan') {
                      idmonth = '01';
                      idmonthBfr = '11';
                    } else if (formatmonth == 'Feb') {
                      idmonth = '02';
                      idmonthBfr = '12';
                    } else if (formatmonth == 'Mar') {
                      idmonth = '03';
                      idmonthBfr = '01';
                    } else if (formatmonth == 'Apr') {
                      idmonth = '04';
                      idmonthBfr = '02';
                    } else if (formatmonth == 'Mei') {
                      idmonth = '05';
                      idmonthBfr = '03';
                    } else if (formatmonth == 'Jun') {
                      idmonth = '06';
                      idmonthBfr = '04';
                    } else if (formatmonth == 'Jul') {
                      idmonth = '07';
                      idmonthBfr = '05';
                    } else if (formatmonth == 'Agu') {
                      idmonth = '08';
                      idmonthBfr = '06';
                    } else if (formatmonth == 'Sep') {
                      idmonth = '09';
                      idmonthBfr = '07';
                    } else if (formatmonth == 'Okt') {
                      idmonth = '10';
                      idmonthBfr = '08';
                    } else if (formatmonth == 'Nov') {
                      idmonth = '11';
                      idmonthBfr = '09';
                    } else if (formatmonth == 'Des') {
                      idmonth = '12';
                      idmonthBfr = '10';
                    }
                    datetime = formattedDate;
                    today = formattedDate;
                    time =
                        '${selectedTime!.hour}:${_addMissingZero(selectedTime.minute)}';
                    year = datetimeRet.year.toString();
                    final date = DateTime(
                        datetimeRet.year,
                        datetimeRet.month,
                        datetimeRet.day,
                        selectedTime.hour,
                        selectedTime.minute);

                    final dt1 = date.subtract(Duration(days: 1));
                    final dt2 = dt1.subtract(Duration(minutes: 60));
                    final dt3 = date.subtract(Duration(minutes: 60));

                    // week datas
                    // String datse = date.toString();
                    String firstDayWeek = date.toString().substring(0, 8) +
                        '01' +
                        date.toString().substring(10);
                    int weekDay = DateTime.parse(firstDayWeek).weekday;
                    DateTime testDate = date;

                    weekDay--;
                    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
                    weekDay++;

                    if (weekDay == 7) {
                      weekDay = 0;
                    }
                    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();

                    setState(() {
                      bpmonth = formatmonth;
                      finalDate = time;
                      var now = DateTime.now();
                      var notif = DateFormat('yyy MM d').format(now);
                      monthFinal = DateFormat('MMM').format(date);

                      second = DateFormat('SSSS').format(now);
                      Dayname = DateFormat('EEEE').format(date);
                      datetimenow = dt3;
                      datetimebefornow = dt2;
                    });

                    _cekdatas();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 23.w,
                      ),
                      Text(
                        "Pick a date",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // =====================================================================\\
              // input remark
              // =====================================================================\\
              Text("Book For",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 23.sp,
                  )),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // brtdy
                  SizedBox(
                    width: 200.w,
                    height: 50.h,
                    child: ElevatedButton(
                        onPressed: () {
                          if (onklik != brtdy) {
                            setState(() {
                              onklik = brtdy;
                            });
                          } else if (onklik == brtdy) {
                            setState(() {
                              onklik = '';
                            });
                          }
                        },
                        style: onklik == brtdy
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 165, 133, 239)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == brtdy
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20.w,
                                      child: FaIcon(
                                        FontAwesomeIcons.cakeCandles,
                                        size: 25.w,
                                      )),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20.w,
                                      child: FaIcon(
                                        FontAwesomeIcons.cakeCandles,
                                        color: Color(0xFF494753),
                                        size: 25.h,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF494753),
                                          fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                  // anniv
                  SizedBox(
                    width: 200.w,
                    height: 50.h,
                    child: ElevatedButton(
                        onPressed: () {
                          if (onklik != aniv) {
                            setState(() {
                              onklik = aniv;
                            });
                          } else if (onklik == aniv) {
                            setState(() {
                              onklik = '';
                            });
                          }
                        },
                        style: onklik == aniv
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 247, 156, 177)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == aniv
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20.w,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        size: 25.w,
                                      )),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20.w,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Color(0xFF494753),
                                        size: 25.w,
                                      )),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF494753),
                                          fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // company
                  SizedBox(
                    width: 200.w,
                    height: 50.h,
                    child: ElevatedButton(
                        onPressed: () {
                          if (onklik != comp) {
                            setState(() {
                              onklik = comp;
                            });
                          } else if (onklik == comp) {
                            setState(() {
                              onklik = '';
                            });
                          }
                        },
                        style: onklik == comp
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 140, 155, 160)))
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == comp
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20.w,
                                      child: Icon(Icons.business_center)),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      comp,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20.w,
                                      child: Icon(Icons.business_center,
                                          color: Color(0xFF494753))),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      comp,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF494753),
                                          fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                  // bachelor
                  SizedBox(
                    width: 200.w,
                    height: 50.h,
                    child: ElevatedButton(
                        onPressed: () {
                          if (onklik != othr) {
                            setState(() {
                              onklik = othr;
                            });
                          } else if (onklik == othr) {
                            setState(() {
                              onklik = '';
                            });
                          }
                        },
                        style: onklik == othr
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 86, 153, 109)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == othr
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20.w, child: Icon(Icons.group)),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      othr,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20.w,
                                      child: Icon(Icons.group,
                                          color: Color(0xFF494753))),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      othr,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF494753),
                                          fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Remark",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 60.h,
                  child: TextFormField(
                    controller: remark,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.sp),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 65.h,
                    child: ElevatedButton(
                      onPressed: () {
                        if (datetime == '' || time == '') {
                          ShowMToast toast = ShowMToast();
                          toast.errorToast(context,
                              message: "Please Pick A Date",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.center,
                              duration: 1500);
                        } else if (name.text == '') {
                          ShowMToast toast = ShowMToast();
                          toast.errorToast(context,
                              message: "Please Input Name",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.center,
                              duration: 1500);
                        } else if (number.text == '') {
                          ShowMToast toast = ShowMToast();
                          toast.errorToast(context,
                              message: "Please Input Number Phone",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.center,
                              duration: 1500);
                        } else if (count == 0) {
                          ShowMToast toast = ShowMToast();
                          toast.errorToast(context,
                              message: "Please Input Pax at Least 1 ",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.center,
                              duration: 1500);
                        } else {
                          _addlog();
                          _savebook();
                          _bookpaxBfr();
                          _bookpax();
                          // _bookdatasday();

                          if (onklik != '' && datetime != datetimenow) {
                            notifServis.sendNotif(
                                int.parse(second),
                                "Reminder!",
                                "${name.text} - ${onklik}",
                                datetimebefornow);
                          } else if (datetime == datetimenow) {
                            notifServisHariH.sendNotif(
                                int.parse(second),
                                "Reminder!",
                                "${name.text} - ${onklik}",
                                datetimenow);
                          }
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return splash();
                          }), (r) {
                            return false;
                          });
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 56, 43, 83)),
                      ),
                      child: const Text(
                        "Book",
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
