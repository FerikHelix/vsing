import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

import '../pages/spalsh.dart';

class detail_book extends StatefulWidget {
  final name;
  final phone;
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
  const detail_book({
    super.key,
    required this.name,
    required this.phone,
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
  });

  @override
  State<detail_book> createState() => _detail_bookState();
}

class _detail_bookState extends State<detail_book> {
  @override
  Widget build(BuildContext context) {
    //color
    var color;
    var icon;
    var iconattend;
    // if (attendance == '') {
    //   iconattend = FaIcon(
    //     FontAwesomeIcons.x,
    //     color: Color.fromARGB(255, 209, 24, 24),
    //     size: 15,
    //   );
    // } else if (attendance == 'present') {
    //   iconattend = FaIcon(
    //     FontAwesomeIcons.check,
    //     color: Color.fromARGB(255, 13, 144, 37),
    //     size: 20,
    //   );
    // }

    if (widget.attendance == 'Present') {
      iconattend = Center(
        child: Image.network(
          'https://www.pngall.com/wp-content/uploads/5/Green-Checklist-PNG-Image.png',
          width: 100,
          opacity: const AlwaysStoppedAnimation(.6),
        ),
      );
    }

    if (widget.event == 'Brithday') {
      color = Color.fromARGB(255, 189, 183, 223);
      icon = FaIcon(
        FontAwesomeIcons.cakeCandles,
        color: Color.fromARGB(255, 54, 51, 140),
        size: 20,
      );
    } else if (widget.event == 'Anniversary') {
      color = Color.fromARGB(255, 238, 212, 199);
      icon = FaIcon(
        FontAwesomeIcons.solidHeart,
        color: Color.fromARGB(255, 246, 46, 46),
        size: 20,
      );
    } else if (widget.event == 'Company') {
      color = Color.fromARGB(255, 166, 166, 175);
      icon = Icon(
        Icons.business_center,
        color: Color.fromARGB(255, 121, 75, 40),
        size: 20,
      );
    } else if (widget.event == 'Bachelor Night') {
      color = Color.fromARGB(255, 166, 208, 204);
      icon = Icon(
        Icons.group,
        color: Color.fromARGB(255, 105, 88, 214),
        size: 20,
      );
    }

    // function delete data
    Future deleteData(String id) async {
      try {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(widget.date)
            .collection('isi')
            .doc(id)
            .delete();

        for (int x = 0; x <= widget.no.length - 1; ++x) {
          await FirebaseFirestore.instance
              .collection('table')
              .doc(widget.floor)
              .collection('lantai')
              .doc(widget.no[x])
              .update({'status': 'Avail'});

          print('\n\n\n');
          print(widget.no[x]);
          print('\n\n\n');
        }
      } catch (e) {
        return false;
      }
    }

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

    _bookpax() async {
      var book = int.parse(widget.bookdata) - 1;
      var paks = int.parse(widget.paxdata) - int.parse(widget.pax);

      await FirebaseFirestore.instance
          .collection('book&pax')
          .doc('book')
          .update({'book': book});
      await FirebaseFirestore.instance
          .collection('book&pax')
          .doc('pax')
          .update({'pax': paks});
    }

    _log() async {
      await FirebaseFirestore.instance
          .collection('user-log')
          .doc(widget.date)
          .set({'date': widget.date});
      await FirebaseFirestore.instance
          .collection('user-log')
          .doc(widget.date)
          .collection('isi')
          .doc()
          .set({
        'name': widget.name,
        'pax': widget.pax,
        'remark': widget.remark,
        'date': widget.date,
        'table_no': FieldValue.arrayUnion(widget.no),
        'event': widget.event,
        "phone_number": widget.phone,
        'floor': widget.floor,
        'time': widget.time,
        'search': FieldValue.arrayUnion(
            [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
      });
    }

    // log
    String Idmonth = '';
    String year = '';
    String month = '';
    String finalDate = '';
    _addlog() async {
      setState(() {
        DateFormat bulan = DateFormat('MM');
        Idmonth = bulan.format(DateTime.now());

        DateFormat tahun = DateFormat('yyyy');
        year = tahun.format(DateTime.now());

        DateFormat bulanini = DateFormat('dd MMM yyyy');
        month = bulanini.format(DateTime.now());

        DateFormat bulanok = DateFormat('HH:mm');
        finalDate = bulanok.format(DateTime.now());
      });
      await FirebaseFirestore.instance
          .collection('History')
          .doc(year)
          .collection('month')
          .doc(Idmonth)
          .collection('bulan')
          .doc('report_${month + finalDate}')
          .set({
        "bulan": month,
        "time": finalDate.toString(),
        "Log_Msg": "booking for ${widget.name} has been delete  By Admin"
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
            color: widget.event == '' ? Colors.white : color,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: Stack(
            children: [
              widget.attendance != 'Absent' ? iconattend : SizedBox(),
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
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.phone,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                        Row(
                          children: [
                            Text(
                              "Pax : ${widget.pax} - ${widget.event}  ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                            widget.event == '' ? SizedBox() : icon
                          ],
                        ),
                        Text(
                          "Table : ${(widget.no.join(" , ").contains(RegExp(r'\b(?:U10|U11|U12|U13|U14|U15|U16|U17|U18)\b')) ? widget.no.join(" , ").replaceAll('U', 'T') : widget.no.join(","))} ${widget.floor}",
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )),
                    Container(
                      width: 3,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Date & Time",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${widget.date}",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.time}",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 3,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Container(
                      width: 50,
                      child: Stack(
                        children: [
                          IconButton(
                              onPressed: () {
                                NAlertDialog(
                                  dialogStyle: DialogStyle(titleDivider: true),
                                  title: Text(
                                    "Delete",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("Delete This Booking ?...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  actions: <Widget>[
                                    TextButton(
                                        child: Text("Okay",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 192, 34, 23))),
                                        onPressed: () {
                                          deleteData(widget.name +
                                              widget.pax +
                                              widget.date +
                                              widget.phone);
                                          _bookpax();
                                          _log();
                                          _addlog();
                                          Navigator.pushAndRemoveUntil(context,
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return splash();
                                          }), (r) {
                                            return false;
                                          });
                                        }),
                                    TextButton(
                                        child: Text("Cancel",
                                            style: TextStyle(
                                              fontSize: 15,
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

                          // Text(_counter.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
