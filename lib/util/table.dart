import 'package:flutter/material.dart';

class tableui extends StatelessWidget {
  final status;
  final cekstatus;
  final no;
  final cekno;
  const tableui({
    super.key,
    required this.status,
    required this.cekstatus,
    required this.no,
    required this.cekno,
  });

  @override
  Widget build(BuildContext context) {
    var warna;
    if (cekstatus == "Selected") {
      warna = Color.fromARGB(255, 221, 20, 124);
    } else if (cekstatus == "Book") {
      warna = Color.fromARGB(255, 2, 161, 234);
    } else if (cekstatus == "Avail") {
      warna = Colors.grey;

      // if (status == cekstatus && no == cekno) {
      //   warna = Color.fromARGB(255, 221, 20, 124);
      // } else if (cekstatus == "Book") {
      //   warna = Color.fromARGB(255, 2, 161, 234);
      // } else if (cekstatus == "Avail") {
      //   warna = Colors.grey;
    }

    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            //color: lokasi == notable Filter Color.fromARGB(255, 231, 8, 93),
            // color: warna,
            color: warna,
            borderRadius: BorderRadius.circular(15)),
        child: Text(no));
  }
}
