const String baseUrl = "https://api.openweathermap.org";

class StatusTextConstants {
  static String addProduct = "add_product";
  static String getProduct = "get_product";
  static String updateProduct = "update_product";
  static String deleteProduct = "delete_product";

  static String addOrder="add_order";
  static String getOrder="get_order";
  static String updateOrder="update_order";
  static String deleteOrder="delete_order";
}

const String adminEmail = "admin@gmail.com";

const defaultImageConstant = "Select Image";

const baseUrlForImage = "http://159.89.98.34:5545";

class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

const String token = "";

// void showDialogGlobal(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text("Error",style: TextStyle(
//             fontFamily: "Poppins",
//             fontWeight: FontWeight.w500,
//             fontSize: 16.sp,
//             color: Colors.black),),
//         content: Text("Please try again",style: TextStyle(
//             fontFamily: "Poppins",
//             fontWeight: FontWeight.w500,
//             fontSize: 16.sp,
//             color: Colors.black),),
//         actions: <Widget>[
//
//           ElevatedButton(
//             child: Text(
//               "OK",
//               style: TextStyle(
//                   fontFamily: "Poppins",
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.sp,
//                   color: Colors.white),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
