import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Detail Screen",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              fontFamily: "Poppins",
              color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [

        ],
      ),
    );
  }
}
