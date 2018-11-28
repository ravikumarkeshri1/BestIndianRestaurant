// import 'package:flutter/material.dart';

// import 'package:firebase_database/firebase_database.dart';
// import './add.dart';
// import './home.dart';
// import 'dart:math';
// import './login.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final List<Map<dynamic, dynamic>> fetchedProductList = [];
//   final List<Map<dynamic, dynamic>> fetchListingId = [];
//   String userName,currentImage,email;

//   @override
//   void initState() {
//     super.initState();

//     DatabaseReference ref = FirebaseDatabase.instance.reference();
//     var userRef = ref.child('listing');
//     var reviewRef = ref.child('reviews');
//     userRef.orderByKey().limitToFirst(10).once().then((DataSnapshot snap) {
//       final Map<dynamic, dynamic> productListData = snap.value;
//       double costRating = 0.0,
//           foodRating = 0.0,
//           serviceRating = 0.0,
//           overAllRating = 0.0;
        
          
//       productListData.forEach((dynamic listingId, dynamic productData) {
//         // fetchedProductList.add(productData);
//         int sumCost = 0, sumFood = 0, sumService = 0;
//         int count = 0;
//         reviewRef
//             .orderByChild('listing_id')
//             .equalTo(listingId.toString())
//             .once()
//             .then((DataSnapshot snapreview) {
//           final Map<dynamic, dynamic> reviewListData = snapreview.value;

//           reviewListData.forEach((dynamic reviewid, dynamic reviewData) {
//             sumCost = sumCost + reviewData['cost'];
//             sumFood = sumFood + reviewData['food'];
//             sumService = sumService + reviewData['service'];
//             count = count + 1;

//             fetchListingId.add(reviewData);
//           });
//           costRating = sumCost / count;
//           costRating = num.parse(costRating.toStringAsFixed(1));
//           foodRating = sumFood / count;
//           foodRating = num.parse(foodRating.toStringAsFixed(1));
//           serviceRating = sumService / count;
//           serviceRating = num.parse(serviceRating.toStringAsFixed(1));
//           overAllRating = (costRating + foodRating + foodRating) / 3;
//           overAllRating = num.parse(overAllRating.toStringAsFixed(1));
//           productData['listingId'] = listingId;
//           productData['costRating'] = costRating;
//           productData['foodRating'] = foodRating;
//           productData['serviceRating'] = serviceRating;
//           productData['overAllRating'] = overAllRating;
//            print("testing..............................................");
//            print(listingId);
//      print(fetchedProductList[0]['name']);
//       print(fetchedProductList[0]['overAllRating']);
         

//         });
       
//         fetchedProductList.add(productData);
//       });
//      print("testing..............................................");
//      print(fetchedProductList[0]);
//       //int i,j;
//       // for(i=0;i<fetchedProductList.length;i++){
//       //     for(j=0;j<fetchedProductList.length;j++){
//       //       if(fetchedProductList['overAllRating']>)

//       //     }
//       // }
//     });
  
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         '/login': (BuildContext context) => LoginPage(fetchedProductList, fetchListingId,userName),
//         '/': (BuildContext context) =>
//             HomePage(fetchedProductList, fetchListingId,userName,currentImage,email),
//         '/add': (BuildContext context) => AddPage()
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import './ui/listview_note.dart';

void main() => runApp(
  MaterialApp(
    title: 'Returning Data',
    home: ListViewNote('Sign In',''),
  ),
);