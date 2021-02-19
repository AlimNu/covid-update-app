import 'dart:convert';

import 'package:covid_monitoring/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';


class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _mySelection;
  final String url = "https://api.covid19api.com/countries";

  List<Countries> _dataCountry = List();
  // ignore: missing_return
  Future<String> _getCountryList() async {
    await http.get(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    ).then((response) {
      var data = json.decode(response.body);
      for(var c in data){
        Countries country = Countries(c['Country'],c['Slug'],c['Iso2']);
        _dataCountry.add(country);
      }
      print(_dataCountry.length);
    });
  }

  @override
  void initState() {
    super.initState();
    this._getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/header.png'),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.location_pin, color: kPrimaryLightColor,),
                  Expanded(
                      child: SearchableDropdown.single(
                        iconSize: 24,
                        closeButton: 'Close',
                        value: _mySelection,
                        hint: Text('Select Country'),
                        isExpanded: true,
                        underline: Padding(
                          padding: EdgeInsets.all(1),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            _mySelection = newValue;
                          });
                        },
                        items: _dataCountry.map((country) {
                          return DropdownMenuItem(
                            child: new Text(country.country),
                            value: country.country,
                          );
                        }).toList(),
                        style: TextStyle(color: kPrimaryLightColor),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.transparent,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/images/positif.png', height: 120, width: 100,),
                      SizedBox(height: 10,),
                      Text("Total Death", style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryLightColor),),
                      SizedBox(height: 5,),
                      Text("2439639"),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Image.asset('assets/images/positif++.png', height: 120, width: 100,),
                      SizedBox(height: 10,),
                      Text("Total Confirmed", style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryLightColor),),
                      SizedBox(height: 5,),
                      Text("110160813"),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Image.asset('assets/images/negatif.png', height: 120, width: 100,),
                      SizedBox(height: 10,),
                      Text("Total Recover", style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryLightColor),),
                      SizedBox(height: 5,),
                      Text("62101472")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Countries {
  final String country;
  final String slug;
  final String iso2;

  Countries(this.country, this.slug, this.iso2);

}
