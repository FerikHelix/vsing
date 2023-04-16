import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class report_BookPax extends StatefulWidget {
  const report_BookPax({super.key});

  @override
  State<report_BookPax> createState() => _report_BookPaxState();
}

class _report_BookPaxState extends State<report_BookPax> {
  // week1
  var paxwed, bookwed;
  var paxsun, booksun;
  var paxmon, bookmon;
  var paxtue, booktue;
  var paxthu, bookthu;
  var paxfri, bookfri;
  var paxsat, booksat;
  var paxtotal, booktotal;
  // // week2
  var paxwedw2, bookwedw2;
  var paxsunw2, booksunw2;
  var paxmonw2, bookmonw2;
  var paxtuew2, booktuew2;
  var paxthuw2, bookthuw2;
  var paxfriw2, bookfriw2;
  var paxsatw2, booksatw2;
  var paxtotalw2, booktotalw2;
  // week3
  var paxwedw3, bookwedw3;
  var paxsunw3, booksunw3;
  var paxmonw3, bookmonw3;
  var paxtuew3, booktuew3;
  var paxthuw3, bookthuw3;
  var paxfriw3, bookfriw3;
  var paxsatw3, booksatw3;
  var paxtotalw3, booktotalw3;
  // week4
  var paxwedw4, bookwedw4;
  var paxsunw4, booksunw4;
  var paxmonw4, bookmonw4;
  var paxtuew4, booktuew4;
  var paxthuw4, bookthuw4;
  var paxfriw4, bookfriw4;
  var paxsatw4, booksatw4;
  var paxtotalw4, booktotalw4;
  // week5
  var paxwedw5, bookwedw5;
  var paxsunw5, booksunw5;
  var paxmonw5, bookmonw5;
  var paxtuew5, booktuew5;
  var paxthuw5, bookthuw5;
  var paxfriw5, bookfriw5;
  var paxsatw5, booksatw5;
  var paxtotalw5, booktotalw5;

  _databookpaxweek1() async {
    // wed
    final dataq = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'wed')
        .get();

