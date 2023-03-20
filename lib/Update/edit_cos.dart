import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vsing/Update/edit_table.dart';
import 'package:vsing/pages/spalsh.dart';
import 'package:vsing/style/color_constant.dart';
import 'package:intl/intl.dart';
import 'package:m_toast/m_toast.dart';

class Edit_Cos extends StatefulWidget {
  final name;
  final phone;
  final date;
  final floor;
  final no_table;
  final time;
  final pax;
  final remark;
  final attendance;
  final event;
  final bookdata;
  final paxdata;
  final id;
  final fulldate;
  final dateday;
  final week;
  final todayear;
  final idmonth;
  final bookmonth;
  final paxmonth;

  const Edit_Cos({
    super.key,
    required this.name,
    required this.week,
    required this.fulldate,
    required this.dateday,
    required this.id,
    required this.remark,
    required this.phone,
    required this.date,
    required this.floor,
    required this.no_table,
    required this.time,
    required this.pax,
    required this.attendance,
    required this.event,
    required this.bookdata,
    required this.paxdata,
    required this.todayear,
    required this.idmonth,
    required this.bookmonth,
    required this.paxmonth,
  });

  @override
  State<Edit_Cos> createState() => _Edit_CosState();
}

class _Edit_CosState extends State<Edit_Cos> {
  var user = FirebaseAuth.instance.currentUser;

  // input
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController remark = TextEditingController();

  int count = 0;
  String datetime = "";
  String time = "";
  var no = "";
  var attend = "";
  var colorbtn;
  var colortxt;
  var monthid;
  var yeartoday;
  var Dayname, weekOfMonth, day, idreport;

  // event
  var brtdy = "Brithday";
  var aniv = "Anniversary";
  var comp = "Company";
  var othr = "Bachelor Night";

  var onklik = '';
  //
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

  @override
  void initState() {
    super.initState();
    _cekdata();
    print(widget.no_table);
    onklik = widget.event;
    var pax = int.parse(widget.pax);
    assert(pax is int);

    count = pax;
    name.text = widget.name;
    number.text = widget.phone;
    remark.text = widget.remark;
    attend = widget.attendance;
    time = widget.time;
    datetime = widget.date;
    yeartoday = widget.todayear;
    monthid = widget.idmonth;
    Dayname = widget.dateday;
    weekOfMonth = widget.week;
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

    print(widget.week);
  }

  _updatetable() async {
    for (int x = 0; x < widget.no_table.length; ++x) {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(widget.todayear)
          // .collection('month')
          // .doc(widget.idmonth)
          .collection('Reservation')
          .doc(widget.date)
          .collection('table')
          .doc(widget.floor)
          .collection('lantai')
          .doc(widget.no_table[x])
          .update({'status': 'Avail'});
    }
  }

  // log activity
  String Idmonth = '';
  String year = '';
  String month = '';
  String finalDate = '', monthname = '';

  //
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

      DateFormat bulanin = DateFormat('dd MMM yyyy');
      monthname = bulanin.format(DateTime.now());

