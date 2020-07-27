import 'package:absen/screen/login.dart';
import 'package:flutter/material.dart';
import 'addData.dart';
import 'kalender.dart';
import '../shared.dart';
import 'report.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children:<Widget>[ Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Selamat Datang!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0),
                            ),
                            Text(
                              'Apa yang ingin anda lihat saat ini?',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.exit_to_app),
                          tooltip: 'Keluar',
                          color: Color(0xff128c7e),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          onTap: (){Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Kalender(),
                          ));},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Color(0xFF128c7e),
                                borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Icon(Icons.calendar_today),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                                    Text('Kalender',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                                    Text('Lihat absensi berdasar tanggal', style: TextStyle(fontSize: 12, color: Colors.white),)
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Material(
                        child: InkWell(
                          onTap: (){print('x');},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0xFF128c7e),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Icon(Icons.supervised_user_circle),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                                    Text('Santri',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                                    Text('Lihat atau tambah santri', style: TextStyle(fontSize: 12, color: Colors.white),)
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          onTap: (){Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Report(),
                          ));},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0xFF128c7e),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Icon(Icons.print),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                                    Text('Cetak',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                                    Text('Download rekap absensi', style: TextStyle(fontSize: 12, color: Colors.white),)
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Material(
                        child: InkWell(
                          onTap: (){print('x');},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0xFF128c7e),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Icon(Icons.supervised_user_circle),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                                    Text('Statistik',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                                    Text('Lihat statistik absensi santri', style: TextStyle(fontSize: 12, color: Colors.white),)
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF128c7e),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddData(),
            ));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
