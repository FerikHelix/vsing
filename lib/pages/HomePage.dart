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
import 'package:m_toast/m_toast.dart';
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
  int bookdata = 0, bookall = 0;
  num paxdata = 0, paxall = 0;
  var hasil;

  var user = FirebaseAuth.instance.currentUser;
  var cekstatus;

  var paxxl, bookxl, paxnow, floor;
  List id = [], mnthnow = [], table = [], dataPax = [];
  var tgl, idtgl;

  void _detectIsDateSame() async {
    final data = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc(todayear)
        .collection('Reservation')
        .get();
    var tes = data.docs.map((e) => e.data()).toList();
  }

  var colorevent, datacolors, CurUser;

  void getbookpax() async {
    month = DateFormat('MMM').format(DateTime.now());
    // day
    final userPax = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('user_data')
        .where('date', isEqualTo: (datetimenow != '') ? datetimenow : today)
        .get();
    var bookpaxDay = userPax.docs.map((e) => e.data()['pax']).toList();

    for (var i = 0; i <= bookpaxDay.length; i++) {
      setState(() {
        bookdata = i;
      });
    }
    for (var i = 0; i < bookpaxDay.length; i++) {
      setState(() {
        paxdata += bookpaxDay[i];
      });
    }
    // day
    final userPaxm = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('user_data')
        .where('month', isEqualTo: month)
        .get();
    var bookpaxmonth = userPaxm.docs.map((e) => e.data()['pax']).toList();
    print(bookpaxmonth);

    for (var i = 0; i <= bookpaxmonth.length; i++) {
      setState(() {
        bookall = i;
      });
    }
    for (var i = 0; i < bookpaxmonth.length; i++) {
      setState(() {
        paxall += bookpaxmonth[i];
      });
    }
  }

  void _getuser() async {
    final userList = await db.collection('users').get();
    var userdata = userList.docs.map((e) => e.data()).toList();
    for (int x = 0; x < userdata.length; ++x) {
      if (user!.uid == userdata[x]['uid']) {
        if (userdata[x]['role'] == "Super Admin") {
          print(userdata[x]['role']);
          CurUser = userdata[x]['role'];
        } else if (userdata[x]['role'] == "Manager") {
          print(userdata[x]['role']);
          CurUser = userdata[x]['role'];
        } else if (userdata[x]['role'] == "Admin") {
          print(userdata[x]['role']);
          CurUser = userdata[x]['role'];
        } else if (userdata[x]['role'] == "Staff") {
          print(userdata[x]['role']);
          CurUser = userdata[x]['role'];
        }
      }
    }
  }

  // pull refresh
  Future<void> _refreshData() async {
    // Simulasi pengambilan data dari sumber eksternal
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      // Perbarui data dengan data baru
      paxall = 0;
      paxdata = 0;
      datetimenow = '';
      getbookpax();
      _getuser();
    });
  }

  @override
  void initState() {
    super.initState();
    DateFormat bul = DateFormat('d MMM yyyy');
    today = bul.format(DateTime.now());
    _today();
    _detectIsDateSame();
    getbookpax();
    _getuser();

    datetime = today;
    dateday = daynow;
    var dname = DateTime.now();
    Monthname = DateFormat('MMM').format(dname);

    final date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // =====================================================================\\
        // bootom app bar
        // =====================================================================\\
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableDetails(),
                ));
          },
          child: Container(
              width: 65.w,
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: Color.fromARGB(255, 56, 43, 83),
              ),
              child: Icon(
                Icons.add_circle,
                size: 60.w,
                color: Color.fromARGB(255, 121, 104, 229),
              )),
        ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Table_View()));
                      },
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
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
                          Text('Slot',
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
        backgroundColor: Color.fromRGBO(224, 223, 223, 0.91),
        body: RefreshIndicator(
          color: Color.fromARGB(255, 56, 43, 83),
          onRefresh: _refreshData,
          child: Column(
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
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            ),

                            Container(
                              width: 100.w,
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    history()));
                                      },
                                      child: Icon(
                                        Icons.history,
                                        color: Colors.white,
                                        size: 35.sp,
                                      )),
                                  SizedBox(width: 20.w),
                                  GestureDetector(
                                    onTap: () {
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
                                    child: Icon(
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
                                    paxdata = 0;
                                    paxall = 0;
                                    getbookpax();
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
                                  hintText: 'Search by name or phone number',
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 85, 71, 117),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
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
                                            primary: Color.fromARGB(255, 85, 71,
                                                117), // <-- SEE HERE
                                            onPrimary: Color.fromARGB(255, 255,
                                                255, 255), // <-- SEE HERE
                                            onSurface: Color.fromARGB(255, 85,
                                                71, 117), // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Color.fromARGB(255, 85,
                                                  71, 117), // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  initializeDateFormatting('id');

                                  String formattedDate = DateFormat.yMMMd('id')
                                      .format(datetimeRet!);
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
                                    paxdata = 0;
                                    paxall = 0;
                                    getbookpax();
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
                            child: Container(
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
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                              child: Container(
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
                                          color:
                                              Color.fromARGB(255, 54, 51, 140),
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'Pax',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 54, 51, 140),
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
                                        color: Color.fromARGB(255, 54, 51, 140),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: 3.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 54, 51, 140),
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                    ),
                                    Text(
                                      paxall.toString(),
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 54, 51, 140),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          ))
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
                          .collection('Vsing-rsv')
                          .doc('reservation')
                          .collection('user_data')
                          .where("search", arrayContains: name)
                          .snapshots()
                      : datetimenow == ''
                          ? FirebaseFirestore.instance
                              .collection('Vsing-rsv')
                              .doc('reservation')
                              .collection('user_data')
                              // .orderBy('data', descending: false)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection('Vsing-rsv')
                              .doc('reservation')
                              .collection('user_data')
                              .where('date', isEqualTo: datetime)
                              .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 54, 51, 140),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("eror"),
                      );
                    }

                    var data = snapshot.data!.docs;

                    if (data.isEmpty) {
                      paxdata = 0;
                      paxall = 0;
                    }

                    return (data.isEmpty)
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 700.h,
                            child: ListView(
                              children: [
                                Center(
                                    child: Text(
                                  'No Booking Data',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 85, 71, 117),
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ],
                            ),
                          )
                        : GroupedListView<dynamic, String>(
                            physics: BouncingScrollPhysics(),
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
                                                      paxdata = 0;
                                                      paxall = 0;
                                                      getbookpax();
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
                                  (CurUser == 'Staff')
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r)),
                                              elevation: 16,
                                              child: Container(
                                                height: 150.h,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      'only can be read or write by backend employees.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 36, 30, 50),
                                                        fontSize: 24.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'Ok',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          85,
                                                                          71,
                                                                          117),
                                                                  fontSize:
                                                                      24.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Edit_Cos(
                                                    detailPromo:
                                                        data['promo_detail'],
                                                    promo: data['promo'],
                                                    monthdata: data['month'],
                                                    bookmonth: bookall,
                                                    paxmonth: paxall,
                                                    idmonth: idmonth,
                                                    todayear: todayear,
                                                    week: data['week'],
                                                    dateday: data['dateday'],
                                                    fulldate: data['datefull'],
                                                    name: data['name'],
                                                    id: data['id'],
                                                    attendance:
                                                        data['attendance'],
                                                    remark: data['remark'],
                                                    event: data['event'],
                                                    phone: data['phone_number'],
                                                    pax: data['pax'].toString(),
                                                    date: data['date'],
                                                    time: data['time'],
                                                    no_table: data['table_no'],
                                                    floor: data['floor'],
                                                  )));
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
                                  pax: data['pax'].toString(),
                                  date: data['date'],
                                  time: data['time'],
                                  no: data['table_no'],
                                  floor: data['floor'],
                                  id: data['id'],
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
