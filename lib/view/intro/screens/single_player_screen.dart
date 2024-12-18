import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tic_tac_toe/view_model/cubit/cubit.dart';
import 'package:tic_tac_toe/view_model/utils/colors.dart';

import '../../board/board_screen.dart';


class SinglePlayerScreen extends StatelessWidget {
  const SinglePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueGreyLight,
      appBar: AppBar(
        backgroundColor:AppColor.blueGreyLight,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.keyboard_backspace_rounded,color: Colors.blue,size: 30.r,),
        ),
        centerTitle: true,
        title: RichText(text: TextSpan(
            text: "TIC  ",style: TextStyle(color: AppColor.red,fontSize: 35.sp,
            fontStyle: FontStyle.italic),
            children:const<TextSpan>[
              TextSpan(text: "TAC  ",style: TextStyle(color: AppColor.orangeAccent)),
              TextSpan(text: "TOE",style: TextStyle(color: AppColor.white)),
            ]
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: (){
              GameCubit.get(context).initialEasyMode();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>const BoardScreen(),));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsetsDirectional.all(15.w),
              margin: EdgeInsetsDirectional.all(15.w),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/easy.png",
                  width: 120.w,height: 120.h,fit: BoxFit.fill,),
                  SizedBox(height: 0.02.sh,),

                  Text("E A S Y",style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.sp
                  ),)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              GameCubit.get(context).initialHardMode();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>const BoardScreen(),));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsetsDirectional.all(15.w),
              margin: EdgeInsetsDirectional.all(15.w),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Image.asset("assets/images/hard.png",
                  width: 120.w,height: 120.h,fit: BoxFit.fill,),
                  SizedBox(height: 0.02.sh,),
                  Text("H A R D",style: TextStyle(
                      color: Colors.indigo[800],
                      fontSize: 35.sp
                  ),)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
