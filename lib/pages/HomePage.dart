import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:vsing/Input/input_cos.dart';
import 'package:vsing/Update/edit_cos.dart';
import 'package:vsing/pages/historylog.dart';
import 'package:vsing/pages/report_book_pax.dart';
import 'package:vsing/pages/report_cos.dart';
import 'package:vsing/pages/table_view.dart';
import 'package:vsing/util/detailbook.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // database
  final db = FirebaseFirestore.instance;

  // func new
  var dataname;
  var dataattand;
  var dataremark;
  var dataphone;
  var datapax;
  var datadate;
  var datatime;
  List datano = [];
  List datasearch = [];
  var datafloor;
  var dataevent;

  // creat
  _addalldata() async {
    DateFormat bulan = DateFormat('MM');
    month = bulan.format(DateTime.now());

    DateFormat tahun = DateFormat('yyyy');
    year = tahun.format(DateTime.now());
    var tahundepan = int.parse(year);
    assert(tahundepan is int);
    final hasil = tahundepan + 1;

    db
        .collection('Vsing-rsv')
        // .doc(hasil.toString())
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('01')
        .set({"bulan": "Jan", 'Id': '01', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('02')
        .set({"bulan": "Feb", 'Id': '02', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('03')
        .set({"bulan": "Mar", 'Id': '03', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('04')
        .set({"bulan": "Apr", 'Id': '04', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('05')
        .set({"bulan": "May", 'Id': '05', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('06')
        .set({"bulan": "Jun", 'Id': '06', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('07')
        .set({"bulan": "Jul", 'Id': '07', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('08')
        .set({"bulan": "Ags", 'Id': '08', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('09')
        .set({"bulan": "Sep", 'Id': '09', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('10')
        .set({"bulan": "Okt", 'Id': '10', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('11')
        .set({"bulan": "Nov", 'Id': '11', 'book': 0, 'pax': 0});
    db
        .collection('Vsing-rsv')
        .doc(hasil.toString())
        .collection('Book-Pax')
        .doc('12')
        .set({"bulan": "Des", 'Id': '12', 'book': 0, 'pax': 0});
  }

  // end

// Search func
  String name = "";
  String booksearch = "";
  bool isSameDate = false;

  // today date
  String datetime = '';
  String datemonth = '';
  var today = '',
      todayear = '',
      dateday = '',
      day = '',
      monthnow = '',
      idmonth = '',
      idmonthbfr = '',
      todaydate = '',
      hasiltoday = '',
      daynow = '',
      datakemarin = '',
      datetimenow = '',
      tglbefore = '',
      Monthname = '';

  // data baruisSameDate
  var hari1 = '',
      hari2 = '',
      hari3 = '',
      hari4 = '',
      hari5 = '',
      hari6 = '',
      hari7 = '',
      btnhari1 = '',
      btnhari2 = '',
      btnhari3 = '',
      btnhari4 = '',
      btnhari5 = '',
      btnhari6 = '',
      btnhari7 = '';
  //

  _today() async {
    // hari ke 1
    DateFormat bul = DateFormat('d MMM yyyy');
    today = bul.format(DateTime.now());

    var waktukmrn = DateTime.now().subtract(Duration(days: 1));
    DateFormat kmrn = DateFormat('d MMM yyyy');
    datakemarin = kmrn.format(waktukmrn);

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
  }

  //log activity
  String month = '';
  String year = '';
  String bulma = '';

  //book and pax
  var bookdata = 0;
  var paxdata = 0;
  var bookall = 0;
  var paxall = 0;
  var hasil;

  var user = FirebaseAuth.instance.currentUser;
  var cekstatus;

  _searchByName() {
    var data = [];
    for (var i = 0; i < dataname.length; i++) {
      var potongan = dataname.substring(0, i + 1);
      data.add(potongan);
    }
    return data;
  }

  _searchByNumber() {
    var data = [];
    for (var i = 0; i < dataphone.length; i++) {
      var potongan = dataphone.substring(0, i + 1);
      data.add(potongan);
    }
    return data;
  }

  _searchByDate() {
    var data = [];
    for (var i = 0; i < datadate.length; i++) {
      var potongan = datadate.substring(0, i + 1);
      data.add(potongan);
    }
    return data;
  }

  var paxxl;
  var bookxl;
  var paxnow;
  var floor;
  List id = [];
  List mnthnow = [];
  List table = [];
  var tgl;
  var idtgl;

  _deleteData() async {
    var now = DateTime.now().subtract(Duration(days: 1));
    DateFormat kmrn = DateFormat('d MMM yyyy');
    var kemarin = kmrn.format(now);
    DateFormat monthkmrn = DateFormat('MMM');
    tglbefore = monthkmrn.format(now);
    print(tglbefore);
    print('\n\n\n');
    // tglbefore = kemarin.substring(3, 6);

    if (tglbefore == 'Jan') {
      idmonthbfr = '01';
    } else if (tglbefore == 'Feb') {
      idmonthbfr = '02';
    } else if (tglbefore == 'Mar') {
      idmonthbfr = '02';
    } else if (tglbefore == 'Apr') {
      idmonthbfr = '04';
    } else if (tglbefore == 'Mei') {
      idmonthbfr = '05';
    } else if (tglbefore == 'Jun') {
      idmonthbfr = '06';
    } else if (tglbefore == 'Jul') {
      idmonthbfr = '07';
    } else if (tglbefore == 'Agu') {
      idmonthbfr = '08';
    } else if (tglbefore == 'Sep') {
      idmonthbfr = '09';
    } else if (tglbefore == 'Okt') {
      idmonthbfr = '10';
    } else if (tglbefore == 'Nov') {
      idmonthbfr = '11';
    } else if (tglbefore == 'Des') {
      idmonthbfr = '12';
    }

    final datae = await FirebaseFirestore.instance
        .collectionGroup('Reservation')
        .where('date', isEqualTo: kemarin)
        .get();
    var da = datae.docs.map((e) => e.data()).toList();
    for (int z = 0; z < da.length; ++z) {
      paxxl = da[z]['pax'];
      bookxl = da[z]['book'];
    }

    final dataq = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(year)
        .collection('month')
        .doc(idmonth)
        .collection('Reservation')
        .doc(datakemarin)
        .collection('user')
        .get();

    var dq = dataq.docs.map((e) => e.data()).toList();

    for (int d = 0; d < dq.length; ++d) {
      id.add(
          dq[d]['name'] + dq[d]['pax'] + dq[d]['date'] + dq[d]['phone_number']);
      table.add(dq[d]['table_no']);
      paxnow = dq[d]['pax'];
      floor = dq[d]['floor'];
      var tanggalnow = dq[d]['date'];
      tgl = tanggalnow.substring(3, 6);
      if (tgl == 'Jan') {
        idtgl = '01';
      } else if (tgl == 'Feb') {
        idtgl = '02';
      } else if (tgl == 'Mar') {
        idtgl = '03';
      } else if (tgl == 'Apr') {
        idtgl = '04';
      } else if (tgl == 'Mei') {
        idtgl = '05';
      } else if (tgl == 'Jun') {
        idtgl = '06';
      } else if (tgl == 'Jul') {
        idtgl = '07';
      } else if (tgl == 'Agu') {
        idtgl = '08';
      } else if (tgl == 'Sep') {
        idtgl = '09';
      } else if (tgl == 'Okt') {
        idtgl = '10';
      } else if (tgl == 'Nov') {
        idtgl = '11';
      } else if (tgl == 'Des') {
        idtgl = '12';
      }

      print('\n\n');
      print('===============');
      print(id);
      print(table);
      print(kemarin);
      print(paxnow);
      print(floor);
      print(idtgl);
      print('===============');
      print('\n\n');

      // month
      var bmonth = bookall - 1;
      var pmonth = paxall - int.parse(paxnow);
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          .collection('month')
          .doc(idtgl)
          .update({'book': bmonth, 'pax': pmonth});

      // day
      var book = bookxl - 1;
      var pax = paxxl - int.parse(paxnow);
      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          .collection('month')
          .doc(idmonth)
          .collection('Reservation')
          .doc(datakemarin)
          .update({'book': book, 'pax': pax});

      await FirebaseFirestore.instance
          .collection('Vsing-rsv')
          .doc(year)
          .collection('month')
          .doc(idmonth)
          .collection('Reservation')
          .doc(kemarin)
          .collection('user-log')
          .doc()
          .set({
        'name': dataname,
        'pax': datapax,
        'remark': dataremark,
        'date': datadate,
        'table_no': FieldValue.arrayUnion(datano),
        'event': dataevent,
        "phone_number": dataphone,
        'floor': datafloor,
        'time': datatime,
        'search': FieldValue.arrayUnion(
            [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
      });

      // var books = widget.bookdata + bookday;
      // var paxs = widget.paxdata + paxday;
      // var bmonths = widget.bookdata + booktotal;
      // var pmonths = widget.paxdata + paxtotal;

      // await FirebaseFirestore.instance
      //     .collection('Vsing-rsv')
      //     .doc(todayear)
      //     .collection('month')
      //     .doc(idmonth)
      //     .collection('Report_Weeks')
      //     .doc('week_${widget.weekofmonth}')
      //     .collection('reports')
      //     .doc(day)
      //     .update({'book_datas': books, 'pax_datas': paxs});

      // await FirebaseFirestore.instance
      //     .collection('Vsing-rsv')
      //     .doc(todayear)
      //     .collection('month')
      //     .doc(idmonth)
      //     .collection('Report_Weeks')
      //     .doc('week_${widget.weekofmonth}')
      //     .collection('reports')
      //     .doc('total')
      //     .update({'book_total': bmonths, 'pax_total': pmonths});

      // del user
      for (int y = 0; y <= id.length; ++y) {
        await FirebaseFirestore.instance
            .collection('Vsing-rsv')
            .doc(year)
            .collection('month')
            .doc(idmonth)
            .collection('Reservation')
            .doc(datakemarin)
            .collection('user')
            .doc(id[y])
            .delete();
      }

      for (int x = 0; x < table.length; ++x) {
        await FirebaseFirestore.instance
            .collection('Vsing-rsv')
            .doc(year)
            .collection('month')
            .doc(idmonth)
            .collection('Reservation')
            .doc(datakemarin)
            .collection('table')
            .doc(floor)
            .collection('lantai')
            .doc(table[x])
            .update({'status': 'Avail'});

        //   print('\n\n\n');
        //   print(table[x]);
        //   print('\n\n\n');
      }

      print(book);
      print(pax);
      print('===============');
      print('$bookall - 1 = $bmonth');
      print('$paxall - $paxnow =  $pmonth');
    }
  }

  _addtable() async {
    // =====================================================================\\
    // add bookpax
    // =====================================================================\\
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        // .collection('month')
        // .doc(idmonth)
        .collection('Reservation')
        .doc(datetime)
        .set({'date': datetime, 'book': 0, 'pax': 0, 'status': true});

    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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
        .doc(todayear)
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

  _addbookpaxweek() async {
    var waktukmrn = DateTime.now();
    DateFormat now = DateFormat('MMM');
    var mnth = now.format(waktukmrn);
    var numonth;

    // if (mnth == 'Jan') {
    //   numonth = '01';
    // } else if (mnth == 'Feb') {
    //   numonth = '02';
    // } else if (mnth == 'Mar') {
    //   numonth = '03';
    // } else if (mnth == 'Apr') {
    //   numonth = '04';
    // } else if (mnth == 'Mei') {
    //   numonth = '05';
    // } else if (mnth == 'Jun') {
    //   numonth = '06';
    // } else if (mnth == 'Jul') {
    //   numonth = '07';
    // } else if (mnth == 'Agu') {
    //   numonth = '08';
    // } else if (mnth == 'Sep') {
    //   numonth = '09';
    // } else if (mnth == 'Okt') {
    //   numonth = '10';
    // } else if (mnth == 'Nov') {
    //   numonth = '11';
    // } else if (mnth == 'Des') {
    //   numonth = '12';
    // }
    if (mnth == 'Jan') {
      numonth = '02';
    } else if (mnth == 'Feb') {
      numonth = '03';
    } else if (mnth == 'Mar') {
      numonth = '04';
    } else if (mnth == 'Apr') {
      numonth = '05';
    } else if (mnth == 'Mei') {
      numonth = '06';
    } else if (mnth == 'Jun') {
      numonth = '07';
    } else if (mnth == 'Jul') {
      numonth = '08';
    } else if (mnth == 'Agu') {
      numonth = '09';
    } else if (mnth == 'Sep') {
      numonth = '10';
    } else if (mnth == 'Okt') {
      numonth = '11';
    } else if (mnth == 'Nov') {
      numonth = '12';
    } else if (mnth == 'Des') {
      numonth = '01';
    }
    print('\n\n\n');
    print(numonth);
    print('\n\n');

    // week_1
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .set({'week': 'week_1'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('sun')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sun'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('mon')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'mon'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('tue')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'tue'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('wed')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'wed'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('thu')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'thu'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('fri')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'fri'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('sat')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sat'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .doc('total')
        .set({'book_total': 0, 'pax_total': 0, 'day': 'total'});

    // week_2
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .set({'week': 'week_2'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('sun')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sun'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('mon')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'mon'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('tue')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'tue'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('wed')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'wed'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('thu')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'thu'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('fri')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'fri'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('sat')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sat'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .doc('total')
        .set({'book_total': 0, 'pax_total': 0, 'day': 'total'});

    // week_3
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .set({'week': 'week_3'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('sun')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sun'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('mon')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'mon'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('tue')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'tue'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('wed')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'wed'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('thu')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'thu'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('fri')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'fri'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('sat')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sat'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .doc('total')
        .set({'book_total': 0, 'pax_total': 0, 'day': 'total'});

    // week_4
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .set({'week': 'week_4'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('sun')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sun'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('mon')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'mon'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('tue')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'tue'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('wed')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'wed'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('thu')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'thu'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('fri')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'fri'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('sat')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sat'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .doc('total')
        .set({'book_total': 0, 'pax_total': 0, 'day': 'total'});

    // week_5
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .set({'week': 'week_5'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('sun')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sun'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('mon')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'mon'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('tue')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'tue'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('wed')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'wed'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('thu')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'thu'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('fri')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'fri'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('sat')
        .set({'book_datas': 0, 'pax_datas': 0, 'day': 'sat'});
    await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Book-Pax')
        .doc(numonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .doc('total')
        .set({'book_total': 0, 'pax_total': 0, 'day': 'total'});
  }

  void _detectIsDateSame() async {
    final data = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Reservation')
        .get();
    var tes = data.docs.map((e) => e.data()).toList();

    for (int x = 0; x <= tes.length - 1; ++x) {
      if (tes[x]['date'] == datetime) {
        setState(() {
          isSameDate = true;

          print('\n\n\n');
          print(isSameDate);
        });
        break;
      } else {
        setState(() {
          isSameDate = false;

          print(isSameDate);
          print('\n\n\n');
        });
      }
    }
  }

  var colorevent, datacolors, CurUser;

  @override
  void initState() {
    super.initState();

    _today();
    // _deleteData();
    _detectIsDateSame();

    datetime = today;
    dateday = daynow;
    var dname = DateTime.now();
    Monthname = DateFormat('MMM').format(dname);

    final date = DateTime.now();
    // print('\n\n');
    // print(' now : $monthnow');
    // print(DateTime.now().subtract(Duration(days: 1)));
    // print(' now : $date');
    // print(datakemarin);
    // print('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

        // =====================================================================\\
        // bootom app bar
        // =====================================================================\\
        floatingActionButton: StreamBuilder(
            stream: db.collection('users').snapshots(),
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
              for (int x = 0; x < data.length; ++x) {
                if (user!.uid == data[x].data()['uid']) {
                  if (data[x].data()['role'] == "Super Admin") {
                    print(data[x].data()['role']);
                    // _addbookpaxweek();
                    CurUser = data[x].data()['role'];
                  } else if (data[x].data()['role'] == "Manager") {
                    print(data[x].data()['role']);
                    CurUser = data[x].data()['role'];
                  } else if (data[x].data()['role'] == "Admin") {
                    print(data[x].data()['role']);
                    CurUser = data[x].data()['role'];
                  } else if (data[x].data()['role'] == "Staff") {
                    print(data[x].data()['role']);
                    CurUser = data[x].data()['role'];
                  }
                }
              }
              return InkWell(
                onTap: () {
                  _addalldata();
                  // _addbookpaxweek();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TableDetails(),
                      ));
                },
                child: Container(
                    width: 65.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Color.fromARGB(255, 56, 43, 83),
                    ),
                    child: Icon(
                      Icons.add_circle,
                      size: 60.w,
                      color: Color.fromARGB(255, 121, 104, 229),
                    )),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          color: Color.fromARGB(255, 56, 43, 83),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (isSameDate == false) {
                          _addtable();
                        } else {
                          print('ada');
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Table_View()));
                      },
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (isSameDate == false) {
                                _addtable();
                              } else {
                                print('ada');
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Table_View()));
                            },
                            icon: Icon(
                              Icons.grid_view_rounded,
                              color: Colors.white,
                              size: 35.w,
                            ),
                          ),
                          Text('Table',
                              style: TextStyle(
                                color: Color.fromARGB(234, 255, 254, 254),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                CurUser == 'Staff'
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          if (CurUser == 'Manager') {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 250.h,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        report_view()));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.stacked_bar_chart_rounded,
                                                color: Color.fromARGB(
                                                    255, 56, 43, 83),
                                                size: 55.sp,
                                              ),
                                              SizedBox(
                                                width: 100.w,
                                                child: Text('Report Costumers',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 56, 43, 83),
                                                        fontSize: 20.sp)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _addbookpaxweek();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        report_BookPax()));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.stacked_bar_chart_rounded,
                                                color: Color.fromARGB(
                                                    255, 56, 43, 83),
                                                size: 55.w,
                                              ),
                                              SizedBox(
                                                width: 130.w,
                                                child: Text('Report Book & Pax',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 56, 43, 83),
                                                        fontSize: 20.sp)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            _addbookpaxweek();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => report_BookPax()));
                          }
                        },
                        child: Row(
                          children: [
                            Text('Report',
                                style: TextStyle(
                                  color: Color.fromARGB(234, 255, 254, 254),
                                )),
                            Icon(
                              Icons.stacked_bar_chart_rounded,
                              color: Colors.white,
                              size: 35.sp,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xE8E0DFDF),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================================\\
            // Title
            // =====================================================================\\
            Container(
              width: MediaQuery.of(context).size.width,
              height: 310.h,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 56, 43, 83),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 10, top: 45, right: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "VSing Ipoh Soho",
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),

                          Container(
                            width: 150.h,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => history()));
                                    },
                                    icon: Icon(
                                      Icons.history,
                                      color: Colors.white,
                                      size: 35.sp,
                                    )),
                                IconButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    // GoogleSignIn().signOut();

                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return new auth();
                                    }), (r) {
                                      return false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.logout,
                                    size: 35.sp,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // history log //
                        ],
                      ),
                    ),

                    Text(
                      "Reservation",
                      style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                    // =====================================================================\\
                    // search and calender
                    // =====================================================================\\
                    SizedBox(height: 10.h),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            // width: MediaQuery.of(context).size.width,
                            // height: 40,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30.w,
                                ),
                                hintText:
                                    'Search by name, date or phone number',
                                hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 85, 71, 117),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                            child: IconButton(
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
                                          onPrimary: Color.fromARGB(255, 255,
                                              255, 255), // <-- SEE HERE
                                          onSurface: Color.fromARGB(
                                              255, 85, 71, 117), // <-- SEE HERE
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: Color.fromARGB(255, 85, 71,
                                                117), // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                initializeDateFormatting('id');

                                String formattedDate =
                                    DateFormat.yMMMd('id').format(datetimeRet!);
                                String formatmonth =
                                    DateFormat.MMM('id').format(datetimeRet);
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
                                setState(() {
                                  datetime = formattedDate;
                                  todayear = datetimeRet.year.toString();
                                  datetimenow = formattedDate;

                                  print('\n\n');
                                  print(idmonth);
                                  print(formatmonth);
                                  print(todayear);
                                  print('\n\n');
                                });
                                // _detectIsDateSame();
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Month: ${Monthname}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Vsing-rsv')
                              .doc(todayear)
                              .collection('Reservation')
                              .where(
                                'date',
                                isEqualTo:
                                    (datetimenow != '') ? datetimenow : today,
                              )
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
                            var bookpaxday = snapshot.data!.docs;

                            for (int day = 0; day < bookpaxday.length; ++day) {
                              // bookdata = bookpaxday[day]['book'];
                              // paxdata = bookpaxday[day]['pax'];
                              // print(bookdata);
                              // print(paxdata);
                              if (bookpaxday[day]['date'] == datetime) {
                                bookdata = bookpaxday[day]['book'];
                                paxdata = bookpaxday[day]['pax'];
                              }
                            }
                            return Container(
                              // width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Book',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 54, 51, 140),
                                            fontSize: 15.sp),
                                      ),
                                      SizedBox(width: 5.h),
                                      Text(
                                        'Pax',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 54, 51, 140),
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        bookdata.toString(),
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 54, 51, 140),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: 3.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 54, 51, 140),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                      ),
                                      Text(
                                        paxdata.toString(),
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 54, 51, 140),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            );
                          },
                        )),
                        SizedBox(width: 10.w),
                        Expanded(
                            child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Vsing-rsv')
                              .doc(todayear)
                              .collection('Book-Pax')
                              .where('Id', isEqualTo: idmonth)
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
                            var bookpaxmonth = snapshot.data!.docs;
                            for (int mnth = 0;
                                mnth < bookpaxmonth.length;
                                ++mnth) {
                              bookall = bookpaxmonth[mnth]['book'];
                              paxall = bookpaxmonth[mnth]['pax'];
                              // if (bookpaxmonth[mnth]['Id'] == idmonth) {

                              // }
                            }
                            return Container(
                              // width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Book',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 54, 51, 140),
                                            fontSize: 15.sp),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Pax',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 54, 51, 140),
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        bookall.toString(),
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 54, 51, 140),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: 3.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 54, 51, 140),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                      ),
                                      Text(
                                        paxall.toString(),
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 54, 51, 140),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            );
                          },
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (name != "" && name != null)
                    ? FirebaseFirestore.instance
                        .collectionGroup('user')
                        .where("search", arrayContains: name)
                        .snapshots()
                    : datetimenow == ''
                        ? FirebaseFirestore.instance
                            .collectionGroup('user')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collectionGroup('user')
                            .where('date', isEqualTo: datetime)
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
                  var data = snapshot.data!.docs;

                  return GroupedListView<dynamic, String>(
                    stickyHeaderBackgroundColor:
                        Color.fromARGB(232, 208, 208, 208),
                    elements: data,
                    groupBy: (data) => data['datefull'],
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    itemComparator: (item1, item2) =>
                        item1['date'].compareTo(item2['date']),
                    order: GroupedListOrder.DESC,
                    // useStickyGroupSeparators: true,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    //
                                    color: Colors.black,
                                    width: 1.8.w,
                                  )),
                                  // color: Color.fromARGB(232, 255, 253, 253),
                                ),
                                child: Text(
                                  value,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                  width: 30.w,
                                  child: (datetimenow != '')
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              datetimenow = '';
                                            });
                                          },
                                          icon: Icon(
                                            Icons.home_rounded,
                                            size: 25.sp,
                                          ))
                                      : SizedBox()),
                            )
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (c, data) {
                      backgroundColor:
                      Color.fromARGB(232, 255, 253, 253);
                      dataname = data['name'];
                      dataattand = data['attendance'];
                      dataremark = data['remark'];
                      dataevent = data['event'];
                      dataphone = data['phone_number'];
                      datapax = data['pax'];
                      datadate = data['date'];
                      datatime = data['time'];
                      datano = data['table_no'];
                      datafloor = data['floor'];

                      // data = data['week'];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Edit_Cos(
                                      bookmonth: bookall,
                                      paxmonth: paxall,
                                      idmonth: idmonth,
                                      todayear: todayear,
                                      week: data['week'],
                                      dateday: data['dateday'],
                                      fulldate: data['datefull'],
                                      name: data['name'],
                                      id: data['name'] +
                                          data['pax'] +
                                          data['date'] +
                                          data['phone_number'],
                                      attendance: data['attendance'],
                                      remark: data['remark'],
                                      event: data['event'],
                                      phone: data['phone_number'],
                                      pax: data['pax'],
                                      date: data['date'],
                                      time: data['time'],
                                      no_table: data['table_no'],
                                      floor: data['floor'],
                                      bookdata: bookdata,
                                      paxdata: paxdata)));
                        },
                        child: detail_book(
                            cekuser: CurUser,
                            bookall: bookall,
                            paxall: paxall,
                            idmonth: idmonth,
                            todayear: todayear,
                            bookdata: bookdata,
                            paxdata: paxdata,
                            weekofmonth: data['week'],
                            day: data['dateday'],
                            attendance: data['attendance'],
                            remark: data['remark'],
                            event: data['event'],
                            name: data['name'],
                            phone: data['phone_number'],
                            pax: data['pax'],
                            date: data['date'],
                            time: data['time'],
                            no: data['table_no'],
                            floor: data['floor']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
