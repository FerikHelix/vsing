import 'package:flutter/material.dart';

class tableui extends StatefulWidget {
  final warna;
  final String label;
  final List ceklabel;

  const tableui({
    super.key,
    required this.label,
    required this.ceklabel,
    required this.warna,
  });

  @override
  State<tableui> createState() => _tableuiState();
}

class _tableuiState extends State<tableui> {
  @override
  Widget build(BuildContext context) {
    var color;
    // var warna;
    if (widget.warna == 'Avail') {
      color = Colors.grey;
      for (var i = 0; i < widget.ceklabel.length; i++) {
        if (widget.ceklabel[i] == widget.label) {
          color = Color.fromARGB(255, 221, 20, 124);
        } else if (widget.ceklabel[i] == widget.label) {
          color = Colors.grey;
        }
      }
    } else if (widget.warna != 'Avail') {
      color = Color.fromARGB(255, 2, 161, 234);
    }
    //   // if (status == cekstatus && no == cekno) {
    //   //   warna = Color.fromARGB(255, 221, 20, 124);
    //   // } else if (cekstatus == "Book") {
    //   //   warna = Color.fromARGB(255, 2, 161, 234);
    //   // } else if (cekstatus == "Avail") {
    //   //   warna = Colors.grey;
    // }

    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Text(widget.label));
  }
}
