import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
      home: wespivolt(),
    ));

class wespivolt extends StatefulWidget {
  @override
  _wespivoltState createState() => _wespivoltState();
}

class _wespivoltState extends State<wespivolt> {
  var mpower, mvolt, mcurrent, psd, vsurface;
  var vvsd, avsd, speedvsd, freqvsd, cli, overload, cth;
  var tempcorrect, bht;
  var voltDrop;

  double _awg1 = 0.23, _awg4 = 0.451612903225806, _awg6 = 0.72, _vdrop = 0;
  bool _checkedAwg1 = false, _checkedAwg4 = false, _checkedAwg6 = false;

  // Motor Power
  final TextEditingController t1 = new TextEditingController(text: "0");
  //Motor Volt
  final TextEditingController t2 = new TextEditingController(text: "0");
  //Motor Current
  final TextEditingController t3 = new TextEditingController(text: "0");
  //PSD
  final TextEditingController t4 = new TextEditingController(text: "0");
  //BHT
  final TextEditingController t5 = new TextEditingController(text: "0");

  void doCalculate() {
    setState(() {
      mpower = int.parse(t1.text);
      mvolt = int.parse(t2.text);
      mcurrent = int.parse(t3.text);
      psd = int.parse(t4.text);
      bht = int.parse(t5.text);
      tempcorrect = 1 + 0.00214 * (bht - 77);
      voltDrop = psd * mcurrent * _vdrop / 1000 * tempcorrect;
      vsurface = (mvolt + voltDrop).toStringAsFixed(0);
      vvsd = 380;
      avsd = 4 * mcurrent;
      speedvsd = 3600;
      freqvsd = 60;
      cli = (1.1 * avsd).toStringAsFixed(0);
      overload = 110;
      cth = avsd;
    });
  }

  void doClear() {
    setState(() {
      t1.clear();
      t2.clear();
      t3.clear();
      t4.clear();
      t5.clear();
      mpower = 0;
      mvolt = 0;
      mcurrent = 0;
      bht = 0;
      vsurface = 0;
      vvsd = 0;
      avsd = 0;
      speedvsd = 0;
      freqvsd = 0;
      cli = 0;
      overload = 0;
      cth = 0;
      _checkedAwg1 = false;
      _checkedAwg4 = false;
      _checkedAwg6 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'WespiVolt 0.1',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpg'),
                  radius: 30,
                ),
              ),

              Text(
                "Data Input",
                style: TextStyle(color: Colors.white),
              ),

              Divider(
                height: 3.0,
                color: Colors.grey,
              ),

              //Motor Power
              Container(
                height: 30,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Motor Nameplate HP",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      hintText: "Masukan Nameplate Motor HP",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      counterText: ""),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  controller: t1,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Divider(
                height: 5.0,
                color: Colors.grey,
              ),

              //Motor Volt
              Container(
                height: 30,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Motor Nameplate Volt",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                      hintText: "Masukan Nameplate Motor Volt (V)",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.white),
                      border: OutlineInputBorder(),
                      counterText: ""),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  controller: t2,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Divider(
                height: 5.0,
                color: Colors.grey,
              ),

              //Motor Ampere
              Container(
                height: 30,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Motor Nameplate Ampere",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                      hintText: "Masukan Nameplate Motor Ampere (A)",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.white),
                      border: OutlineInputBorder(),
                      counterText: ""),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  controller: t3,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Divider(
                height: 5.0,
                color: Colors.grey,
              ),

              //PSD
              Container(
                height: 30,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Pump Setting Depth (Ft)",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                      hintText: "Masukan Pump Setting Depth (ft)",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.white),
                      border: OutlineInputBorder(),
                      counterText: ""),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  controller: t4,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Divider(
                height: 5.0,
                color: Colors.grey,
              ),

              //BHT
              Container(
                height: 30,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Bottome Hole Temp. (F)",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                      hintText: "Masukkan Bottom Hole Temp. (F)",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.white),
                      border: OutlineInputBorder(),
                      counterText: ""),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  controller: t5,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Text("Cable size", style: TextStyle(color: Colors.white)),

              Divider(
                height: 3.0,
                color: Colors.grey,
              ),
              //Cable
              Container(
                height: 30,
                child: CheckboxListTile(
                  title: Text(
                    "AWG#1",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  value: _checkedAwg1,
                  onChanged: (awg) {
                    setState(() {
                      _checkedAwg1 = awg;
                      if (_checkedAwg1) _vdrop = _awg1;
                    });
                  },
                ),
              ),

              Container(
                height: 30,
                child: CheckboxListTile(
                  title: Text(
                    "AWG#4",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  value: _checkedAwg4,
                  onChanged: (awg) {
                    setState(() {
                      _checkedAwg4 = awg;
                      if (_checkedAwg4) _vdrop = _awg4;
                    });
                  },
                ),
              ),

              Container(
                height: 30,
                child: CheckboxListTile(
                  title: Text(
                    "AWG#6",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  value: _checkedAwg6,
                  onChanged: (awg) {
                    setState(() {
                      _checkedAwg6 = awg;
                      if (_checkedAwg6) _vdrop = _awg6;
                    });
                  },
                ),
              ),

              //end cable

              Divider(
                height: 15.0,
                color: Colors.grey,
              ),
              Center(
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Text(
                    "Motor Spec: $mpower HP, $mvolt Volt, $mcurrent A",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Center(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueGrey,
                  ),
                  child: Text(
                    "Voltage Surface Required: $vsurface Volt @ $bht F",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Text("VSD Setting", style: TextStyle(color: Colors.white)),
              Divider(
                height: 5.0,
                color: Colors.grey,
              ),

              Container(
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueGrey,
                ),
                child: Text(
                  "Rated Motor Power : $mpower HP, Rated Motor Current : $avsd A",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),

              Container(
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueGrey,
                ),
                child: Text(
                  "Rated Motor Volt : $vvsd V, Rated Motor Freq. : $freqvsd Hz",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),

              Container(
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueGrey,
                ),
                child: Text(
                  "CLI: $cli A, Overload : $overload %, Current Threshold : $cth A",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    child: Text("Clear"),
                    onPressed: doClear,
                    color: Colors.redAccent,
                  ),
                  new MaterialButton(
                    child: Text("Calculate"),
                    onPressed: doCalculate,
                    color: Colors.blue,
                  ),
                ],
              ),
//footter
              Divider(
                height: 10.0,
                color: Colors.grey,
              ),

              Center(
                child: Text(
                  "WespiVolt Version 0.1 - Copyright @2021",
                  style: TextStyle(color: Colors.white, fontSize: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
