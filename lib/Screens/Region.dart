import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:postmaster/Components/animate.dart';

class Region extends StatefulWidget {
  @override
  _RegionState createState() => _RegionState();
}

class _RegionState extends State<Region> {
  Future<List<dynamic>> regionData;
  String regionName;

  Future<List<dynamic>> fetchRegionData() async {
    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/order/getdetail.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "user": "admin",
        "password": "1234",
        "table_name": "region"
      },
    );
    print(res.body);
    var responseData = json.decode(res.body);

    if (responseData["status"] == 200) {}

    //print(responseData);

    return json.decode(res.body)['message'];
  }

  Future<http.Response> fetchRegion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/region.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    print(res.body);
    var responseData = json.decode(res.body);

    if (responseData["status"] == 200) {
      setState(() {
        regionName = responseData["message"][0]['region_name'];
      });
    }

    //print(responseData);

    return res;
  }

  Future<http.Response> setRegion(String id, String region) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map data = {"region_id": id, "region_name": region};

    String body = json.encode(data);

    http.Response res = await http.post(
        'https://www.mitrahtechnology.in/apis/mitrah-api/region_set.php',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token,
        },
        body: body);
    print(res.body);
    if (res.body.isNotEmpty) {
      var responseData = json.decode(res.body);
      if (responseData["status"] == 200) {
        showDialog(
          context: context,
          builder: (context) =>
              CustomDialog("Success", responseData['message'], "Okay", 2),
        );
      }
    }

    //print(responseData);

    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRegion();
    regionData = fetchRegionData();
  }

  Widget listWidget(String id, String region) {
    if (region == regionName) {
      return ListTile(
        title: Text(region),
        //subtitle: Text(_location(snapshot.data[index])),
        trailing: Icon(Icons.done),
      );
    } else {
      return InkWell(
        onTap: () {
          print(id + region);
          setRegion(id, region);
        },
        child: ListTile(
          title: Text(region),
          //subtitle: Text(_location(snapshot.data[index])),
          //trailing: Icon(Icons.done),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Region",
              style: TextStyle(
                  fontFamily: "RobotoBold",
                  fontSize: 20.0,
                  color: Color(0xFF2AD0B5)),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            )),
        body: FutureBuilder<List<dynamic>>(
          future: regionData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          listWidget(snapshot.data[index]['id'],
                              snapshot.data[index]['region']),
                          /*ListTile(
                            title: Text(snapshot.data[index]['region']),
                            //subtitle: Text(_location(snapshot.data[index])),
                            trailing: Icon(Icons.done),
                          )*/
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
