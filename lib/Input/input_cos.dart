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
  }

  // =====================================================================\\
  // variable and input
  // =====================================================================\\
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController remark = TextEditingController();
  int count = 0;
  String datetime = "";
  String time = "";
  String today = '';
  String year = '';
  String month = '';
  String idmonth = '';
  String bpmonth = '';

  int bookdata = 0, paxdata = 0;
  var bookmonth = 0,
      paxmonth = 0,
      datetimenow,
      datetimebefornow,
      second,
      now,
      finalDate,
      Dayname,
      weekOfMonth,
      monthnama,
      day,
      bookday,
      paxday,
      booktotal,
      paxtotal,
      todayear,
      brtdy = "Brithday",
      aniv = "Anniversary",
      comp = "Company",
      othr = "Bachelor Night";

  var onklik = '';
  bool isSameDate = false;

  @override
  Widget build(BuildContext context) {
    // =====================================================================\\
    // color cek
    // =====================================================================\\
    var color;
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
      DateFormat tahun = DateFormat('yyyy');
      todayear = tahun.format(DateTime.now());

      // DateFormat now = DateFormat('MMM');
      // var monthnow = now.format(DateTime.now());

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
          .doc(todayear)
          .collection('Book-Pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .where('day', isEqualTo: day)
          .get();

      var dq = dataq.docs.map((e) => e.data()).toList();
      print('\n\n\n');
      print(todayear);
      print(idmonth);
      print(' .$todayear .$idmonth .week_${weekOfMonth} .$day');
      print(Dayname);
      print('\n\n\n');

      for (int x = 0; x < dq.length; ++x) {
        setState(() {
          bookday = dq[x]['book_datas'];
          paxday = dq[x]['pax_datas'];
        });
      }
      final total = await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(todayear)
          .collection('Book-Pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .where('day', isEqualTo: 'total')
          .get();

      var ttl = total.docs.map((e) => e.data()).toList();
      print(ttl);

      for (int s = 0; s < ttl.length; ++s) {
        setState(() {
          booktotal = ttl[s]['book_total'];
          paxtotal = ttl[s]['pax_total'];

          print('===========================');
          print(bookday);
          print(paxday);
          print('===========================');
          print(booktotal);
          print(paxtotal);
          print('===========================');
        });
      }
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

    _bookpax() async {
      var book = bookdata + 1;
      var pax = paxdata + count;
      var bmonth = bookmonth + 1;
      var pmonth = paxmonth + count;

      var books = bookdata + 1;
      var paxs = paxdata + count;
      var bmonths = 1 + booktotal;
      var pmonths = count + paxtotal;

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(todayear)
          .collection('Book-Pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .doc(day)
          .update({'book_datas': books, 'pax_datas': paxs});

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(todayear)
          .collection('Book-Pax')
          .doc(idmonth)
          .collection('Report_Weeks')
          .doc('week_${weekOfMonth}')
          .collection('reports')
          .doc('total')
          .update({'book_total': bmonths, 'pax_total': pmonths});

      // ==============================================

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(todayear)
          // .collection('month')
          // .doc(idmonth)

          .collection('Book-Pax')
          .doc(idmonth)
          .update({'book': bmonth, 'pax': pmonth});
      // day
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(todayear)
          // .collection('month')
          // .doc(idmonth)

          .collection('Reservation')
          .doc(datetime)
          .update({'book': book, 'pax': pax});

      print('Book report : $books , Pax report : $paxs ');
      print('Book : $book , Pax : $pax ');
    }

    var user = FirebaseAuth.instance.currentUser;
    String removeMail(String userMail) {
      return userMail.replaceAll('@mail.com', '');
    }

    _addlog() async {
      setState(() {
        DateFormat tahun = DateFormat('yyyy');
        year = tahun.format(DateTime.now());

        DateFormat bulanini = DateFormat('dd MMM yyyy');
        month = bulanini.format(DateTime.now());

        DateFormat monthname = DateFormat('MMMM');
        monthnama = monthname.format(DateTime.now());

        DateFormat bulanok = DateFormat('HH:mm');
        finalDate = bulanok.format(DateTime.now());
      });

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)

          .collection('History')
          .doc('report_${month + finalDate}')
          .set({
        "id": '$monthnama $year',
        "bulan": month,
        "time": finalDate.toString(),
        "Log_Msg":
            "new booking for ${name.text}_${number.text}. Input By ${removeMail(user!.email!)}"
      });
    }

    _savelistcos() async {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
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

    _savebook() async {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)

          .collection('Reservation')
          .doc(datetime)
          .set({'pax': 0, 'book': 0, 'date': datetime});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('user')
          .doc(
              '${name.text}${count.toString()}${datetime.toString()}${number.text}')
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

    _addtable() async {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .set({'date': datetime, 'book': 0, 'pax': 0, 'status': true});

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .set({
        'lantai': 'floor1',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor2')
          .set({
        'lantai': 'floor2',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('S1')
          .set({
        'no': 'S1',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('S2')
          .set({
        'no': 'S2',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('S3')
          .set({
        'no': 'S3',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T1')
          .set({
        'no': 'T1',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T2')
          .set({
        'no': 'T2',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T3')
          .set({
        'no': 'T3',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T4')
          .set({
        'no': 'T4',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T5')
          .set({
        'no': 'T5',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T6')
          .set({
        'no': 'T6',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T7')
          .set({
        'no': 'T7',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T7')
          .set({
        'no': 'T7',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T8')
          .set({
        'no': 'T8',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('T9')
          .set({
        'no': 'T9',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U10')
          .set({
        'no': 'T10',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U11')
          .set({
        'no': 'T11',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U12')
          .set({
        'no': 'T12',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U13')
          .set({
        'no': 'T13',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U14')
          .set({
        'no': 'T14',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U15')
          .set({
        'no': 'T15',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U16')
          .set({
        'no': 'T16',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U17')
          .set({
        'no': 'T17',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor1')
          .collection('lantai')
          .doc('U18')
          .set({
        'no': 'T18',
        'status': 'Avail',
      });

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor2')
          .collection('lantai')
          .doc('VIP1')
          .set({
        'no': 'VIP1',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor2')
          .collection('lantai')
          .doc('VIP2')
          .set({
        'no': 'VIP2',
        'status': 'Avail',
      });
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc('floor2')
          .collection('lantai')
          .doc('VIP3')
          .set({
        'no': 'VIP3',
        'status': 'Avail',
      });
    }

    _addtablenew() async {
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .set({
        'date': datetime,
        'book': 0,
        'pax': 0,
      });

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 1, 'type': 'S', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 2, 'type': 'S', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 3, 'type': 'S', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 1, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 2, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 3, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 4, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 5, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 6, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 7, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 8, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 9, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 10, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 11, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 12, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 13, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 14, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 15, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 16, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 17, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 18, 'type': 'T', 'status': 'Avail', 'floor': 'floor1'});

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 1, 'type': 'VIP', 'status': 'Avail', 'floor': 'floor2'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 2, 'type': 'VIP', 'status': 'Avail', 'floor': 'floor2'});
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          // .collection('month')
          // .doc(idmonth)
          .collection('Reservation')
          .doc(datetime)
          .collection('table')
          .doc()
          .set({'no': 3, 'type': 'VIP', 'status': 'Avail', 'floor': 'floor2'});
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
                    } else if (formatmonth == 'Feb') {
                      idmonth = '02';
                    } else if (formatmonth == 'Mar') {
                      idmonth = '03';
                    } else if (formatmonth == 'Apr') {
                      idmonth = '04';
                    } else if (formatmonth == 'Mei') {
                      idmonth = '05';
                    } else if (formatmonth == 'Jun') {
                      idmonth = '06';
                    } else if (formatmonth == 'Jul') {
                      idmonth = '07';
                    } else if (formatmonth == 'Agu') {
                      idmonth = '08';
                    } else if (formatmonth == 'Sep') {
                      idmonth = '09';
                    } else if (formatmonth == 'Okt') {
                      idmonth = '10';
                    } else if (formatmonth == 'Nov') {
                      idmonth = '11';
                    } else if (formatmonth == 'Des') {
                      idmonth = '12';
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
                      var now = DateTime.now();
                      var notif = DateFormat('yyy MM d').format(now);

                      second = DateFormat('SSSS').format(now);
                      Dayname = DateFormat('EEEE').format(date);
                      datetimenow = dt3;
                      datetimebefornow = dt2;

                      _cekdatas();

                      print('\n\n\n');
                      print('tes month : $bpmonth');
                      print('tes date : $date');

                      print(datetimebefornow);
                      print(datetimenow);
                      print(second);
                      print(Dayname);
                      print(weekOfMonth);

                      print('\n\n\n');
                    });

                    void _detectIsDateSame() async {
                      // Detect is date selected inside there or not
                      final data = await FirebaseFirestore.instance
                          .collection('Vsing-rsv')
                          .doc(year)
                          // .collection('month')
                          // .doc(idmonth)
                          .collection('Reservation')
                          .get();
                      var tes = data.docs.map((e) => e.data()).toList();

                      for (int x = 0; x <= tes.length - 1; ++x) {
                        if (tes[x]['date'] == datetime) {
                          setState(() {
                            // today data
                            bookdata = tes[x]['book'];
                            paxdata = tes[x]['pax'];

                            print("\n\n\n");
                            print("=================================");
                            print(bookdata);
                            print(paxdata);

                            print("=================================");
                            print("\n\n\n");
                          });
                          isSameDate = true;
                          break;
                        } else {
                          // today data
                          bookdata = 0;
                          paxdata = 0;

                          isSameDate = false;
                        }
                      }

                      print("=================================");
                      print(isSameDate);
                    }

                    _cekmonthbookpax() async {
                      final datamonth = await FirebaseFirestore.instance
                          .collection('Vsing-rsv')
                          .doc(year)
                          .collection('Book-Pax')
                          .get();
                      var tesdatamonth =
                          datamonth.docs.map((e) => e.data()).toList();
                      for (int y = 0; y <= tesdatamonth.length - 1; ++y) {
                        if (tesdatamonth[y]['Id'] == idmonth) {
                          // month data
                          bookmonth = tesdatamonth[y]['book'];
                          paxmonth = tesdatamonth[y]['pax'];

                          print("\n\n\n");
                          print("=================================");
                          // print(bookdata);
                          // print(paxdata);
                          print('book month $bookmonth');
                          print(paxmonth);
                          print("=================================");
                          print("\n\n\n");
                        }
                      }
                    }

                    _detectIsDateSame();
                    _cekmonthbookpax();
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
                        if (datetime == '') {
                          ShowMToast toast = ShowMToast();
                          toast.errorToast(context,
                              message: "Please Pick A Date",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.center,
                              duration: 1500);
                        } else if (datetime != '') {
                          if (isSameDate == false) {
                            print("=====================================");
                            print("Executed False");
                            _savelistcos();
                            _addtable();
                            _bookpax();
                            _savebook();
                            _addlog();

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
                          } else if (isSameDate == true) {
                            print("=====================================");
                            print("Executed True");
                            _savelistcos();
                            _savebook();
                            _bookpax();
                            _addlog();

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
