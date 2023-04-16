import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Table_View extends StatefulWidget {
  const Table_View({super.key});

  @override
  State<Table_View> createState() => _Table_ViewState();
}

class _Table_ViewState extends State<Table_View> {
  var tahunnow = '', monthidname = '', datenow = '', lantaiSelect = 'floor1';
  var unpackedArr;
  List lantai = [], userData = [], tableUser = [], userLantai = [];

  _cekDatas() async {
    userLantai.clear();
    // table
    final table = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('table_master')
        .get();

    lantai = table.docs.map((e) => e.data()['lantai']).toList();
    print(lantai);
    // user
    final user = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('user_data')
        .where('date', isEqualTo: datenow)
        .get();
    userData = user.docs.map((e) => e.data()).toList();
    // print(userData);
    for (var i = 0; i < userData.length; i++) {
      setState(() {
        userLantai.addAll(userData[i]['table_no']);
        print(userData[i]['table_no']);

        // if (userData[i]['table_no']
        //     .contains(RegExp(r'\b(?:U10|U11|U12|U13|U14|U15|U16|U17|U18)\b'))) {
        //   unpackedArr.add(userData[i]['table_no'].replaceAll('U', 'T'));
        //   print(unpackedArr);
        // } else {
        //   unpackedArr.add(userData[i]['table_no']);
        //   print(unpackedArr);
        // }
      });
    }
  }

  var status;
  // _getWarna(String idno) async {
  //   for (var i = 0; i < userLantai.length; i++) {
  //     if (userLantai[i] == idno) {
  //       status = 'Book';
  //       // print(userLantai[i]);
  //     } else {
  //       status = 'Avail';
  //     }
  //   }

  //   // print(status);
  // }

  @override
  void initState() {
    _cekDatas();
    super.initState();
    datenow = DateFormat('d MMM yyyy').format(DateTime.now());
    tahunnow = DateTime.now().year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          'Slot',
          style: TextStyle(
              fontSize: 35.sp,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
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

                      initializeDateFormatting('id');

                      String formattedDate =
                          DateFormat.yMMMd('id').format(datetimeRet!);

                      setState(() {
                        datenow = formattedDate.toString();
                        tahunnow = datetimeRet.year.toString();
                        _cekDatas();
                      });
                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(datenow),
                            Container(
                              height: 3.h,
                              width: 80.w,
                              color: Colors.black,
                            )
                          ],
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  // lantaii

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 300.h,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: lantai.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 8,
                                            right: 8),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              lantaiSelect = lantai[index];
                                            });
                                          },
                                          child: Text(
                                            lantai[index],
                                            style: TextStyle(
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(lantaiSelect),
                            Container(
                              height: 3.h,
                              width: 80.w,
                              color: Colors.black,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.black,
                          size: 45.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // info

              // available
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 15.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey),
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Available',
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  // reserved
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 15.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 221, 20, 124)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Booked',
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),

              // stage
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: Center(
                  child: Text(
                    'STAGE',
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // tablet

              Container(
                width: MediaQuery.of(context).size.width,
                height: 600.h,
                child: StreamBuilder(
                    stream: (lantaiSelect == '')
                        ? FirebaseFirestore.instance
                            .collection('lantai')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('Vsing-rsv')
                            .doc('reservation')
                            .collection('table_master')
                            .doc(lantaiSelect)
                            .collection('lantai')
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

                      return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 60,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10),
                          itemCount: data.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var colorbg;
                            colorbg = Colors.grey;
                            for (var i = 0; i < userLantai.length; ++i) {
                              if (data[index].data()['no'] == userLantai[i]) {
                                colorbg = Color.fromARGB(255, 221, 20, 124);
                                break;
                              } else {
                                colorbg = Colors.grey;
                              }
                            }
                            return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: colorbg,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(data[index].data()['no']));
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
