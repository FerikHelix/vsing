import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:m_toast/m_toast.dart';
import 'package:vsing/Input/input_table.dart';
import 'package:vsing/style/color_constant.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TableDetails extends StatefulWidget {
  final bookdata;
  final paxdata;
  const TableDetails({
    super.key,
    required this.bookdata,
    required this.paxdata,
  });

  @override
  State<TableDetails> createState() => _TableDetailsState();
}

class _TableDetailsState extends State<TableDetails> {
  // input
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController remark = TextEditingController();
  int count = 0;
  String datetime = "";
  String time = "";

  // event
  var brtdy = "Brithday";
  var aniv = "Anniversary";
  var comp = "Company";
  var othr = "Bachelor Night";

  var onklik = '';

  @override
  Widget build(BuildContext context) {
    // color
    var color;
    if (onklik == 'Brithday') {
      color = Color.fromARGB(255, 39, 83, 171);
    } else if (onklik == 'Anniversary') {
      color = Color.fromARGB(255, 237, 84, 84);
    } else if (onklik == 'Company') {
      color = Color.fromARGB(255, 128, 85, 140);
    } else if (onklik == 'Bachelor Night') {
      color = Color.fromARGB(255, 28, 103, 88);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text(
          'V Sing Ipoh Soho',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // input name
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Name",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: TextFormField(
                    controller: name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 238, 238, 238),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),

              // phone number input
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Phone Number",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: TextFormField(
                    controller: number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 238, 238, 238),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // const Padding(
              //   padding: EdgeInsets.only(bottom: 40),
              //   child: _userName(),
              // ),
              Text(
                "Pax",
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // minus btn
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (count > 0) {
                            count -= 1;
                          } else {
                            // do nothing
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 40,
                        color: Color(primaryColor),
                      )),
                  SizedBox(width: 20),
                  Text(
                    count.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(primaryColor),
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Plus btn
                  IconButton(
                      onPressed: () {
                        setState(() {
                          count += 1;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle,
                        size: 40,
                        color: Color(primaryColor),
                      )),
                ],
              ),
              SizedBox(height: 20),
              Text(
                datetime == "" ? "Choose Date & Time" : datetime + ' - ' + time,
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                // height: 100,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(primaryColor)),
                  ),
                  onPressed: () async {
                    var datetimeRet = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    var selectedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                      context: context,
                    );
                    String _addMissingZero(int minute) {
                      if (minute < 10) {
                        return '0$minute';
                      } else {
                        return minute.toString();
                      }
                    }

                    // Menggali dokumentasi ehe
                    initializeDateFormatting('id');
                    String formattedDate =
                        DateFormat.yMMMd('id').format(datetimeRet!);

                    setState(() {
                      datetime = formattedDate;
                      time =
                          '${selectedTime!.hour}:${_addMissingZero(selectedTime.minute)}';
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.date_range),
                      Text(
                        "Pick a date",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Book For",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // brtdy
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = brtdy;
                            print(onklik);
                          });
                        },
                        style: onklik == brtdy
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 165, 133, 239)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == brtdy
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.cakeCandles,
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.cakeCandles,
                                        color: Color(0xFF494753),
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                  // anniv
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = aniv;
                            print(onklik);
                          });
                        },
                        style: onklik == aniv
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 247, 156, 177)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == aniv
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Color(0xFF494753),
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // company
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = comp;
                            print(onklik);
                          });
                        },
                        style: onklik == comp
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 140, 155, 160)))
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == comp
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: Icon(Icons.business_center)),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      comp,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: Icon(Icons.business_center,
                                          color: Color(0xFF494753))),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      comp,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                  // bachelor
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = othr;
                            print(onklik);
                          });
                        },
                        style: onklik == othr
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 86, 153, 109)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == othr
                            ? Row(
                                children: [
                                  SizedBox(width: 20, child: Icon(Icons.group)),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      othr,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: Icon(Icons.group,
                                          color: Color(0xFF494753))),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      othr,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Remark",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: TextFormField(
                    controller: remark,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 238, 238, 238),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (datetime == '') {
                        ShowMToast toast = ShowMToast();
                        toast.errorToast(context,
                            message: "Please Pick A Date",
                            backgroundColor: Color.fromARGB(255, 239, 238, 238),
                            alignment: Alignment.center,
                            duration: 1500);
                      } else if (datetime != '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Table_Book(
                                      bookdata: widget.bookdata,
                                      paxdata: widget.paxdata,
                                      remark: remark.text,
                                      event: onklik,
                                      phone: number.text,
                                      name: name.text,
                                      date: datetime,
                                      time: time,
                                      pax: count.toString(),
                                    )));
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color.fromRGBO(73, 71, 83, 1)),
                    ),
                    child: const Text(
                      "CHOOSE TABLE",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
