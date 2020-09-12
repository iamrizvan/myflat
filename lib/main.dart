import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myflat/add_tenant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'myflat',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _buildHomePage());
  }
}

class _buildHomePage extends StatelessWidget {
  const _buildHomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance.collection('myflat').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading.. ');

              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 10,
                      child: Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.only(
                            topRight: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0),
                          )),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        image: DecorationImage(
                                            image: AssetImage("assets/srk.jpg"),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Stack(
                                  children: [
                                    Container(
                                        height: 90,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data.documents[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 5,
                                            ),
                                            Text(
                                              'Joining Date : ${snapshot.data.documents[index]['joiningDate']}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),
                                            ),
                                            Container(
                                              height: 5,
                                            ),
                                            Text(
                                              'Mobile : ${snapshot.data.documents[index]['mobile']}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        )),
                                    Positioned(
                                        top: 5,
                                        right: 8,
                                        child: Container(
                                            height: 30,
                                            width: 30,
                                            child: loadPackage(
                                                '${snapshot.data.documents[index]['package']}')))
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  });
            }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTenant()));
            }),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey,
          child: Container(
            height: 50,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}

Widget loadPackage(String pack) {
  print(pack);
  if (pack == 'VIP') {
    return Image.asset('assets/vip.png');
  } else if (pack == 'Premium') {
    return Image.asset('assets/premium.png');
  } else {
    return Image.asset('assets/standard.png');
  }
}
