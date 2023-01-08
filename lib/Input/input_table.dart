import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m_toast/m_toast.dart';
import 'package:vsing/main.dart';
import 'package:vsing/pages/HomePage.dart';
import 'package:vsing/util/table.dart';
import '../style/color_constant.dart';
import '../pages/spalsh.dart';

class Table_Book extends StatefulWidget {
  final name;
  final pax;
  final date;
  final time;
  final phone;
  final event;
  final remark;
  final bookdata;
  final paxdata;

  const Table_Book(
      {super.key,
      required this.name,
      required this.date,
      required this.time,
      required this.phone,
      required this.event,
      required this.remark,
      required this.bookdata,
      required this.paxdata,
      required this.pax});

  @override
  State<Table_Book> createState() => _Table_BookState();
}

class _Table_BookState extends State<Table_Book> {
  bool select = false;
  var status = '';
  var newstatus = '';
  var no = '';
  var lantai = 'Choose Table Here';

  var selectedtable;
  var unpackedArr = [];
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
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

    _update() async {
      if (no.contains(RegExp(r'\b(?:T10|T11|T12|T13|T14|T15|T16|T17|T18)\b'))) {
        no = no.replaceAll('T', 'U');
      }
      await db
          .collection('table')
          .doc(lantai)
          .collection('lantai')
          .doc(no)
          .update({'status': 'Selected'});
    }

    _updateselected() async {
      if (no.contains(RegExp(r'\b(?:T10|T11|T12|T13|T14|T15|T16|T17|T18)\b'))) {
        no = no.replaceAll('T', 'U');
      }
      await db
          .collection('table')
          .doc(lantai)
          .collection('lantai')
          .doc(no)
          .update({'status': 'Avail'});
    }

    _getselected() async {
      final result = await db
          .collection('table')
          .doc(lantai)
          .collection('lantai')
          .where('status', isEqualTo: newstatus)
          .get();

      setState(() {
        selectedtable = result.docs.map((e) => e.data()).toList();
      });
    }

    // change value book and pax
    _bookpax() async {
      var book = int.parse(widget.bookdata) + 1;
      var pax = int.parse(widget.paxdata) + int.parse(widget.pax);
      await FirebaseFirestore.instance
          .collection('book&pax')
          .doc('book')
          .update({'book': book});
      await FirebaseFirestore.instance
          .collection('book&pax')
          .doc('pax')
          .update({'pax': pax});
    }

    // log activity
    String Idmonth = '';
    String year = '';
    String month = '';
    String finalDate = '';

    //
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
      await db
          .collection('History')
          .doc(year)
          .collection('month')
          .doc(Idmonth)
          .collection('bulan')
          .doc('report_${month + finalDate}')
          .set({
        "bulan": month,
        "time": finalDate.toString(),
        "Log_Msg":
            "new booking for ${widget.name}_${widget.phone} in table ${no}. Input By Admin"
      });
    }

    // for save the book
    _savebook() async {
      for (int x = 0; x <= selectedtable.length - 1; ++x) {
        if (selectedtable[x]['no']
            .contains(RegExp(r'\b(?:T10|T11|T12|T13|T14|T15|T16|T17|T18)\b'))) {
          unpackedArr.add(selectedtable[x]['no'].replaceAll('T', 'U'));
        } else {
          unpackedArr.add(selectedtable[x]['no']);
        }
      }
      await db.collection('user').doc(widget.date).set({'date': widget.date});
      await db
          .collection('user')
          .doc(widget.date)
          .collection('isi')
          .doc(widget.name + widget.pax + widget.date + widget.phone)
          .set({
        'name': widget.name,
        'pax': widget.pax,
        'remark': widget.remark,
        'date': widget.date,
        'table_no': unpackedArr == ""
            ? ""
            // JUMP KE SINI
            : FieldValue.arrayUnion(unpackedArr),
        'event': widget.event,
        "phone_number": widget.phone,
        'floor': lantai == "Choose Table Here" ? "" : lantai,
        'time': widget.time,
        "attendance": 'Absent',
        'search': FieldValue.arrayUnion(
            [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
      });

      for (int x = 0; x <= unpackedArr.length - 1; ++x) {
        if (selectedtable[x]['no']
            .contains(RegExp(r'\b(?:U10|U11|U12|U13|U14|U15|U16|U17|U18)\b'))) {
          // print("\n\n\n");
          // print(unpackedArr[x]['no']);
          // print(selectedtable[x]['no']);
          // // print("Now data len : $unpackedArr/");
          // // print("Now x value : $x");
          // print("\n\n\n");
          unpackedArr.add(selectedtable[x]['no'].replaceAll('U', 'T'));
        }
        await db
            .collection('table')
            .doc(lantai)
            .collection('lantai')
            .doc(unpackedArr[x].toString())
            .update({'status': 'Book'});
      }
      // await db
      //     .collection('table')
      //     .doc(lantai)
      //     .collection('lantai')
      //     .doc(unpackedArr.join(','))
      //     .update({'status': 'Book'});
    }

    _savebooknotable() async {
      await db.collection('user').doc(widget.date).set({'date': widget.date});

      await db
          .collection('user')
          .doc(widget.date)
          .collection('isi')
          .doc(widget.name + widget.pax + widget.date + widget.phone)
          .set({
        'name': widget.name,
        'pax': widget.pax,
        'remark': widget.remark,
        'date': widget.date,
        'table_no': unpackedArr == "" ? "" : FieldValue.arrayUnion(unpackedArr),
        'event': widget.event,
        "phone_number": widget.phone,
        'floor': lantai == "Choose Table Here" ? "" : lantai,
        "attendance": 'Absent',
        'time': widget.time,
        'search': FieldValue.arrayUnion(
            [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
      });
    }

    return Scaffold(
      // button

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (no == '') {
                // _savebooknotable();
                ShowMToast toast = ShowMToast();
                toast.errorToast(context,
                    message: "Please choose table",
                    backgroundColor: Color.fromARGB(255, 239, 238, 238),
                    alignment: Alignment.center,
                    duration: 1500);
              } else if (no != '' && status != '') {
                _addlog();
                _bookpax();
                _savebook();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return splash();
                }), (r) {
                  return false;
                });
              }
            },
            style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(primaryColor)),
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
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Select Table ',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
                      height: 300,
                      child: FutureBuilder(
                        future: db.collection('table').get(),
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
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        data[index].data()['lantai'],
                                        style: TextStyle(
                                          fontSize: 20,
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
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),

            // stage
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Center(
                child: Text(
                  'STAGE',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),

            // tablet

            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: FutureBuilder(
                  future: db
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
                            onTap: () {
                              setState(() {
                                no = data[index].data()['no'];
                                status = data[index].data()['status'];
                                newstatus = "Selected";
                              });
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
                              print(no);
                              _getselected();

                              if (status == 'Avail') {
                                _update();
                              } else if (status == 'Selected') {
                                _updateselected();
                              } else if (status == 'Book') {}
                            },
                            child: tableui(
                              cekno: no,
                              no: data[index].data()['no'],
                              status: status,
                              cekstatus: data[index].data()['status'],
                            ),
                          );
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
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Available',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // selected
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 221, 20, 124)),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Selected',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // reserved
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 2, 161, 234)),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Reserved',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.event,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.phone,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      widget.pax != '0'
                          ? Text(
                              'Pax : ${widget.pax}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                  width: 3,
                  height: 50,
                  color: Colors.black,
                ),
                Container(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.pax == ''
                          ? Text(
                              'Date & Time',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          : SizedBox(),
                      Text(
                        widget.date,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
