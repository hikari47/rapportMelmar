import 'package:flutter/material.dart';

class EventsBeautyPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
       actions: [
         Expanded(child:  ListTile(
           leading: IconButton(
               onPressed:(){
                 Navigator.pop(context);
               },
               icon:Icon(Icons.arrow_back_ios_sharp)),
           title: Text(
               "GRANDE PROMOTION",
               style: TextStyle(
                 fontSize: 25
               ),),
         ))
       ],
      ),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0),
              width: MediaQuery.of(context).size.width-10,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:Image.asset('assets/imgs/produit_beauty5.jpg',
                  width: MediaQuery.of(context).size.width-30,
                  fit: BoxFit.cover,)
                ,),
            ),
            Container(
                padding: EdgeInsets.only(top: 15),
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      " jnnjnjdndnksskskfsdkfskfksfjksfsfnsfksfnksl"
                          "jsdfsjdfnsnfsknfksnfksnfknskfnskfnksnfksnfk"
                          "fsdkfnslkfnksnfksnfksnkfnskfnskfnksnfksfskfksnfnskfn"
                          "fkdsnfsfnslfnskfslkfnksnfskfnsknfksnfksnfksnfksnfksnfksnfnsf"
                          "fsknfslkfnwfndskfnifklnffnskndsknfnskfnsfnskfnskfns"
                          "sddsdnfdsnfkdsfksfksdnfknsfksfnknfsnfkfnskfskfnskfskfskfn"
                          "sfsfnsdfknsdkfnsdkfnsdkfndskfnsdkfnskfndskfdskfs",
                      softWrap: true,
                    ),
                    Text(
                      "\n jnnjnjdndnksskskfsdkfskfksfjksfsfnsfksfnksl"
                          "jsdfsjdfnsnfsknfksnfksnfknskfnskfnksnfksnfk"
                          "fsdkfnslkfnksnfksnfksnkfnskfnskfnksnfksfskfksnfnskfn"
                          "fkdsnfsfnslfnskfslkfnksnfskfnsknfksnfksnfksnfksnfksnfksnfnsf"
                          "fsknfslkfnwfndskfnifklnffnskndsknfnskfnsfnskfnskfns"
                          "sddsdnfdsnfkdsfksfksdnfknsfksfnknfsnfkfnskfskfnskfskfskfn"
                          "sfsfnsdfknsdkfnsdkfnsdkfndskfnsdkfnskfndskfdskfs",
                      softWrap: true,
                    ),
                    Text(
                      "jnnjnjdndnksskskfsdkfskfksfjksfsfnsfksfnksl"
                          "jsdfsjdfnsnfsknfksnfksnfknskfnskfnksnfksnfk"
                          "fsdkfnslkfnksnfksnfksnkfnskfnskfnksnfksfskfksnfnskfn"
                          "fkdsnfsfnslfnskfslkfnksnfskfnsknfksnfksnfksnfksnfksnfksnfnsf"
                          "fsknfslkfnwfndskfnifklnffnskndsknfnskfnsfnskfnskfns"
                          "sddsdnfdsnfkdsfksfksdnfknsfksfnknfsnfkfnskfskfnskfskfskfn"
                          "sfsfnsdfknsdkfnsdkfnsdkfndskfnsdkfnskfndskfdskfs",
                      softWrap: true,
                    ),
                  ],
                )
            )
          ],
        ),
       )
    );
  }
}