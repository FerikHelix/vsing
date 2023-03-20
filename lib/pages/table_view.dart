import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../util/table.dart';

class Table_View extends StatefulWidget {
  const Table_View({super.key});

  @override
  State<Table_View> createState() => _Table_ViewState();
}

class _Table_ViewState extends State<Table_View> {
  var tahunnow = '', monthidname = '', datenow = '', lantaiSelect = '';
  List lantai = ['floor1', 'floor2'];

  // List lantai = ['floor1', 'floor2'];

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    DateFormat bsk5 = DateFormat('d MMM yyyy');
    datenow = bsk5.format(now);
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
          'Table ',
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
                  IconButton(
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

                        initializeDateFormatting('id');

                        String formattedDate =
                            DateFormat.yMMMd('id').format(datetimeRet!);

                        setState(() {
                          datenow = formattedDate.toString();
                          tahunnow = datetimeRet.year.toString();
                        });
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        size: 30,
                      )),

                  // lantaii
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
                  IconButton(
                    onPressed: () async {
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
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black,
                      size: 45.w,
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
                              color: Color.fromARGB(255, 2, 161, 234)),
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
                            .doc(tahunnow)
                            // .collection('month')
                            // .doc(monthid)
                            .collection('Reservation')
                            .doc(datenow)
                            .collection('table')
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
                            return tableui(
                                label: data[index].data()['no'],
                                ceklabel: [],
                                warna: data[index].data()['status']);
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
