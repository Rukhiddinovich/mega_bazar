import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../util/colors.dart';
import '../model/chat_model.dart';
import '../provider/chat_provider.dart';
import '../provider/login_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "Chat App",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 20.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<LoginProvider>().logOut(context);
              },
              icon: const Icon(Icons.logout, color: Colors.white))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: context.read<ChatProvider>().getMessages(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Data not found",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "Poppins"),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              ...List.generate(snapshot.data!.length, (index) {
                                MessageModel x = snapshot.data[index];
                                return Container(
                                  width: 150.w,
                                  padding: EdgeInsets.all(8.r),
                                  margin: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                      color: AppColors.C_40BFFF,
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        x.message,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                      ),
                                      Text(
                                        x.createdAt
                                            .toString()
                                            .substring(11, 16),
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                            fontFamily: "Poppins"),
                                      ),
                                    ],
                                  ),
                                );
                              })
                            ],
                          )
                        : const Center(
                            child: Text("Data Empty"),
                          );
                  }
                  return const Center(
                    child: Text("Null"),
                  );
                },
              ),
            ),
            TextFormField(
              controller: context.read<ChatProvider>().textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Type...",
                hintStyle: TextStyle(
                    fontSize: 15.sp, color: Colors.grey, fontFamily: "Poppins"),
                suffixIcon: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppColors.C_40BFFF),
                  child: Center(
                    child: ZoomTapAnimation(
                      onTap: () {
                        context.read<ChatProvider>().addmessage(
                              context: context,
                              messageModel: MessageModel(
                                  message: context
                                      .read<ChatProvider>()
                                      .textEditingController
                                      .text,
                                  createdAt: DateTime.now(),
                                  uid: context.read<LoginProvider>().user!.uid,
                                  messageId: ''),
                            );
                        context
                            .read<ChatProvider>()
                            .textEditingController
                            .clear();
                      },
                      child: Icon(Icons.send, color: Colors.black, size: 25.r),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