      DateFormat bulanok = DateFormat('HH:mm');
      finalDate = bulanok.format(DateTime.now());
    });
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(year)
        // .collection('month')
        // .doc(widget.idmonth)
        .collection('History')
        .doc('report_${month + finalDate}')
        .set({
      "id": '$monthname $year',
      "bulan": month,
      "time": finalDate.toString(),
      "Log_Msg": "update data ${widget.name} by ${removeMail(user!.email!)}"
    });
  }

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

  _savebook() async {
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        // .collection('month')
        // .doc(monthid)
        .collection('Reservation')
        .doc(datetime)
        .collection('user')
        .doc(name.text + count.toString() + datetime + number.text)
        .set({
      'name': name.text,
      'remark': remark.text,
      'pax': count.toString(),
      'date': datetime,
      'table_no': FieldValue.arrayUnion(widget.no_table),
      'dateday': Dayname == null ? widget.dateday : Dayname,
      'datefull': Dayname == null
          ? widget.fulldate
          : '${datetime.toString()} ${Dayname}',
      'week': weekOfMonth == null ? widget.week : weekOfMonth,
      'event': onklik,
      "phone_number": number.text,
      'floor': widget.floor,
      "attendance": attend,
      'time': time,
      'search': FieldValue.arrayUnion(
          [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
    });
  }

  _delete() async {
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(widget.todayear)
        // .collection('month')
        // .doc(widget.idmonth)
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

  // =====================================================================\\
  // book and pax func
  // =====================================================================\\

  var hasilpax;
  var hasilpaxmonth;
  _removebookpax() async {
    hasilpax = widget.paxdata - int.parse(widget.pax);
    hasilpaxmonth = widget.paxmonth - int.parse(widget.pax);

    // month
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Reservation')
        .doc(widget.date)
        .update({'pax': hasilpax});
    // day
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Book-Pax')
        .doc(monthid)
        .update({'pax': hasilpaxmonth});

    // ========================================

    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Book-Pax')
        .doc(monthid)
        .collection('Report_Weeks')
        .doc('week_${weekOfMonth}')
        .collection('reports')
        .doc(day)
        .update({'pax_datas': hasilpax});

    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Book-Pax')
        .doc(monthid)
        .collection('Report_Weeks')
        .doc('week_${weekOfMonth}')
        .collection('reports')
        .doc('total')
        .update({'pax_total': hasilpaxmonth});
  }

  _addbookpax() async {
    var paxnew = hasilpax + count;
    var pmonthnew = hasilpaxmonth + count;

    // month
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Reservation')
        .doc(widget.date)
        .update({'pax': paxnew});
    // day
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Book-Pax')
        .doc(monthid)
        .update({'pax': pmonthnew});

// ===================================================

    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Book-Pax')
        .doc(monthid)
        .collection('Report_Weeks')
        .doc('week_${weekOfMonth}')
        .collection('reports')
        .doc(day)
        .update({'pax_datas': paxnew});

    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('Book-Pax')
        .doc(monthid)
        .collection('Report_Weeks')
        .doc('week_${weekOfMonth}')
        .collection('reports')
        .doc('total')
        .update({'pax_total': pmonthnew});
  }

  _savelistcos() async {
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(yeartoday)
        .collection('user-list')
        .doc()
        .set({
      'name': name.text,
      'pax': count.toString(),
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
      'time': time,
      'search': FieldValue.arrayUnion(
          [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text(
          'VSing Ipoh Soho ',
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
              // input name
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
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 60.h,
                  child: TextFormField(
                    controller: name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),

              // phone number input
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
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // const Padding(
              //   padding: EdgeInsets.only(bottom: 40),
              //   child: _userName(),
              // ),
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
              Text(
                datetime == "" ? "Choose Date & Time" : datetime + ' - ' + time,
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 20,
                ),
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
                          child: child,
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

                    // Menggali dokumentasi ehe
                    initializeDateFormatting('id');

                    String formattedDate =
                        DateFormat.yMMMd('id').format(datetimeRet!);
                    String formatmonth =
                        DateFormat.MMM('id').format(datetimeRet);
                    if (formatmonth == 'Jan') {
                      monthid = '01';
                    } else if (formatmonth == 'Feb') {
                      monthid = '02';
                    } else if (formatmonth == 'Mar') {
                      monthid = '03';
                    } else if (formatmonth == 'Apr') {
                      monthid = '04';
                    } else if (formatmonth == 'Mei') {
                      monthid = '05';
                    } else if (formatmonth == 'Jun') {
                      monthid = '06';
                    } else if (formatmonth == 'Jul') {
                      monthid = '07';
                    } else if (formatmonth == 'Agu') {
                      monthid = '08';
                    } else if (formatmonth == 'Sep') {
                      monthid = '09';
                    } else if (formatmonth == 'Okt') {
                      monthid = '10';
                    } else if (formatmonth == 'Nov') {
                      monthid = '11';
                    } else if (formatmonth == 'Des') {
                      monthid = '12';
                    }
                    final date = DateTime(
                        datetimeRet.year,
                        datetimeRet.month,
                        datetimeRet.day,
                        selectedTime!.hour,
                        selectedTime.minute);

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
                      datetime = formattedDate;
                      time =
                          '${selectedTime.hour}:${_addMissingZero(selectedTime.minute)}';
                      yeartoday = datetimeRet.year.toString();

                      Dayname = DateFormat('EEEE').format(date);
                      print(Dayname);
                    });
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
              SizedBox(height: 10),
              Container(
                width: 200.w,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    _updatetable();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit_Book(
                                  todayearbfr: widget.todayear,
                                  bookmonth: widget.bookmonth,
                                  paxmonth: widget.paxmonth,
                                  todayear: yeartoday,
                                  idmonth: monthid,
                                  idmonthbfr: widget.idmonth,
                                  week: weekOfMonth == null
                                      ? widget.week
                                      : weekOfMonth,
                                  day: Dayname == null
                                      ? widget.dateday
                                      : Dayname,
                                  // data before
                                  paxbfr: widget.pax,
                                  bookdata: widget.bookdata,
                                  paxdata: widget.paxdata,
                                  id: widget.name +
                                      widget.pax +
                                      widget.date +
                                      widget.phone,
                                  // new
                                  attendance: attend,
                                  remark: remark.text,
                                  floor: widget.floor,
                                  no_table: widget.no_table,
                                  event: onklik,
                                  phone: number.text,
                                  name: name.text,
                                  date: datetime,
                                  time: time,
                                  pax: count.toString(),
                                )));
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 56, 43, 83),
                    ),
                  ),
                  child: Text("CHOOSE TABLE",
                      style: TextStyle(
                        fontSize: 20.sp,
                      )),
                ),
              ),
              SizedBox(height: 20.h),
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
                          setState(() {
                            onklik = brtdy;
                            print(onklik);
                          });
                        },
                        style: onklik == brtdy
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 129, 116, 211)),
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
                                        size: 20.w,
                                      )),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      style: TextStyle(fontSize: 20.sp),

                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
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
                                        size: 20.w,
                                      )),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Color(0xFF494753)),
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
                          setState(() {
                            onklik = aniv;
                            print(onklik);
                          });
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
                                        size: 20.w,
                                      )),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      style: TextStyle(
                                          color: Color(0xFF494753),
                                          fontSize: 20.sp),
                                      // overflow: Te
                                      // xtOverflow.ellipsis,
                                      textAlign: TextAlign.center,
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
                                        size: 20.w,
                                      )),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                          setState(() {
                            onklik = comp;
                            print(onklik);
                          });
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
                                      style: TextStyle(
                                          color: Color(0xFF494753),
                                          fontSize: 20.sp),
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
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
                                          fontSize: 20.sp,
                                          color: Color(0xFF494753)),
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
                          setState(() {
                            onklik = othr;
                            print(onklik);
                          });
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
                                      style: TextStyle(
                                          color: Color(0xFF494753),
                                          fontSize: 20.sp),
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
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
              // attendance
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Attendance",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              attend == 'Absent'
                  ? Container(
                      width: 210.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // _updateattendance();

                          if (attend == 'Absent') {
                            setState(() {
                              attend = 'Present';
                            });
                          } else if (attend == 'Present') {
                            setState(() {
                              attend = 'Absent';
                            });
                          }
                          ShowMToast toast = ShowMToast();

                          toast.successToast(context,
                              message:
                                  "${widget.name} has arrived please go to next page for save",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.topCenter,
                              duration: 2100);
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 210, 209, 209)),
                        ),
                        child: const Text(
                          "Absent ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 73, 71, 83),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 210.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // _updateattendance();

                          if (attend == 'Absent') {
                            setState(() {
                              attend = 'Present';
                            });
                          } else if (attend == 'Present') {
                            setState(() {
                              attend = 'Absent';
                            });
                          }
                          ShowMToast toast = ShowMToast();

                          toast.errorToast(context,
                              message: "${widget.name} not arrived",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.topCenter,
                              duration: 1500);
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 56, 43, 83),
                          ),
                        ),
                        child: const Text(
                          "Present ",
                        ),
                      ),
                    ),

              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65.h,
                  child: ElevatedButton(
                    onPressed: () {
                      _delete();
                      _removebookpax();
                      _addlog();
                      _savebook();
                      _addbookpax();
                      _savelistcos();
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return splash();
                      }), (r) {
                        return false;
                      });
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 56, 43, 83),
                      ),
                    ),
                    child: const Text(
                      "UPDATE",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
