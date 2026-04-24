import 'package:flutter/material.dart';

class BetslipDrawer extends StatelessWidget {
 const BetslipDrawer({Key? key}) : super(key:key);

 @override
 Widget build(BuildContext context) {

   return Container(
     height:500,
     padding: EdgeInsets.all(20),

     decoration: BoxDecoration(
       color: Color(0xff081f3f),
       borderRadius: BorderRadius.vertical(
         top: Radius.circular(30),
       ),
     ),

     child: Column(
       crossAxisAlignment:
           CrossAxisAlignment.start,

       children: [

         Center(
           child: Container(
             width:70,
             height:5,
             decoration: BoxDecoration(
               color: Colors.white24,
               borderRadius:
                  BorderRadius.circular(8),
             ),
           ),
         ),

         SizedBox(height:25),

         Text(
           "Bet Slip",
           style: TextStyle(
             color: Colors.white,
             fontSize:30,
             fontWeight: FontWeight.bold,
           ),
         ),

         SizedBox(height:30),

         card(
           "Arsenal",
           "Home Win",
           2.35,
         ),

         card(
           "Bayern",
           "Over 2.5",
           1.78,
         ),

         Spacer(),

         TextField(
           style: TextStyle(color: Colors.white),
           decoration: InputDecoration(
             hintText:"Stake",
             hintStyle:
                TextStyle(color:Colors.white54),
             filled:true,
             fillColor: Color(0xff12345f),
           ),
         ),

         SizedBox(height:20),

         Container(
           width:double.infinity,
           height:58,
           child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.orange,
             ),
             onPressed:(){},
             child: Text(
               "Place Bet",
               style: TextStyle(
                 fontSize:20,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
         )
       ],
     ),
   );
 }

 Widget card(
 String team,
 String market,
 double odds,
 ){
   return Container(
     margin:EdgeInsets.only(bottom:14),
     padding:EdgeInsets.all(14),

     decoration: BoxDecoration(
       color:Color(0xff12345f),
       borderRadius:
          BorderRadius.circular(16),
     ),

     child: Row(
       mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

       children: [
         Column(
           crossAxisAlignment:
             CrossAxisAlignment.start,
           children:[
             Text(
               team,
               style:TextStyle(
                 color:Colors.white,
                 fontWeight:
                    FontWeight.bold,
               ),
             ),

             Text(
               market,
               style:TextStyle(
                 color:Colors.white60,
               ),
             ),
           ],
         ),

         Text(
           odds.toString(),
           style:TextStyle(
             color:Colors.orange,
             fontSize:22,
             fontWeight:
               FontWeight.bold,
           ),
         )
       ],
     ),
   );
 }
}