    var dq = dataq.docs.map((e) => e.data()).toList();
    // sun
    final datas = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'sun')
        .get();

    var ds = datas.docs.map((e) => e.data()).toList();
    // mon
    final datam = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'mon')
        .get();

    var dm = datam.docs.map((e) => e.data()).toList();
    // tue
    final datat = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'tue')
        .get();

    var dt = datat.docs.map((e) => e.data()).toList();
    // thu
    final datah = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'thu')
        .get();

    var dh = datah.docs.map((e) => e.data()).toList();
    // fri
    final dataf = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'fri')
        .get();

    var df = dataf.docs.map((e) => e.data()).toList();
    // sat
    final datasa = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'sat')
        .get();

    var dsa = datasa.docs.map((e) => e.data()).toList();

    // total
    final total = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_1')
        .collection('reports')
        .where('day', isEqualTo: 'total')
        .get();

    var ttl = total.docs.map((e) => e.data()).toList();

    for (int w = 0; w < dq.length; ++w) {
      setState(() {
        bookwed = dq[w]['book_datas'];
        paxwed = dq[w]['pax_datas'];
      });
    }
    for (int x = 0; x < ds.length; ++x) {
      setState(() {
        booksun = ds[x]['book_datas'];
        paxsun = ds[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dm.length; ++x) {
      setState(() {
        bookmon = dm[x]['book_datas'];
        paxmon = dm[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dt.length; ++x) {
      setState(() {
        booktue = dt[x]['book_datas'];
        paxtue = dt[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dh.length; ++x) {
      setState(() {
        bookthu = dh[x]['book_datas'];
        paxthu = dh[x]['pax_datas'];
      });
    }
    for (int x = 0; x < df.length; ++x) {
      setState(() {
        bookfri = df[x]['book_datas'];
        paxfri = df[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dsa.length; ++x) {
      setState(() {
        booksat = dsa[x]['book_datas'];
        paxsat = dsa[x]['pax_datas'];
      });
    }
    for (int x = 0; x < ttl.length; ++x) {
      setState(() {
        booktotal = ttl[x]['book_total'];
        paxtotal = ttl[x]['pax_total'];
      });
    }
  }

  _databookpaxweek2() async {
    // wed
    final dataq = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'wed')
        .get();

    var dq = dataq.docs.map((e) => e.data()).toList();
    // sun
    final datas = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'sun')
        .get();

    var ds = datas.docs.map((e) => e.data()).toList();
    // mon
    final datam = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'mon')
        .get();

    var dm = datam.docs.map((e) => e.data()).toList();
    // tue
    final datat = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'tue')
        .get();

    var dt = datat.docs.map((e) => e.data()).toList();
    // thu
    final datah = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'thu')
        .get();

    var dh = datah.docs.map((e) => e.data()).toList();
    // fri
    final dataf = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'fri')
        .get();

    var df = dataf.docs.map((e) => e.data()).toList();
    // sat
    final datasa = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'sat')
        .get();

    var dsa = datasa.docs.map((e) => e.data()).toList();

    // total
    final total = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_2')
        .collection('reports')
        .where('day', isEqualTo: 'total')
        .get();

    var ttl = total.docs.map((e) => e.data()).toList();

    for (int w = 0; w < dq.length; ++w) {
      setState(() {
        bookwedw2 = dq[w]['book_datas'];
        paxwedw2 = dq[w]['pax_datas'];
      });
    }
    for (int x = 0; x < ds.length; ++x) {
      setState(() {
        booksunw2 = ds[x]['book_datas'];
        paxsunw2 = ds[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dm.length; ++x) {
      setState(() {
        bookmonw2 = dm[x]['book_datas'];
        paxmonw2 = dm[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dt.length; ++x) {
      setState(() {
        booktuew2 = dt[x]['book_datas'];
        paxtuew2 = dt[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dh.length; ++x) {
      setState(() {
        bookthuw2 = dh[x]['book_datas'];
        paxthuw2 = dh[x]['pax_datas'];
      });
    }
    for (int x = 0; x < df.length; ++x) {
      setState(() {
        bookfriw2 = df[x]['book_datas'];
        paxfriw2 = df[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dsa.length; ++x) {
      setState(() {
        booksatw2 = dsa[x]['book_datas'];
        paxsatw2 = dsa[x]['pax_datas'];
      });
    }
    for (int x = 0; x < ttl.length; ++x) {
      setState(() {
        booktotalw2 = ttl[x]['book_total'];
        paxtotalw2 = ttl[x]['pax_total'];
      });
    }
  }

  _databookpaxweek3() async {
    // wed
    final dataq = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'wed')
        .get();

    var dq = dataq.docs.map((e) => e.data()).toList();
    // sun
    final datas = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'sun')
        .get();

    var ds = datas.docs.map((e) => e.data()).toList();
    // mon
    final datam = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'mon')
        .get();

    var dm = datam.docs.map((e) => e.data()).toList();
    // tue
    final datat = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'tue')
        .get();

    var dt = datat.docs.map((e) => e.data()).toList();
    // thu
    final datah = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'thu')
        .get();

    var dh = datah.docs.map((e) => e.data()).toList();
    // fri
    final dataf = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'fri')
        .get();

    var df = dataf.docs.map((e) => e.data()).toList();
    // sat
    final datasa = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'sat')
        .get();

    var dsa = datasa.docs.map((e) => e.data()).toList();

    // total
    final total = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_3')
        .collection('reports')
        .where('day', isEqualTo: 'total')
        .get();

    var ttl = total.docs.map((e) => e.data()).toList();

    for (int w = 0; w < dq.length; ++w) {
      setState(() {
        bookwedw3 = dq[w]['book_datas'];
        paxwedw3 = dq[w]['pax_datas'];
      });
    }
    for (int x = 0; x < ds.length; ++x) {
      setState(() {
        booksunw3 = ds[x]['book_datas'];
        paxsunw3 = ds[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dm.length; ++x) {
      setState(() {
        bookmonw3 = dm[x]['book_datas'];
        paxmonw3 = dm[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dt.length; ++x) {
      setState(() {
        booktuew3 = dt[x]['book_datas'];
        paxtuew3 = dt[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dh.length; ++x) {
      setState(() {
        bookthuw3 = dh[x]['book_datas'];
        paxthuw3 = dh[x]['pax_datas'];
      });
    }
    for (int x = 0; x < df.length; ++x) {
      setState(() {
        bookfriw3 = df[x]['book_datas'];
        paxfriw3 = df[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dsa.length; ++x) {
      setState(() {
        booksatw3 = dsa[x]['book_datas'];
        paxsatw3 = dsa[x]['pax_datas'];
      });
    }
    for (int x = 0; x < ttl.length; ++x) {
      setState(() {
        booktotalw3 = ttl[x]['book_total'];
        paxtotalw3 = ttl[x]['pax_total'];
      });
    }
  }

  _databookpaxweek4() async {
    // wed
    final dataq = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'wed')
        .get();

    var dq = dataq.docs.map((e) => e.data()).toList();
    // sun
    final datas = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'sun')
        .get();

    var ds = datas.docs.map((e) => e.data()).toList();
    // mon
    final datam = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'mon')
        .get();

    var dm = datam.docs.map((e) => e.data()).toList();
    // tue
    final datat = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'tue')
        .get();

    var dt = datat.docs.map((e) => e.data()).toList();
    // thu
    final datah = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'thu')
        .get();

    var dh = datah.docs.map((e) => e.data()).toList();
    // fri
    final dataf = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'fri')
        .get();

    var df = dataf.docs.map((e) => e.data()).toList();
    // sat
    final datasa = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'sat')
        .get();

    var dsa = datasa.docs.map((e) => e.data()).toList();

    // total
    final total = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_4')
        .collection('reports')
        .where('day', isEqualTo: 'total')
        .get();

    var ttl = total.docs.map((e) => e.data()).toList();

    for (int w = 0; w < dq.length; ++w) {
      setState(() {
        bookwedw4 = dq[w]['book_datas'];
        paxwedw4 = dq[w]['pax_datas'];
      });
    }
    for (int x = 0; x < ds.length; ++x) {
      setState(() {
        booksunw4 = ds[x]['book_datas'];
        paxsunw4 = ds[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dm.length; ++x) {
      setState(() {
        bookmonw4 = dm[x]['book_datas'];
        paxmonw4 = dm[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dt.length; ++x) {
      setState(() {
        booktuew4 = dt[x]['book_datas'];
        paxtuew4 = dt[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dh.length; ++x) {
      setState(() {
        bookthuw4 = dh[x]['book_datas'];
        paxthuw4 = dh[x]['pax_datas'];
      });
    }
    for (int x = 0; x < df.length; ++x) {
      setState(() {
        bookfriw4 = df[x]['book_datas'];
        paxfriw4 = df[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dsa.length; ++x) {
      setState(() {
        booksatw4 = dsa[x]['book_datas'];
        paxsatw4 = dsa[x]['pax_datas'];
      });
    }
    for (int x = 0; x < ttl.length; ++x) {
      setState(() {
        booktotalw4 = ttl[x]['book_total'];
        paxtotalw4 = ttl[x]['pax_total'];
      });
    }
  }

  _databookpaxweek5() async {
    // wed
    final dataq = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'wed')
        .get();

    var dq = dataq.docs.map((e) => e.data()).toList();
    // sun
    final datas = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'sun')
        .get();

    var ds = datas.docs.map((e) => e.data()).toList();
    // mon
    final datam = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'mon')
        .get();

    var dm = datam.docs.map((e) => e.data()).toList();
    // tue
    final datat = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'tue')
        .get();

    var dt = datat.docs.map((e) => e.data()).toList();
    // thu
    final datah = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'thu')
        .get();

    var dh = datah.docs.map((e) => e.data()).toList();
    // fri
    final dataf = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'fri')
        .get();

    var df = dataf.docs.map((e) => e.data()).toList();
    // sat
    final datasa = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'sat')
        .get();

    var dsa = datasa.docs.map((e) => e.data()).toList();

    // total
    final total = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('book-pax')
        .doc(idmonth)
        .collection('Report_Weeks')
        .doc('week_5')
        .collection('reports')
        .where('day', isEqualTo: 'total')
        .get();

    var ttl = total.docs.map((e) => e.data()).toList();

    for (int w = 0; w < dq.length; ++w) {
      setState(() {
        bookwedw5 = dq[w]['book_datas'];
        paxwedw5 = dq[w]['pax_datas'];
      });
    }
    for (int x = 0; x < ds.length; ++x) {
      setState(() {
        booksunw5 = ds[x]['book_datas'];
        paxsunw5 = ds[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dm.length; ++x) {
      setState(() {
        bookmonw5 = dm[x]['book_datas'];
        paxmonw5 = dm[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dt.length; ++x) {
      setState(() {
        booktuew5 = dt[x]['book_datas'];
        paxtuew5 = dt[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dh.length; ++x) {
      setState(() {
        bookthuw5 = dh[x]['book_datas'];
        paxthuw5 = dh[x]['pax_datas'];
      });
    }
    for (int x = 0; x < df.length; ++x) {
      setState(() {
        bookfriw5 = df[x]['book_datas'];
        paxfriw5 = df[x]['pax_datas'];
      });
    }
    for (int x = 0; x < dsa.length; ++x) {
      setState(() {
        booksatw5 = dsa[x]['book_datas'];
        paxsatw5 = dsa[x]['pax_datas'];
      });
    }
    for (int x = 0; x < ttl.length; ++x) {
      setState(() {
        booktotalw5 = ttl[x]['book_total'];
        paxtotalw5 = ttl[x]['pax_total'];
      });
    }
  }

  _weeknumber() {
    // Current date and time of system
    String date = DateTime.now().toString();

// This will generate the time and date for first day of month
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);

// week day for the first day of the month
    int weekDay = DateTime.parse(firstDay).weekday;

    DateTime testDate = DateTime.now();

    int weekOfMonth;

//  If your calender starts from Monday
    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    // print('Week of the month: $weekOfMonth');
    weekDay++;

// If your calender starts from sunday
    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    print('Week of the month: $weekOfMonth');
  }

  var onklik = 'book', todayear, monthnow, idmonth;
  bool load = true;
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      setState(() {
        load = false;
      });
    });
    //
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

    _databookpaxweek1();
    _databookpaxweek2();
    _databookpaxweek3();
    _databookpaxweek4();
    _databookpaxweek5();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (load == false)
        ? Scaffold(
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
              title: (onklik == 'book')
                  ? Text(
                      'Report Book',
                      style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  : Text(
                      'Report Pax',
                      style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color.fromARGB(232, 232, 231, 231),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        onklik = 'book';
                        load = true;
                        Timer(const Duration(seconds: 1), () {
                          setState(() {
                            load = false;
                          });
                        });
                      });
                    },
                    child: Container(
                      width: 100.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: (onklik == 'book')
                              ? Color.fromARGB(255, 56, 43, 83)
                              : Color.fromARGB(255, 85, 71, 117),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: Center(
                        child: Text(
                          'Book',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        onklik = 'pax';
                        load = true;
                        Timer(const Duration(seconds: 1), () {
                          setState(() {
                            load = false;
                          });
                        });
                      });
                    },
                    child: Container(
                      width: 100.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: (onklik != 'book')
                              ? Color.fromARGB(255, 56, 43, 83)
                              : Color.fromARGB(255, 85, 71, 117),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Center(
                        child: Text(
                          'Pax',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: Color.fromARGB(232, 250, 250, 250),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // onklik == 'book'
                    //     ? Text(
                    //         'Book',
                    //         style: TextStyle(
                    //             fontSize: 25,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.black),
                    //       )
                    //     : Text(
                    //         'Pax',
                    //         style: TextStyle(
                    //             fontSize: 25,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.black),
                    //       ),
                    onklik == 'book'
                        ? SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Color.fromARGB(255, 56, 43, 83),
                              ),
                              dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white10),
                              headingTextStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                              headingRowHeight: 60.h,
                              dataTextStyle: TextStyle(
                                fontSize: 18.sp,
                                color: Color.fromARGB(255, 56, 43, 83),
                              ),
                              dataRowHeight: 60.h,
                              columnSpacing: 10,
                              border: TableBorder.all(
                                width: 1,
                                color: Colors.white10,
                              ),
                              columns: [
                                DataColumn(
                                    label: Center(
                                  child: Text(
                                    'W',
                                  ),
                                )),
                                DataColumn(label: Center(child: Text('Sun'))),
                                DataColumn(label: Text('Mon')),
                                DataColumn(label: Text('Tue')),
                                DataColumn(label: Text('Wed')),
                                DataColumn(label: Text('Thu')),
                                DataColumn(label: Text('Fri')),
                                DataColumn(label: Text('Sat')),
                                DataColumn(
                                    label: Center(
                                  child: Text(
                                    'Total',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(
                                      Center(child: Text(booksun.toString()))),
                                  DataCell(
                                      Center(child: Text(bookmon.toString()))),
                                  DataCell(
                                      Center(child: Text(booktue.toString()))),
                                  DataCell(
                                      Center(child: Text(bookwed.toString()))),
                                  DataCell(
                                      Center(child: Text(bookthu.toString()))),
                                  DataCell(
                                      Center(child: Text(bookfri.toString()))),
                                  DataCell(
                                      Center(child: Text(booksat.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      booktotal.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(Center(
                                      child: Text(booksunw2.toString()))),
                                  DataCell(Center(
                                      child: Text(bookmonw2.toString()))),
                                  DataCell(Center(
                                      child: Text(booktuew2.toString()))),
                                  DataCell(Center(
                                      child: Text(bookwedw2.toString()))),
                                  DataCell(Center(
                                      child: Text(bookthuw2.toString()))),
                                  DataCell(Center(
                                      child: Text(bookfriw2.toString()))),
                                  DataCell(Center(
                                      child: Text(booksatw2.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      booktotalw2.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(Center(
                                      child: Text(booksunw3.toString()))),
                                  DataCell(Center(
                                      child: Text(bookmonw3.toString()))),
                                  DataCell(Center(
                                      child: Text(booktuew3.toString()))),
                                  DataCell(Center(
                                      child: Text(bookwedw3.toString()))),
                                  DataCell(Center(
                                      child: Text(bookthuw3.toString()))),
                                  DataCell(Center(
                                      child: Text(bookfriw3.toString()))),
                                  DataCell(Center(
                                      child: Text(booksatw3.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      booktotalw3.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '4',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(Center(
                                      child: Text(booksunw4.toString()))),
                                  DataCell(Center(
                                      child: Text(bookmonw4.toString()))),
                                  DataCell(Center(
                                      child: Text(booktuew4.toString()))),
                                  DataCell(Center(
                                      child: Text(bookwedw4.toString()))),
                                  DataCell(Center(
                                      child: Text(bookthuw4.toString()))),
                                  DataCell(Center(
                                      child: Text(bookfriw4.toString()))),
                                  DataCell(Center(
                                      child: Text(booksatw4.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      booktotalw4.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(Center(
                                      child: Text(booksunw5.toString()))),
                                  DataCell(Center(
                                      child: Text(bookmonw5.toString()))),
                                  DataCell(Center(
                                      child: Text(booktuew5.toString()))),
                                  DataCell(Center(
                                      child: Text(bookwedw5.toString()))),
                                  DataCell(Center(
                                      child: Text(bookthuw5.toString()))),
                                  DataCell(Center(
                                      child: Text(bookfriw5.toString()))),
                                  DataCell(Center(
                                      child: Text(booksatw5.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      booktotalw5.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                              ],
                            ),
                          )
                        :
                        // Text(
                        //   'Pax',
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black),
                        // ),
                        SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Color.fromARGB(255, 56, 43, 83),
                              ),
                              dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white10),
                              headingTextStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                              headingRowHeight: 60.h,
                              dataTextStyle: TextStyle(
                                fontSize: 18.sp,
                                color: Color.fromARGB(255, 56, 43, 83),
                              ),
                              dataRowHeight: 60.h,
                              columnSpacing: 10,
                              border: TableBorder.all(
                                width: 1,
                                color: Colors.white10,
                              ),
                              columns: [
                                DataColumn(label: Text('W')),
                                DataColumn(label: Text('Sun')),
                                DataColumn(label: Text('Mon')),
                                DataColumn(label: Text('Tue')),
                                DataColumn(label: Text('Wed')),
                                DataColumn(label: Text('Thu')),
                                DataColumn(label: Text('Fri')),
                                DataColumn(label: Text('Sat')),
                                DataColumn(
                                    label: Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(
                                      Center(child: Text(paxsun.toString()))),
                                  DataCell(
                                      Center(child: Text(paxmon.toString()))),
                                  DataCell(
                                      Center(child: Text(paxtue.toString()))),
                                  DataCell(
                                      Center(child: Text(paxwed.toString()))),
                                  DataCell(
                                      Center(child: Text(paxthu.toString()))),
                                  DataCell(
                                      Center(child: Text(paxfri.toString()))),
                                  DataCell(
                                      Center(child: Text(paxsat.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      paxtotal.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(
                                      Center(child: Text(paxsunw2.toString()))),
                                  DataCell(
                                      Center(child: Text(paxmonw2.toString()))),
                                  DataCell(
                                      Center(child: Text(paxtuew2.toString()))),
                                  DataCell(
                                      Center(child: Text(paxwedw2.toString()))),
                                  DataCell(
                                      Center(child: Text(paxthuw2.toString()))),
                                  DataCell(
                                      Center(child: Text(paxfriw2.toString()))),
                                  DataCell(
                                      Center(child: Text(paxsatw2.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      paxtotalw2.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(
                                      Center(child: Text(paxsunw3.toString()))),
                                  DataCell(
                                      Center(child: Text(paxmonw3.toString()))),
                                  DataCell(
                                      Center(child: Text(paxtuew3.toString()))),
                                  DataCell(
                                      Center(child: Text(paxwedw3.toString()))),
                                  DataCell(
                                      Center(child: Text(paxthuw3.toString()))),
                                  DataCell(
                                      Center(child: Text(paxfriw3.toString()))),
                                  DataCell(
                                      Center(child: Text(paxsatw3.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      paxtotalw3.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '4',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(
                                      Center(child: Text(paxsunw4.toString()))),
                                  DataCell(
                                      Center(child: Text(paxmonw4.toString()))),
                                  DataCell(
                                      Center(child: Text(paxtuew4.toString()))),
                                  DataCell(
                                      Center(child: Text(paxwedw4.toString()))),
                                  DataCell(
                                      Center(child: Text(paxthuw4.toString()))),
                                  DataCell(
                                      Center(child: Text(paxfriw4.toString()))),
                                  DataCell(
                                      Center(child: Text(paxsatw4.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      paxtotalw4.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  DataCell(
                                      Center(child: Text(paxsunw5.toString()))),
                                  DataCell(
                                      Center(child: Text(paxmonw5.toString()))),
                                  DataCell(
                                      Center(child: Text(paxtuew5.toString()))),
                                  DataCell(
                                      Center(child: Text(paxwedw5.toString()))),
                                  DataCell(
                                      Center(child: Text(paxthuw5.toString()))),
                                  DataCell(
                                      Center(child: Text(paxfriw5.toString()))),
                                  DataCell(
                                      Center(child: Text(paxsatw5.toString()))),
                                  DataCell(Center(
                                    child: Text(
                                      paxtotalw5.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ]),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ))
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 56, 43, 83),
              ),
            ),
          );
  }
}
