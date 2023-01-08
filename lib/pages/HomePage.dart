import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:vsing/Input/input_cos.dart';
import 'package:vsing/Update/edit_cos.dart';
import 'package:vsing/pages/historylog.dart';
import 'package:vsing/util/detailbook.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // database
  final db = FirebaseFirestore.instance;

  String datetime = '';

// Search func
  String name = "";
  // today date
  var today = '';
  _today() {
    DateFormat bul = DateFormat('d MMM yyyy');
    today = bul.format(DateTime.now());
  }

  String month = '';
  String year = '';
  String bulma = '';

  _history() {
    setState(() {
      DateFormat bulan = DateFormat('MM');
      month = bulan.format(DateTime.now());

      DateFormat tahun = DateFormat('yyyy');
      year = tahun.format(DateTime.now());
    });
    var tahun = int.parse(year);
    assert(tahun is int);
    final hasil = tahun + 1;
    db.collection('History').doc(hasil.toString()).set({
      'tahun': hasil.toString(),
    });
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('01')
        .set({"bulan": "JAN", 'Id': '01'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('02')
        .set({"bulan": "FEB", 'Id': '02'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('03')
        .set({"bulan": "MAR", 'Id': '03'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('04')
        .set({"bulan": "APR", 'Id': '04'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('05')
        .set({"bulan": "MEI", 'Id': '05'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('06')
        .set({"bulan": "JUN", 'Id': '06'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('07')
        .set({"bulan": "JUL", 'Id': '07'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('08')
        .set({"bulan": "AGS", 'Id': '08'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('09')
        .set({"bulan": "SEP", 'Id': '09'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('10')
        .set({"bulan": "OKT", 'Id': '10'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('11')
        .set({"bulan": "NOV", 'Id': '11'});
    db
        .collection('History')
        .doc(hasil.toString())
        .collection('month')
        .doc('12')
        .set({"bulan": "DES", 'Id': '12'});
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => history(
                  bulan: month,
                  tahun: year,
                )));
  }

  var bookdata;
  var paxdata;
  Future _tesbook() async {
    final data =
        await FirebaseFirestore.instance.collectionGroup('book&pax').get();

    var tes = data.docs.map((e) => e.data()).toList();

    setState(() {
      bookdata = tes[0]['book'];
      paxdata = tes[1]['pax'];
    });
  }

  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _today();
    datetime = today;
    // Book();
    // Pax();
    _tesbook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableDetails(
                    bookdata: bookdata.toString(),
                    paxdata: paxdata.toString(),
                  ),
                ));
          },
          child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 54, 51, 140),
              ),
              child: Icon(
                Icons.add_circle,
                size: 50,
                color: Color.fromARGB(255, 121, 104, 229),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          color: Color.fromARGB(255, 54, 51, 140),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'v 1.05',
              style: TextStyle(
                color: Color.fromARGB(234, 255, 254, 254),
              ),
            ),
          ),
          // child: Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 40,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           topRight: Radius.circular(20),
          //           topLeft: Radius.circular(20)),
          //       color: Color.fromARGB(255, 54, 51, 140)),
          // ),
        ),
        backgroundColor: Color.fromARGB(232, 255, 253, 253),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Color.fromARGB(255, 54, 51, 140),

              //
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "V Sing Ipoh Soho",
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                        // history log //
                        IconButton(
                            onPressed: () {
                              _history();
                            },
                            icon: Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 30,
                            ))
                      ],
                    ),
                    Text(
                      "Reservation",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: Row(
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
                              
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.search, color: Colors.white),
                                hintText:
                                    'Search by name, date or phone number',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 121, 104, 229),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: IconButton(
                              onPressed: () async {
                                var datetimeRet = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100));

                                initializeDateFormatting('id');

                                String formattedDate =
                                    DateFormat.yMMMd('id').format(datetimeRet!);
                                setState(() {
                                  datetime = formattedDate;
                                });
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
                  ],
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 54, 51, 140),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        // width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Book',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 54, 51, 140),
                                  fontSize: 10),
                            ),
                            Text(
                              bookdata.toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 54, 51, 140),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        // width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pax',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 54, 51, 140),
                                  fontSize: 10),
                            ),
                            Text(
                              paxdata.toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 54, 51, 140),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                datetime,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: (name != "" && name != null)
                  ? FirebaseFirestore.instance
                      .collection('user')
                      .doc(datetime)
                      .collection('isi')
                      .where("search", arrayContains: name)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('user')
                      .doc(datetime)
                      .collection('isi')
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
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Edit_Cos(
                                    name: data[index]['name'],
                                    id: data[index]['name'] +
                                        data[index]['pax'] +
                                        data[index]['date'] +
                                        data[index]['phone_number'],
                                    attendance: data[index]['attendance'],
                                    remark: data[index]['remark'],
                                    event: data[index]['event'],
                                    phone: data[index]['phone_number'],
                                    pax: data[index]['pax'],
                                    date: data[index]['date'],
                                    time: data[index]['time'],
                                    no_table: data[index]['table_no'],
                                    floor: data[index]['floor'],
                                    bookdata: bookdata,
                                    paxdata: paxdata)));
                      },
                      child: detail_book(
                          bookdata: bookdata,
                          paxdata: paxdata,
                          attendance: data[index]['attendance'],
                          remark: data[index]['remark'],
                          event: data[index]['event'],
                          name: data[index]['name'],
                          phone: data[index]['phone_number'],
                          pax: data[index]['pax'],
                          date: data[index]['date'],
                          time: data[index]['time'],
                          no: data[index]['table_no'],
                          floor: data[index]['floor']),
                    );
                  },
                );
              },
            )),
          ],
        ));
  }
}
