import 'package:flutter/material.dart';
import 'footer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';
  static List mainmenu = [
    "Basic Details",
    "Bank Details",
    "Damage Details",
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Colors.cyan,
       appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // here the desired height
        child: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/TamilNadu_Logo.png",
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text('Disater Management \n Perambalur',
          textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ]),
      ),),
      ),
            // actions: <Widget>[
            //   PopupMenuButton<int>(
            //       icon: Icon(Icons.more_vert, color: Colors.white),
            //       tooltip: 'This is tooltip',
            //       itemBuilder: (context) => [
            //         PopupMenuItem(
            //           value: 1,
            //           child: Text(
            //             'Home',
            //             style: TextStyle(
            //                 color: Colors.purple,
            //                 fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //         PopupMenuItem(
            //           value: 2,
            //           child: Text(
            //             'Bookmark',
            //             style: TextStyle(
            //                 color: Colors.purple,
            //                 fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //         PopupMenuItem(
            //           value: 3,
            //           child: Text(
            //             'Settings',
            //             style: TextStyle(
            //                 color: Colors.purple,
            //                 fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //       ],
            //       onSelected: (value) {
            //         print('You have selected {$value}');
            //       })
            // ]),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Text(
        //           'Drawer Header',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.message),
        //         title: Text('Messages'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.account_circle),
        //         title: Text('Profile'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Settings'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: new Center(
            child: ListView.builder(
                itemCount: mainmenu.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Theme.of(context).primaryColor,
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: index == 0 ? Icon(Icons.contacts, color: Colors.white, size: 30.0,) 
                                : index == 1 ? Icon(Icons.account_balance,  color: Colors.white, size: 30.0,) 
                                : Icon(Icons.water_damage,  color: Colors.white, size: 30.0,),
                        title: Text('${mainmenu[index]}',
                                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                        trailing: Icon(Icons.arrow_right, size: 30.0, color: Colors.white),
                        onTap: () {
                          switch (index){
                            case 0 : Navigator.pushNamed(context ,'/basicform');
                            break;
                            case 1 : Navigator.pushNamed(context ,'/bankform');
                            break;
                            case 2 : Navigator.pushNamed(context ,'/damageform');
                            break;
                            default:
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text("Alert Dialog Box"),
                                content:
                                Text("You have tapped ${mainmenu[index]}"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("okay"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }, //onTap
                      ));
                })),
                bottomNavigationBar: footerBar(context),
                
                );
  }
}

