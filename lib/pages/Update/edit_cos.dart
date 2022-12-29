import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vsing/pages/Update/edit_table.dart';
import 'package:vsing/pages/Input/input_table.dart';
import 'package:vsing/style/color_constant.dart';
import 'package:intl/intl.dart';

class Edit_Cos extends StatefulWidget {
  final name;
  final phone;
  final date;
  final floor;
  final no_table;
  final time;
  final pax;
  final event;

  const Edit_Cos({
    super.key,
    required this.name,
    required this.phone,
    required this.date,
    required this.floor,
    required this.no_table,
    required this.time,
    required this.pax,
    required this.event,
  });

  @override
  State<Edit_Cos> createState() => _Edit_CosState();
}

class _Edit_CosState extends State<Edit_Cos> {
  // input
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  int count = 0;
  String datetime = "";
  String time = "";
  var no = "";

  // event
  var brtdy = "Brithday";
  var aniv = "Anniversary";
  var comp = "Company";
  var othr = "Bachelor Night";

  var onklik = '';
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onklik = widget.event;
    var pax = int.parse(widget.pax);
    assert(pax is int);

    count = pax;
    name.text = widget.name;
    number.text = widget.phone;
    // no = widget.no_table.toString();
  }

  _updatetable() async {
    for (int x = 0; x <= widget.no_table.length - 1; ++x) {
      await FirebaseFirestore.instance
          .collection('table')
          .doc(widget.floor)
          .collection('lantai')
          .doc(widget.no_table[x].toString())
          .update({'status': 'Selected'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              _updatetable();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Edit_Book(
                            floor: widget.floor,
                            no_table: widget.no_table,
                            id: widget.name + widget.pax + widget.date,
                            event: onklik,
                            phone:
                                number.text == '' ? widget.phone : number.text,
                            name: name.text == '' ? widget.name : name.text,
                            date: datetime == '' ? widget.date : datetime,
                            time: time == '' ? widget.time : time,
                            pax: count.toString(),
                          )));
            },
            style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(primaryColor)),
            ),
            child: const Text(
              "CHOOSE TABLE",
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text(
          'V Sing',
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
                  height: 40,
                  child: TextFormField(
                    controller: name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'data kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // hintText: widget.name,
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
                  height: 40,
                  child: TextFormField(
                    controller: number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'data kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // hintText: widget.phone,
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
                datetime == ""
                    ? widget.date + " - " + widget.time
                    : datetime + ' - ' + time,
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 20,
                ),
              ),

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
                    String formattedMonth =
                        DateFormat.MMM().format(datetimeRet!);
                    setState(() {
                      datetime =
                          "${datetimeRet.day} $formattedMonth ${datetimeRet.year}";
                      time =
                          '${selectedTime!.hour}:${(selectedTime.minute == 0) ? "00" : selectedTime.minute}';
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
              Text("Special Book",
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
                    width: 110,
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
                                        Color(primaryColor)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == brtdy
                            ? Text(
                                brtdy,
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                brtdy,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF494753)),
                              )),
                  ),
                  // anniv
                  SizedBox(
                    width: 110,
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
                                        Color(primaryColor)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == aniv
                            ? Text(
                                aniv,
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                aniv,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF494753)),
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
                    width: 110,
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
                                        Color(primaryColor)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == comp
                            ? Text(
                                comp,
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                comp,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF494753)),
                              )),
                  ),
                  // bachelor
                  SizedBox(
                    width: 110,
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
                                        Color(primaryColor)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == othr
                            ? Text(
                                othr,
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                othr,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF494753)),
                              )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
